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
  $postfix_conf_dir                       = $mailserver::params::postfix_conf_dir,
  $postfix_confd_purge                    = $mailserver::params::postfix_confd_purge,
  $postfix_smtpd_tls                      = $mailserver::params::postfix_smtpd_tls,
  $postfix_smtpd_sasl_auth                = $mailserver::params::postfix_smtpd_sasl_auth,
  $postfix_submission                     = $mailserver::params::postfix_submission,
  $postix_rbl_check                       = $mailserver::params::postix_rbl_check,
  $postfix_headers_check                  = $mailserver::params::postfix_headers_check,
  $postfix_body_check                     = $mailserver::params::postfix_body_check,
  $postfix_mime_check                     = $mailserver::params::postfix_mime_check,
  $postfix_db_name                        = $mailserver::params::postfix_db_name,
  $postfix_db_user                        = $mailserver::params::postfix_db_user,
  $postfix_db_password                    = $mailserver::params::postfix_db_password,
  $postfix_mydomain                       = $mailserver::params::postfix_mydomain,
  $postfix_myhostname                     = $mailserver::params::postfix_myhostname,
  $postfix_logdir                         = $mailserver::params::postfix_logdir,
  $postfix_pid                            = $mailserver::params::postfix_pid,
  $postfix_configtest_enable              = $mailserver::params::postfix_configtest_enable,
  $postfix_service_restart                = $mailserver::params::postfix_service_restart,
  $pfa_home_dir                           = $mailserver::params::postfix_admin_home_dir,
  $pfa_conf_file                          = $mailserver::params::postfix_admin_conf_file,
  $pfa_apache_conf                        = $mailserver::params::postfix_admin_apache_conf,
  $pfa_db_name                            = $mailserver::params::postfix_admin_db_name,
  $pfa_db_user                            = $mailserver::params::postfix_admin_db_user,
  $pfa_db_password                        = $mailserver::params::postfix_admin_db_password,
  $pfa_plugins                            = $mailserver::params::postfix_admin_plugins,
  $pfa_setup_password                     = $mailserver::params::postfix_admin_setup_password,
  $pfa_admin_url                          = $mailserver::params::postfix_admin_admin_url,
  $pfa_default_language                   = $mailserver::params::postfix_admin_default_language,
  $pfa_admin_email                        = $mailserver::params::postfix_admin_admin_email,
  $pfa_generate_password                  = $mailserver::params::postfix_admin_generate_password,
  $pfa_show_password                      = $mailserver::params::postfix_admin_show_password,
  $pfa_page_size                          = $mailserver::params::postfix_admin_page_size,
  $pfa_domain_path                        = $mailserver::params::postfix_admin_domain_path,
  $pfa_domain_in_mailbox                  = $mailserver::params::postfix_admin_domain_in_mailbox,
  $pfa_vacation                           = $mailserver::params::postfix_admin_vacation,
  $pfa_vacation_domain                    = $mailserver::params::postfix_admin_vacation_domain,  
  $pfa_quota                              = $mailserver::params::postfix_admin_quota,
  $pfa_alias_control                      = $mailserver::params::postfix_admin_alias_control,
  $pfa_alias_control_admin                = $mailserver::params::postfix_admin_alias_control_admin,
  $pfa_default_aliases                    = $mailserver::params::postfix_admin_default_aliases,
  $dovecot_conf_dir                       = $mailserver::params::dovecot_conf_dir,
  $dovecot_confd_purge                    = $mailserver::params::dovecot_confd_purge,
  $dovecot_base_dir                       = $mailserver::params::dovecot_base_dir,
  $dovecot_quota                          = $mailserver::params::dovecot_quota,
  $dovecot_quota_warning                  = $mailserver::params::dovecot_quota_warning,
  $dovecot_quota_warning_message          = $mailserver::params::dovecot_quota_warning_message,
  $dovecot_disable_plaintext_auth         = $mailserver::params::dovecot_disable_plaintext_auth,
  $dovecot_log_timestamp                  = $mailserver::params::dovecot_log_timestamp,
  $dovecot_vmail_homedir                  = $mailserver::params::dovecot_vmail_homedir,
  $dovecot_mail_location_suffix           = $mailserver::params::dovecot_mail_location_suffix,
  $dovecot_mail_uid                       = $mailserver::params::dovecot_mail_uid,
  $dovecot_mail_gid                       = $mailserver::params::dovecot_mail_gid,
  $dovecot_mail_plugins                   = $mailserver::params::dovecot_mail_plugins,
  $dovecot_imap_mail_plugins              = $mailserver::params::dovecot_imap_mail_plugins,
  $dovecot_imap_client_workarounds        = $mailserver::params::dovecot_imap_client_workarounds,
  $dovecot_imap_max_line_length           = $mailserver::params::dovecot_imap_max_line_length,
  $dovecot_mail_max_userip_connections    = $mailserver::params::dovecot_mail_max_userip_connections,
  $dovecot_pop3_mail_plugins              = $mailserver::params::dovecot_pop3_mail_plugins,
  $dovecot_pop3_client_workarounds        = $mailserver::params::dovecot_pop3_client_workarounds,
  $dovecot_pop3_uidl_format               = $mailserver::params::dovecot_pop3_uidl_format,
  $dovecot_managesieve_logout_format      = $mailserver::params::dovecot_managesieve_logout_format,
  $dovecot_mail_log_events                = $mailserver::params::dovecot_mail_log_events,
  $dovecot_mail_log_fields                = $mailserver::params::dovecot_mail_log_fields,
  $dovecot_zlib_save_level                = $mailserver::params::dovecot_zlib_save_level,
  $dovecot_zlib_save                      = $mailserver::params::dovecot_zlib_save,
  $dovecot_protocols                      = $mailserver::params::dovecot_protocols,
  $dovecot_mail_privileged_group          = $mailserver::params::dovecot_mail_privileged_group,
  $dovecot_lda_mail_plugins               = $mailserver::params::dovecot_lda_mail_plugins,
  $dovecot_lda_postmaster                 = $mailserver::params::dovecot_lda_postmaster,
  $dovecot_lda_syslog_facility            = $mailserver::params::dovecot_lda_syslog_facility,
  $dovecot_lda_quota_full_tempfail        = $mailserver::params::dovecot_lda_quota_full_tempfail,
  $dovecot_lmtp_mail_plugins              = $mailserver::params::dovecot_lmtp_mail_plugins,
  $dovecot_lmtp_postmaster                = $mailserver::params::dovecot_lmtp_postmaster,
  $dovecot_lmtp_quota_full_tempfail       = $mailserver::params::dovecot_lmtp_quota_full_tempfail,
  $dovecot_managesieve_notify_capability  = $mailserver::params::dovecot_managesieve_notify_capability,
  

  $mailserver_vhosts                     = {},
  $mailserver_upstreams                  = {},
  $mailserver_locations                  = {},
) inherits mailserver::params {

 include stdlib
 
 
 class { 'mailserver::package':
    package_name   => $package_name,
    package_source => $package_source,
    package_ensure => $package_ensure,
    notify      => Class['mailserver::package::service'],
    manage_repo => $manage_repo,
  }

  class { 'mailserver::package':
    notify => Class['mailserver::service'],
  }

  class { 'mailserver::config':
    
    proxy_http_version                   => $proxy_http_version,
    proxy_cache_path                     => $proxy_cache_path,
    proxy_cache_levels                   => $proxy_cache_levels,
    proxy_cache_keys_zone                => $proxy_cache_keys_zone,
    proxy_cache_max_size                 => $proxy_cache_max_size,
    proxy_cache_inactive                 => $proxy_cache_inactive,
    confd_purge                          => $confd_purge,
    server_tokens                        => $server_tokens,
    http_cfg_append                      => $http_cfg_append,
    require                              => Class['mailserver::package'],
    notify                               => Class['mailserver::service'],
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