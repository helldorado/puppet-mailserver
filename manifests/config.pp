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
  $postfix_confd_purge                    = $mailserver::params::postfix_confd_purge,
  $postfix_submission                     = $mailserver::params::postfix_submission,
  $postix_postcreen_rbl_check             = $mailserver::params::postix_postcreen_rbl_check,
  $postfix_headers_check                  = $mailserver::params::postfix_headers_check,
  $postfix_body_check                     = $mailserver::params::postfix_body_check,
  $postfix_mime_check                     = $mailserver::params::postfix_mime_check,
  $postfix_mydomain                       = $mailserver::params::postfix_mydomain,
  $postfix_myhostname                     = $mailserver::params::postfix_myhostname,
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
  $dovecot_confd_purge                    = $mailserver::params::dovecot_confd_purge,
  $dovecot_quota                          = $mailserver::params::dovecot_quota,
  $dovecot_quota_warning                  = $mailserver::params::dovecot_quota_warning,
  $dovecot_quota_warning_message          = $mailserver::params::dovecot_quota_warning_message,
  $dovecot_disable_plaintext_auth         = $mailserver::params::dovecot_disable_plaintext_auth,
  $dovecot_log_timestamp                  = $mailserver::params::dovecot_log_timestamp,
  $dovecot_vmail_homedir                  = $mailserver::params::dovecot_vmail_homedir,
  $dovecot_mail_location_suffix           = $mailserver::params::dovecot_mail_location_suffix,
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
  $dovecot_lda_mail_plugins               = $mailserver::params::dovecot_lda_mail_plugins,
  $dovecot_lda_postmaster                 = $mailserver::params::dovecot_lda_postmaster,
  $dovecot_lda_quota_full_tempfail        = $mailserver::params::dovecot_lda_quota_full_tempfail,
  $dovecot_lmtp_mail_plugins              = $mailserver::params::dovecot_lmtp_mail_plugins,
  $dovecot_lmtp_postmaster                = $mailserver::params::dovecot_lmtp_postmaster,
  $dovecot_lmtp_quota_full_tempfail       = $mailserver::params::dovecot_lmtp_quota_full_tempfail,
  $dovecot_managesieve_notify_capability  = $mailserver::params::dovecot_managesieve_notify_capability,
) inherits mailserver::params {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { $mailserver::params::postfix_conf_dir:
    ensure => directory,
  }
  
  file { $mailserver::params::dovecot_conf_dir:
    ensure => directory,
  }
    
  file { "$mailserver::params::dovecot_conf_dir/conf.d":
    ensure => directory,
  }
  
  if $mailserver_with_amavis == true {
     file { $mailserver::params::amavisd_conf_dir:
         ensure => directory,
     }
  
     file { "$mailserver::params::amavisd_conf_dir/conf.d":
         ensure => directory,
     }
  
     file { $mailserver::params::clamav_conf_dir:
         ensure => directory,
     }
  }
  
  file { $mailserver::params::spamassassin_conf_dir:
    ensure => directory,
  }

  file { "${mailserver::params::postfix_conf_dir}/main.cf":
    ensure  => file,
    content => template('mailserver/postfix/main.cf.erb'),
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