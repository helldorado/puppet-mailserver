# Class: mailserver::config
#
# This module manages mailserver bootstrap and configuration
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
class mailserver::config(
  $worker_processes       = $mailserver::params::nx_worker_processes,
  $worker_connections     = $mailserver::params::nx_worker_connections,
  $confd_purge            = $mailserver::params::nx_confd_purge,
  $server_tokens          = $mailserver::params::nx_server_tokens,
  $proxy_set_header       = $mailserver::params::nx_proxy_set_header,
  $proxy_cache_path       = $mailserver::params::nx_proxy_cache_path,
  $proxy_cache_levels     = $mailserver::params::nx_proxy_cache_levels,
  $proxy_cache_keys_zone  = $mailserver::params::nx_proxy_cache_keys_zone,
  $proxy_cache_max_size   = $mailserver::params::nx_proxy_cache_max_size,
  $proxy_cache_inactive   = $mailserver::params::nx_proxy_cache_inactive,
  $proxy_http_version     = $mailserver::params::nx_proxy_http_version,
  $types_hash_max_size    = $mailserver::params::nx_types_hash_max_size,
  $types_hash_bucket_size = $mailserver::params::nx_types_hash_bucket_size,
  $http_cfg_append        = $mailserver::params::nx_http_cfg_append
) inherits mailserver::params {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { $mailserver::params::nx_conf_dir:
    ensure => directory,
  }

  file { "${mailserver::params::nx_conf_dir}/conf.d":
    ensure => directory,
  }
  if $confd_purge == true {
    File["${mailserver::params::nx_conf_dir}/conf.d"] {
      ignore  => 'vhost_autogen.conf',
      purge   => true,
      recurse => true,
    }
  }

  file { "${mailserver::params::nx_conf_dir}/conf.mail.d":
    ensure => directory,
  }
  if $confd_purge == true {
    File["${mailserver::params::nx_conf_dir}/conf.mail.d"] {
      ignore  => 'vhost_autogen.conf',
      purge   => true,
      recurse => true,
    }
  }

  file {$mailserver::config::postfix_conf_dir:
    ensure => directory,
  }

  file {$mailserver::config::postfix_client_body_temp_path:
    ensure => directory,
    owner  => $mailserver::params::nx_daemon_user,
  }

  file {$mailserver::config::nx_proxy_temp_path:
    ensure => directory,
    owner  => $mailserver::params::nx_daemon_user,
  }

  file { '/etc/mailserver/sites-enabled/default':
    ensure => absent,
  }

  file { "${mailserver::params::nx_conf_dir}/mailserver.conf":
    ensure  => file,
    content => template('mailserver/conf.d/mailserver.conf.erb'),
  }

  file { "${mailserver::params::nx_conf_dir}/conf.d/proxy.conf":
    ensure  => file,
    content => template('mailserver/conf.d/proxy.conf.erb'),
  }

  file { "${mailserver::config::nx_temp_dir}/mailserver.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
  }

  file { "${mailserver::config::nx_temp_dir}/mailserver.mail.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
  }
}