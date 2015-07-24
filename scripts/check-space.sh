#!/bin/sh
# set -x
# Shell script to monitor or watch the disk space
# It will send an email to $ADMIN, if the (free available) percentage of space is >= 90%.
# -------------------------------------------------------------------------
# Set admin email so that you can get email.
ADMIN="root"
# set alert level 90% is default
ALERT=90
# Exclude list of unwanted monitoring, if several partions then use "|" to separate the partitions.
# An example: EXCLUDE_LIST="/dev/hdd1|/dev/hdc5"
EXCLUDE_LIST="devfs|map -hosts|map auto_home"
#
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
function main_prog() {
while read output;
do
#echo $output
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1)
  partition=$(echo $output | awk '{print $2}')
  if [ $usep -ge $ALERT ] ; then
     echo "Running out of space \"$partition ($usep%)\" on server $(hostname), $(date)" | \
     curl -X POST --data-urlencode 'payload={"channel": "#general", "username": "Camp Nou Server", "text": "Running out of space '"$partition ($usep%)"' on server '"$(hostname)"'", "icon_emoji": ":server:"}' https://hooks.slack.com/services/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
  fi
done
}
if [ "$EXCLUDE_LIST" != "" ] ; then
  df -H | grep -vE "^Filesystem|tmpfs|cdrom|${EXCLUDE_LIST}" | awk '{print $5 " " $6}' | main_prog
else
  df -H | grep -vE "^Filesystem|tmpfs|cdrom" | awk '{print $5 " " $6}' | main_prog
fi
