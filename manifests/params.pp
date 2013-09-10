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
  ## Postfix 
  $postfix_conf_dir                      = '/etc/postfix'
  $postfix_confd_purge                   = false
  $postfix_smtpd_tls                     = true
  $postfix_smtpd_sasl_auth               = true
  $postfix_submission                    = true
  $postix_rbl_check                      = true
  $postfix_headers_check                 = true
  $postfix_body_check                    = true
  $postfix_mime_check                    = true
  $postfix_db_name                       = 'postfix'
  $postfix_db_user                       = 'postfix'
  $postfix_db_password                   = undef
  $postfix_mydomain                      = undef
  $postfix_myhostname                    = undef
  $postfix_admin_home_dir                = '/usr/share/postfixadmin'
  $postfix_admin_conf_file               = '${postfix_admin_dir}/config.inc.php'
  $postfix_admin_apache_conf             = '/etc/apache2/conf.d/postfixadmin.conf'
  $postfix_admin_db_name                 = 'posfixadmin'
  $postfix_admin_db_user                 = 'postfixadmin'
  $postfix_admin_db_password             = undef
  $postfix_admin_plugins                 = undef
  $postfix_admin_setup_password          = undef
  $postfix_admin_admin_url               = '/postfixadmin'
  $postfix_admin_default_language        = 'en'
  $postfix_admin_admin_email             = 'postmaster@${postfix_mydomain}'
  $postfix_admin_generate_password       = false
  $postfix_admin_show_password           = false
  $postfix_admin_page_size               = 10
  $postfix_admin_domain_path             = true
  $postfix_admin_domain_in_mailbox       = false
  $postfix_admin_vacation                = true
  $postfix_admin_vacation_domain         = 'autoreply@${postfix_mydomain}'  
  $postfix_admin_quota                   = true
  $postfix_admin_alias_control           = true
  $postfix_admin_alias_control_admin     = true
  $postfix_admin_default_aliases         = [
     'abuse      => abuse@${domain}',
     'hostmaster => hostmaster@${domain}',
     'postmaster => postmaster@${domain}',
     'webmaster  => webmaster@${domain}',
  ] 
    
  $postfix_logdir = $::kernel ? {
    /(?i-mx:linux)/ => '/var/log/',
  }

  $postfix_pid = $::kernel ? {
    /(?i-mx:linux)/  => '/var/spool/postfix/pid/master.pid',
  }
  
  $postfix_configtest_enable = false
  $postfix_service_restart = $::operatingsystem ? {
    /(?i-mx:debian|ubuntu)/                                                    => '/etc/init.d/postfix check && /etc/init.d/postfix restart',
    /(?i-mx:fedora|rhel|redhat|centos|scientific|suse|opensuse|amazon|gentoo)/ => '/sbin/service postfix check && /sbin/service postfix restart',
  }

  ## Dovecot
  $dovecot_conf_dir                       = '/etc/dovecot'
  $dovecot_confd_purge                    = false
  $dovecot_base_dir                       = '/var/run/dovecot'
  $dovecot_quota                          = true
  $dovecot_quota_warning                  = '85%'
  $dovecot_quota_warning_message          = undef
  $dovecot_disable_plaintext_auth         = true
  $dovecot_log_timestamp                  = '"%Y-%m-%d %H:%M:%S"'
  $dovecot_vmail_homedir                  = undef
  $dovecot_mail_location_suffix           = '%u'
  $dovecot_mail_uid                       = 'vmail'
  $dovecot_mail_gid                       = 'vmail'
  $dovecot_mail_plugins                   = 'quota fts fts_solr acl zlib mail_log notify'
  $dovecot_imap_mail_plugins              = 'quota imap_quota acl imap_acl autocreate mail_log notify zlib'
  $dovecot_imap_client_workarounds        = 'delay-newmail'
  $dovecot_imap_max_line_length           = 65536
  $dovecot_mail_max_userip_connections    = 20
  $dovecot_pop3_mail_plugins              = 'quota zlib mail_log notify'
  $dovecot_pop3_client_workarounds        = 'outlook-no-nuls oe-ns-eoh'
  $dovecot_pop3_uidl_format               = '%08Xu%08Xv'
  $dovecot_managesieve_logout_format      = 'bytes ( in=%i : out=%o )'
  $dovecot_mail_log_events                = 'delete undelete expunge copy mailbox_delete mailbox_rename save mailbox_create'
  $dovecot_mail_log_fields                = 'mail_log_fields'
  $dovecot_zlib_save_level                = 9
  $dovecot_zlib_save                      = 'bz2'
  $dovecot_protocols                      = 'imap pop3 sieve lmtp'
  $dovecot_mail_privileged_group          = 'vmail'
  $dovecot_lda_mail_plugins               = 'sieve quota zlib mail_log notify'
  $dovecot_lda_postmaster                 = undef
  $dovecot_lda_syslog_facility            = 'mail'
  $dovecot_lda_quota_full_tempfail        = true
  $dovecot_lmtp_mail_plugins              = 'sieve quota fts zlib mail_log notify'
  $dovecot_lmtp_postmaster                = undef
  $dovecot_lmtp_quota_full_tempfail       = true
  $dovecot_managesieve_notify_capability  = 'comparator-i;octet comparator-i;ascii-casemap fileinto reject envelope encoded-character vacation subaddress comparator-i;ascii-numeric relational regex imap4flags copy include variables body enotify environment mailbox date spamtest spamtestplus virustest'
  
  ## Amavisd
  $amavisd_conf_dir                       = '/etc/amavis'
  $amavisd_confd_purge                    = false
  $amavisd_uid                            = 1002
  $amavisd_gid                            = 1002
  $amavisd_max_servers                    = 2
  $amavisd_daemon_user                    = 'amavis'
  $amavisd_daemon_group                   = 'amavis'
  $amavisd_db_storage                     = undef
  $amavisd_tmp_storage                    = undef
  $amavisd_mydomain                       = '${postfix_mydomain}'
  $amavisd_myhostname                     = '${postfix_myhostname}'
  $amavisd_myhome                         = '/var/amavis' 
  $amavisd_tempbase                       = '$MYHOME/tmp'
  $amavisd_quarantine_dir                 = '${dovecot_vmail_homedir}/virusmails'
  $amavisd_x_header_tag                   = 'X-Virus-Scanned'       
  $amavisd_x_header_line                  = 'Mailstorm at $mydomain'
  $amavisd_log_level                      = 2              
  $amavisd_log_recip_templ                = undef    
  $amavisd_do_syslog                      = 1              
  $amavisd_syslog_facility                = 'mail'  
  $amavisd_syslog_priority                = 'debug'  
  $amavisd_enable_db                      = 1              
  $amavisd_enable_global_cache            = 1    
  $amavisd_nanny_details_level            = 2    
  $amavisd_enable_dkim_verification       = 1
  $amavisd_enable_dkim_signing            = 1
  $amavisd_plugin                         = undef
  $amavisd_plugin_enabled                 = ['
    policyd                             
  ']
   
  ## Spamassassin
  $spamassassin_conf_dir                             = '/etc/spamassassin'
  $spamassassin_confd_purge                          = false
  $spamassassin_required_score                       = '4.3'
  $spamassassin_rewrite_header                       = 'Subject *****SPAM*****'
  $spamassassin_report_safe                          = 0
  $spamassassin_trusted_networks                     = undef
  $spamassassin_internal_networks                    = undef
  $spamassassin_use_bayes                            = 1
  $spamassassin_bayes_auto_expire                    = 0
  $spamassassin_bayes_sql_username                   = 'spam'
  $spamassassin_bayes_sql_password                   = undef
  $spamassassin_bayes_sql_override_username          = 'amavis'
  $spamassassin_bayes_auto_learn                     = 1
  $spamassassin_bayes_auto_learn_threshold_nonspam   = '0.1'
  $spamassassin_bayes_auto_learn_threshold_spam      = '7.0'
  $spamassassin_skip_rbl_checks                      = 0
  $spamassassin_dns_available                        = true
  
  ## Clamav
  $clamav_conf_dir                       = '/etc/clamav'
  $clamav_confd_purge                    = false
  
  ## DSPAM
  $dspam_conf_dir                       = '/etc/dspam'
  $dspam_confd_purge                    = false
  $dspam_home                           = '${amavisd_myhome}/dspam'
  $dspam_purge_signatures               = 14
  $dspam_purge_neutral                  = 90
  $dspam_purge_unused                   = 90
  $dspam_purge_hapaxes                  = 30
  $dspam_purge_hits1S                   = 15    
  $dspam_purge_hits1I                   = 15
  $dspam_db_name                        = 'dspam'
  $dspam_db_user                        = 'dspam'
  $dspam_db_password                    = undef
    
  ## Roundcube
  $roundcube_home_dir                   = '/usr/share/roundcube'
  $roundcube_conf_file                  = '${roundcube_home_dir}/main.inc.php'
  $roundcube_apache_conf                = '/etc/apache2/conf.d/rouncube.conf'
  $roundcube_db_name                    = 'roundcube'
  $roundcube_db_user                    = 'roundcube'
  $roundcube_db_password                = undef
  $roundcube_plugins                    = undef
  $roundcube_lang                       = 'en'
  $roundcube_log_date_format            = 'd-M-Y H:i:s O'
  $roundcube_imap_auth_type             = 'null'
  $roundcube_support_url                = undef
  $roundcube_auto_create_user           = true
  $roundcube_message_cache_lifetime     = '10d'
  $roundcube_force_https                = true
  $roundcube_use_https                  = true
  $roundcube_login_autocomplete         = 2
  $roundcube_login_lc                   = 2
  $roundcube_session_lifetime           = 10
  $roundcube_display_version            = false
  $roundcube_plugins_enabled            = ['
    autologon
    password
    autoresponder
    calender
    managesieve
    zipdownload
    attachment_reminder
  ']
}