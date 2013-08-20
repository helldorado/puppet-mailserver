#!/bin/sh
PERCENT=$1
USER=$2
cat << EOF | /usr/lib/dovecot/dovecot-lda -d $USER -o "plugin/quota=dict:User quota::noenforcing:proxy::quota"
From: postmaster@spamguard.fr
Subject: Alerte de Quota | Quota Warning
Alerte de Quota
Votre boite email a atteint $PERCENT% de sa taille maximale.
Au dela de 100% les emails ne vous seront plus delivres.
 
----------------------------------
Quota Warning
Your mailbox is now $PERCENT% full.
EOF
