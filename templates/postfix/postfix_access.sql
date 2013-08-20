use postfix;
CREATE TABLE `postfix_hello` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `source` varchar(128) NOT NULL default '',
  `access` varchar(128) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ;
INSERT INTO `postfix_hello` (`source`, `access`) VALUES ('starbridge.org', 'REJECT you are not me');
CREATE TABLE `postfix_access` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `source` varchar(128) NOT NULL default '',
  `access` varchar(128) NOT NULL default '',
  `type` enum('recipient','sender','client') NOT NULL default 'sender',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ;
INSERT INTO `postfix_access` (`source`, `access`, `type`) VALUES ('yahoo.com', 'OK', 'client'), ('newsletter@lesechos.fr', '554 Spam not tolerated here', 'sender');
