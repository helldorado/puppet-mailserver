# Class: mailserver::package
#
# This module manages mailserver package installation
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
class mailserver::package(
  $packages_list   = undef,
  $packages_ensure = 'present',
) {
  anchor { 'mailserver::package::begin': }
  anchor { 'mailserver::package::end': }

  case $::osfamily {
    'redhat': {
      class { 'mailserver::package::redhat':
        packages_list   => $packages_list,
        packages_ensure => 'present',
        require => Anchor['mailserver::package::begin'],
        before  => Anchor['mailserver::package::end'],
      }
    }
    'debian': {
      class { 'mailserver::package::debian':
        packages_list   => $packages_list,
        packages_ensure => 'present',
        require => Anchor['mailserver::package::begin'],
        before  => Anchor['mailserver::package::end'],
      }
    }
    'suse': {
      class { 'mailserver::package::suse':
        packages_list   => $packages_list,
        packages_ensure => 'present',
        require => Anchor['mailserver::package::begin'],
        before  => Anchor['mailserver::package::end'],
      }
    }
    default: {
      case $::operatingsystem {
        'amazon': {
          # Amazon was added to osfamily RedHat in 1.7.2
          # https://github.com/puppetlabs/facter/commit/c12d3b6c557df695a7b2b009da099f6a93c7bd31#lib/facter/osfamily.rb
          warning("Module ${module_name} support for ${::operatingsystem} with facter < 1.7.2 is deprecated")
          warning("Please upgrade from facter ${::facterversion} to >= 1.7.2")
          class { 'mailserver::package::redhat':
            packages_list   => $packages_list,
            packages_ensure => 'present',
            require => Anchor['mailserver::package::begin'],
            before  => Anchor['mailserver::package::end'],
          }
        }
        default: {
          fail("Module ${module_name} is not supported on ${::operatingsystem}")
        }
      }
    }
  }
}