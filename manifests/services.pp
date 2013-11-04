# Class: mailserver::service
#
# This module manages mailserver service management and conf file rebuild
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
  $configtest_enable = $mailserver::params::mailserver_configtest_enable,
  $service_restart   = $mailserver::params::mailserver_service_restart
) {
  exec { 'rebuild-mailserver-postfix':
    command     => "/bin/cp -ra ${mailserver::params::mailserver_temp_dir}/postfix/* ${mailserver::params::postfix_conf_dir}/",
    refreshonly => true,
    unless      => "/usr/bin/test ! -f ${mailserver::params::mailserver_temp_dir}/postfix/*",
    subscribe   => File["${mailserver::params::mailserver_temp_dir}/postfix/"],
  }
  
  if $mailserver::params::mailserver_with_amavis == true {
    exec { 'rebuild-mailserver-amavisd':
      command     => "/bin/cp -ra ${mailserver::params::mailserver_temp_dir}/amavisd/* ${mailserver::params::amavisd_conf_dir}/",
      refreshonly => true,
      unless      => "/usr/bin/test ! -f ${mailserver::params::mailserver_temp_dir}/amavisd/*",
      subscribe   => File["${mailserver::params::mailserver_temp_dir}/amavisd/"],
    }
  
    exec { 'rebuild-mailserver-clamav':
      command     => "/bin/cp -ra ${mailserver::params::mailserver_temp_dir}/clamav/* ${mailserver::params::clamav_conf_dir}/",
      refreshonly => true,
      unless      => "/usr/bin/test ! -f ${mailserver::params::mailserver_temp_dir}/clamav/*",
      subscribe   => File["${mailserver::params::mailserver_temp_dir}/clamav/"],
    }
  }
 
  exec { 'rebuild-mailserver-spamassassin':
    command     => "/bin/cp -ra ${mailserver::params::mailserver_temp_dir}/spamassassin/* ${mailserver::params::spamassassin_conf_dir}/",
    refreshonly => true,
    unless      => "/usr/bin/test ! -f ${mailserver::params::mailserver_temp_dir}/spamassassin/*",
    subscribe   => File["${mailserver::params::mailserver_temp_dir}/spamassassin/"],
  }
  
  exec { 'rebuild-mailserver-dovecot':
    command     => "/bin/cp -ra ${mailserver::params::mailserver_temp_dir}/dovecot/* ${mailserver::params::dovecot_conf_dir}/",
    refreshonly => true,
    unless      => "/usr/bin/test ! -f ${mailserver::params::mailserver_temp_dir}/dovecot/*",
    subscribe   => File["${mailserver::params::mailserver_temp_dir}/dovecot/"],
  }
  
  service { 'mailserver':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => Exec['rebuild-mailserver-postfix', 'rebuild-mailserver-amavisd', 'rebuild-mailserver-clamav', 'rebuild-mailserver-spamassassin', 'rebuild-mailserver-dovecot'],
  }
  
  if $configtest_enable == true {
    Service['mailserver'] {
      restart => $service_restart,
    }
  }
}