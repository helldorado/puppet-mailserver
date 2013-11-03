# Class: mailserver::service
#
# This module manages mailserver service management and vhost rebuild
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class mailserver::service(
  $configtest_enable = $mailserver::params::nx_configtest_enable,
  $service_restart   = $mailserver::params::nx_service_restart
) {
  exec { 'rebuild-mailserver-vhosts':
    command     => "/bin/cat ${mailserver::params::nx_temp_dir}/mailserver.d/* > ${mailserver::params::nx_conf_dir}/conf.d/vhost_autogen.conf",
    refreshonly => true,
    unless      => "/usr/bin/test ! -f ${mailserver::params::nx_temp_dir}/mailserver.d/*",
    subscribe   => File["${mailserver::params::nx_temp_dir}/mailserver.d"],
  }
  exec { 'rebuild-mailserver-mailhosts':
    command     => "/bin/cat ${mailserver::params::nx_temp_dir}/mailserver.mail.d/* > ${mailserver::params::nx_conf_dir}/conf.mail.d/vhost_autogen.conf",
    refreshonly => true,
    unless      => "/usr/bin/test ! -f ${mailserver::params::nx_temp_dir}/mailserver.mail.d/*",
    subscribe   => File["${mailserver::params::nx_temp_dir}/mailserver.mail.d"],
  }
  service { 'mailserver':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => Exec['rebuild-mailserver-vhosts', 'rebuild-mailserver-mailhosts'],
  }
  if $configtest_enable == true {
    Service['mailserver'] {
      restart => $service_restart,
    }
  }
}