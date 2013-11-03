# Class: mailserver::package::debian
#
# This module manages mailserver package installation on Redhat based systems
#
# Parameters:
#
# There are no default parameters for this class.
#
# Action s:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class mailserver::package::redhat (
  $packages_list   = undef,
  $packages_ensure = 'present',
) {
  $operatingsystem_lowercase = inline_template('<%= @operatingsystem.downcase %>')

  $redhat_packages = $packages_list
  package { '$redhat_packages':
    ensure  => present,
    require => Exec['apt_get_update'],
  }

  file { '/usr/share/roundcube':
    ensure  => directory,
    mode    => '0755',
    require => Exec['download_roundcube'],
  }
  
  file { '/usr/share/postfixadmin':
    ensure  => directory,
    mode    => '0755',
    require => Exec['download_postfixadmin'],
  }
  
  exec { 'download_roundcube':
    command   => '/usr/bin/wget $roundcube_download_url|tar xzf - && mv roundcubemail-0.9.3 roundcubemail',
    cwd       => "/usr/share/",
    creates => "/usr/share/roundcubemail",
    timeout => 6000,
  }
  
  exec { 'download_roundcube':
    command   => '/usr/bin/wget $postfixadmin_download_url|tar xzf -',
    cwd       => "/usr/share/",
    creates => "/usr/share/postfixadmin",
  }
  
  exec { 'apt_get_update':
    command     => '/usr/bin/apt-get update',
    timeout     => 240,
    returns     => [ 0, 100 ],
    refreshonly => true,
  }
}