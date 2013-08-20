# Class: mailserver
#
# This module manages Linux/Unix mailserver.
#
# Parameters:
#
# There are no default parameters for this class. All module parameters are managed
# via the mailserver::params class
#
# Actions:
#
# Requires:
#  puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
#
#  Packaged mailserver
#    - RHEL: EPEL or custom package
#    - Debian/Ubuntu: Default Install or custom package
#    - SuSE: Default Install or custom package
#
#  stdlib
#    - puppetlabs-stdlib module >= 0.1.6
#    - plugin sync enabled to obtain the anchor type
#
# Sample Usage:
#
# The module works with sensible defaults:
#
# node default {
#   include mailserver
# }

class mailserver (
  $worker_processes       = $mailserver::params::nx_worker_processes,
  $worker_connections     = $mailserver::params::nx_worker_connections,
  $proxy_set_header       = $mailserver::params::nx_proxy_set_header,
  $proxy_http_version     = $mailserver::params::nx_proxy_http_version,
  $confd_purge            = $mailserver::params::nx_confd_purge,
  $proxy_cache_path       = $mailserver::params::nx_proxy_cache_path,
  $proxy_cache_levels     = $mailserver::params::nx_proxy_cache_levels,
  $proxy_cache_keys_zone  = $mailserver::params::nx_proxy_cache_keys_zone,
  $proxy_cache_max_size   = $mailserver::params::nx_proxy_cache_max_size,
  $proxy_cache_inactive   = $mailserver::params::nx_proxy_cache_inactive,
  $configtest_enable      = $mailserver::params::nx_configtest_enable,
  $service_restart        = $mailserver::params::nx_service_restart,
  $mail                   = $mailserver::params::nx_mail,
  $server_tokens          = $mailserver::params::nx_server_tokens,
  $http_cfg_append        = $mailserver::params::nx_http_cfg_append,
  $mailserver_vhosts           = {},
  $mailserver_upstreams        = {},
  $mailserver_locations        = {},
) inherits mailserver::params {

  include stdlib

  class { 'mailserver::package':
    notify => Class['mailserver::service'],
  }

  class { 'mailserver::config':
    worker_processes      => $worker_processes,
    worker_connections    => $worker_connections,
    proxy_set_header      => $proxy_set_header,
    proxy_http_version    => $proxy_http_version,
    proxy_cache_path      => $proxy_cache_path,
    proxy_cache_levels    => $proxy_cache_levels,
    proxy_cache_keys_zone => $proxy_cache_keys_zone,
    proxy_cache_max_size  => $proxy_cache_max_size,
    proxy_cache_inactive  => $proxy_cache_inactive,
    confd_purge           => $confd_purge,
    server_tokens         => $server_tokens,
    http_cfg_append       => $http_cfg_append,
    require               => Class['mailserver::package'],
    notify                => Class['mailserver::service'],
  }

  class { 'mailserver::service':
    configtest_enable => $configtest_enable,
    service_restart   => $service_restart,
  }

  validate_hash($mailserver_upstreams)
  create_resources('mailserver::resource::upstream', $mailserver_upstreams)
  validate_hash($mailserver_vhosts)
  create_resources('mailserver::resource::vhost', $mailserver_vhosts)
  validate_hash($mailserver_locations)
  create_resources('mailserver::resource::location', $mailserver_locations)

  # Allow the end user to establish relationships to the "main" class
  # and preserve the relationship to the implementation classes through
  # a transitive relationship to the composite class.
  anchor{ 'mailserver::begin':
    before => Class['mailserver::package'],
    notify => Class['mailserver::service'],
  }
  anchor { 'mailserver::end':
    require => Class['mailserver::service'],
  }
}