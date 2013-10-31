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
  $postfix_conf_dir                                 = '/etc/postfix'
  $postfix_confd_purge                              = false
  $postfix_smtpd_tls                                = true
  $postfix_smtpd_sasl_auth                          = true
  $postfix_submission                               = true
  $postix_postcreen_rbl_check                       = true
  $postfix_postscreen_dnsbl_threshold               = undef
  $postfix_postscreen_dnsbl_action                  = 'enforce'
  $postfix_postscreen_greet_action                  = 'enforce' 
  $postfix_postscreen_dnsbl_sites                   = [
    'zen.spamhaus.org*2', 
    'bl.spamcop.net*2',
    'b.barracudacentral.org*1',
    'bl.mailspike.net*1',
  ]
  $postfix_headers_check                            = true
  $postfix_body_check                               = true
  $postfix_mime_check                               = true
  $postfix_smtpd_recipient_restrictions             = [
    'reject_non_fqdn_recipient',
    'reject_unknown_sender_domain',
    'reject_non_fqdn_sender',
    'reject_unknown_recipient_domain',
    'reject_invalid_helo_hostname',
    'reject_unlisted_recipient',
    'reject_unlisted_sender',
    'permit_mynetworks',
    'permit_sasl_authenticated',
    'reject_non_fqdn_helo_hostname',
    'reject_unauth_destination',
    'check_client_access hash:/etc/postfix/internal_networks',
    'check_sender_access proxy:mysql:/etc/postfix/mysql_not_our_domain_as_sender.cf',
    'check_helo_access proxy:mysql:/etc/postfix/mysql-hello.cf',
    'check_sender_access proxy:mysql:/etc/postfix/mysql-sender.cf',
    'check_client_access proxy:mysql:/etc/postfix/mysql-client.cf', 
  ]
  $postfix_smtp_amavis_unix                                  = [
    'smtp_data_done_timeout=1200',
    'smtp_send_xforward_command=yes',
    'disable_dns_lookups=yes',
    'max_use=20',
  ]
  $postfix_smtp_amavis_inet                                  = [
    'content_filter=',
    'local_recipient_maps=',
    'relay_recipient_maps=',
    'smtpd_restriction_classes=',
    'smtpd_client_restrictions=',
    'smtpd_helo_restrictions=',
    'smtpd_sender_restrictions=',
    'smtpd_recipient_restrictions=permit_mynetworks,reject',
    'smtpd_data_restrictions=reject_unauth_pipelining',
    'smtpd_end_of_data_restrictions=',
    'mynetworks=127.0.0.0/8',
    'strict_rfc821_envelopes=yes',
    'smtpd_error_sleep_time=0',
    'smtpd_soft_error_limit=1001',
    'smtpd_hard_error_limit=1000',
    'smtpd_client_connection_count_limit=0',
    'smtpd_client_connection_rate_limit=0',
    'receive_override_options=no_address_mappings,no_header_body_checks,no_unknown_recipient_checks',
    'local_header_rewrite_clients=',
  ]
  
  ## IMPORTANT: These limits must not be used to regulate legitimate traffic: mail will suffer grotesque delays if you do so. 
  ## The limits are designed to protect the smtpd(8) server against abuse by out-of-control clients.
  ## IMPORTANT: Be careful when increasing the recipient limit per message delivery; 
  ## some SMTP servers abort the connection when they run out of memory or when a hard recipient limit is reached, so that the message will never be delivered.
  
  $postfix_default_process_limit                                  = undef # Control how many daemon processes Postfix will run. As of Postfix 2.0 the default limit is 100 SMTP client processes, 100 SMTP server processes, and so on. This may overwhelm systems with little memory, as well as networks with low bandwidth.
  $postfix_smtpd_recipient_limit                                  = undef # (default: 1000) controls how many recipients the Postfix smtpd(8) server will take per delivery.
  $postfix_smtpd_client_connection_count_limit                    = undef # (default: 50) The maximum number of connections that an SMTP client may make simultaneously.
  $postfix_smtpd_client_connection_rate_limit                     = undef # (default: no limit) The maximum number of connections that an SMTP client may make in the time interval specified with anvil_rate_time_unit (default: 60s).  
  $postfix_tpd_client_message_rate_limit                          = undef # (default: no limit) The maximum number of message delivery requests that an SMTP client may make in the time interval specified with anvil_rate_time_unit (default: 60s).
  $postfix_smtpd_client_recipient_rate_limit                      = undef # (default: no limit) The maximum number of recipient addresses that an SMTP client may specify in the time interval specified with anvil_rate_time_unit (default: 60s). 
  $postfix_smtpd_client_new_tls_session_rate_limit                = undef # (default: no limit) The maximum number of new TLS sessions (without using the TLS session cache) that an SMTP client may negotiate in the time interval specified with anvil_rate_time_unit (default: 60s). 
  $postfix_smtpd_client_event_limit_exceptions                    = undef # (default: $mynetworks) SMTP clients that are excluded from connection and rate limits specified above.
  $postfix_initial_destination_concurrency                        = undef # (default: 5) controls how many messages are initially sent to the same destination before adapting delivery concurrency. 
  $postfix_default_destination_concurrency_limit                  = undef # (default: 20) controls how many messages may be sent to the same destination simultaneously. 
  $postfix_default_destination_recipient_limit                    = undef # (default: 50) controls how many recipients a Postfix delivery agent will send with each copy of an email message. 

  ## IMPORTANT: If you increase the frequency of deferred mail delivery attempts, or if you flush the deferred mail queue frequently, then you may find that Postfix mail delivery performance actually becomes worse. The symptoms are as follows:
  ## The active queue becomes saturated with mail that has delivery problems. New mail enters the active queue only when an old message is deferred. This is a slow process that usually requires timing out one or more SMTP connections.
  ## All available Postfix delivery agents become occupied trying to connect to unreachable sites etc. New mail has to wait until a delivery agent becomes available. This is a slow process that usually requires timing out one or more SMTP connections.

  $postfix_queue_run_delay                                        = undef # (default: 300 seconds; before Postfix 2.4: 1000s) How often the queue manager scans the queue for deferred mail.
  $postfix_minimal_backoff_time                                   = undef # (default: 300 seconds; before Postfix 2.4: 1000s) The minimal amount of time a message won't be looked at, and the minimal amount of time to stay away from a "dead" destination.
  $postfix_maximal_backoff_time                                   = undef # (default: 4000 seconds) The maximal amount of time a message won't be looked at after a delivery failure.
  $postfix_maximal_queue_lifetime                                 = undef # (default: 5 days) How long a message stays in the queue before it is sent back as undeliverable. Specify 0 for mail that should be returned immediately after the first unsuccessful delivery attempt.
  $postfix_bounce_queue_lifetime                                  = undef # (default: 5 days, available with Postfix version 2.1 and later) How long a MAILER-DAEMON message stays in the queue before it is considered undeliverable. Specify 0 for mail that should be tried only once.
  $postfix_qmgr_message_recipient_limit                           = undef # (default: 20000) The size of many in-memory queue manager data structures. Among others, this parameter limits the size of the short-term, in-memory list of "dead" destinations. Destinations that don't fit the list are not added.
  $postfix_transport_destination_concurrency_failed_cohort_limit  = undef # Controls when a destination is considered "dead". This parameter is critical with a non-zero transport_destination_rate_delay, with a reduced transport_destination_concurrency_limit, or with a reduced initial_destination_concurrency.
  
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
  $amavisd_plugin_enabled                 = {}
   
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
  $roundcube_plugins_enabled            = [
    'autologon',
    'password',
    'autoresponder',
    'calender',
    'managesieve',
    'zipdownload',
    'attachment_reminder',
    'archiver_abstractor',
  ]
  
  ### Package
  $mailserver_packages = $::operatingsystem ? {
    /(?i-mx:debian|ubuntu)/                                                    => 'postfix postfix-mysql spamassassin dovecot-common dovecot-core dovecot-imapd dovecot-managesieved dovecot-mysql dovecot-pop3d dovecot-sieve dovecot-antispam',
    /(?i-mx:fedora|rhel|redhat|centos|scientific|suse|opensuse|amazon|gentoo)/ => 'postfix postfix-mysql spamassassin dovecot-common dovecot-core dovecot-imapd dovecot-managesieved dovecot-mysql dovecot-pop3d dovecot-sieve dovecot-antispam',
  }
  
  ##$mailserver_packages_whith_amavis
}