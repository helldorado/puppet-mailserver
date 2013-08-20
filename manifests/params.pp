# Class: mailserver::param
#
# This module manages MAILSERVER paramaters
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
class mailserver::params {
  $nx_temp_dir                = '/tmp'
  $nx_run_dir                 = '/var/mailserver'

  $nx_conf_dir                = '/etc/mailserver'
  $nx_confd_purge             = false
  $nx_worker_processes        = 1
  $nx_worker_connections      = 1024
  $nx_types_hash_max_size     = 1024
  $nx_types_hash_bucket_size  = 512
  $nx_names_hash_bucket_size  = 64
  $nx_multi_accept            = off
# One of [kqueue|rtsig|epoll|/dev/poll|select|poll|eventport]
# or false to use OS default
  $nx_events_use              = false
  $nx_sendfile                = on
  $nx_keepalive_timeout       = 65
  $nx_tcp_nodelay             = on
  $nx_gzip                    = on
  $nx_server_tokens           = on
  $nx_spdy                    = off
  $nx_ssl_stapling            = off


  $nx_proxy_redirect          = off
  $nx_proxy_set_header        = [
    'Host $host',
    'X-Real-IP $remote_addr',
    'X-Forwarded-For $proxy_add_x_forwarded_for',
  ]
  $nx_proxy_cache_path        = false
  $nx_proxy_cache_levels      = 1
  $nx_proxy_cache_keys_zone   = 'd2:100m'
  $nx_proxy_cache_max_size    = '500m'
  $nx_proxy_cache_inactive    = '20m'

  $nx_client_body_temp_path   = "${nx_run_dir}/client_body_temp"
  $nx_client_body_buffer_size = '128k'
  $nx_client_max_body_size    = '10m'
  $nx_proxy_temp_path         = "${nx_run_dir}/proxy_temp"
  $nx_proxy_connect_timeout   = '90'
  $nx_proxy_send_timeout      = '90'
  $nx_proxy_read_timeout      = '90'
  $nx_proxy_buffers           = '32 4k'
  $nx_proxy_http_version      = '1.0'

  $nx_logdir = $::kernel ? {
    /(?i-mx:linux)/ => '/var/log/mailserver',
  }

  $nx_pid = $::kernel ? {
    /(?i-mx:linux)/  => '/var/run/mailserver.pid',
  }

  $nx_daemon_user = $::operatingsystem ? {
    /(?i-mx:debian|ubuntu)/                                                    => 'www-data',
    /(?i-mx:fedora|rhel|redhat|centos|scientific|suse|opensuse|amazon|gentoo)/ => 'mailserver',
  }

  # Service restart after mailserver 0.7.53 could also be just
  # "/path/to/mailserver/bin -s HUP" Some init scripts do a configtest, some don't.
  # If configtest_enable it's true then service restart will take
  # $nx_service_restart value, forcing configtest.

  $nx_configtest_enable = false
  $nx_service_restart = '/etc/init.d/mailserver configtest && /etc/init.d/mailserver restart'

  $nx_mail = false

  $nx_http_cfg_append = false

}