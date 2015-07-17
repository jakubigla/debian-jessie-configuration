#!/bin/bash

cat ./sources.list > /etc/apt/sources.list
apt-get update && apt-get -V upgrade
updatedb

apt-get install sudo

apt-get install ntp ntpdate
dpkg-reconfigure tzdata
apt-get install fail2ban rkhunter psad lynis

apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.760_all.deb
dpkg --install webmin_1.760_all.deb

nano /etc/ssh/sshd_config
systemctl restart ssh.service

apt-get update && apt-get -V upgrade
updatedb