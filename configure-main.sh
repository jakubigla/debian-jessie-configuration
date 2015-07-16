#!/bin/bash

cat ./sources.list > /etc/apt/sources.list
apt-get update && apt-get -V upgrade
updatedb

apt-get install ntp ntpdate
dpkg-reconfigure tzdata
apt-get install fail2ban rkhunter psad lynis

cd /root && wget http://www.webmin.com/jcameron-key.asc && apt-key add jcameron-key.asc
apt-get update
apt-get install webmin

nano /etc/ssh/sshd_config
systemctl restart ssh.service

apt-get update && apt-get -V upgrade
updatedb