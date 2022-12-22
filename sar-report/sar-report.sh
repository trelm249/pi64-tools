#!/bin/bash
###NAME= sar-report.sh
###Where= place in /usr/local/bin
###USAGE= /usr/local/bin/sar-report.sh >>~/$HOSTNAME.stats.$(date+%F)
#####For Raspi OS
echo -e "Hostname:\t$(hostname)"
echo -e "System OS:\t$(cat /etc/os-release |head -1 |cut -d "=" -f 2)\n"
echo -e "CPU Core Count:\t$(cat /proc/cpuinfo |grep "processor"|wc -l)"
echo -e "Total Memory:\t$(free -h |grep Mem |awk '{print $2}')\n"
echo -e "CPU % idle for 30 days"
for i in $(ls /var/log/sysstat/); do statdate=$(date -r /var/log/sysstat/$i +%F); sar -u -f /var/log/sysstat/$i 2>/dev/null |grep Average |awk '{print "'$statdate'\t"$8}'; done
echo -e "\n"
echo -e "%RAM Used for 30 days"
for i in $(ls /var/log/sysstat/); do statdate=$(date -r /var/log/sysstat/$i +%F); sar -r --human -f /var/log/sysstat/$i 2>/dev/null |grep Average |awk '{print "'$statdate'\t"$5}'; done
echo -e "\n"
echo -e "%SWAP Used for 30 days"
for i in $(ls /var/log/sysstat/); do statdate=$(date -r /var/log/sysstat/$i +%F); sar -S -f /var/log/sysstat/$i 2>/dev/null |grep Average |awk '{print "'$statdate'\t"$4}'; done
echo -e "\n"
echo -e "IO - transactions per second\tand\tbytes written per second"
for i in $(ls /var/log/sysstat/); do statdate=$(date -r /var/log/sysstat/$i +%F); sar -b -f /var/log/sysstat/$i 2>/dev/null |grep Average |awk '{print "'$statdate'\t"$2"\t\t\t\t"$6}'; done
echo -e "\n"
echo -e "Average Load:\tRun Queue\tand\tLoad Averages for 30 days"
for i in $(ls /var/log/sysstat/); do statdate=$(date -r /var/log/sysstat/$i +%F); sar -q -f /var/log/sysstat/$i 2>/dev/null |grep Average |awk '{print "'$statdate'\t"$2"\t\t\t\t"$6}'; done
echo -e "\n"
echo -e "Average per\tInterface\tPackets RX per second\tand\tPackets TX per second\tfor 30 days"
for i in $(ls /var/log/sysstat/); do statdate=$(date -r /var/log/sysstat/$i +%F); sar -n DEV -f /var/log/sysstat/$i 2>/dev/null |grep -vE "(lo|eth0|br-*|ve*|docker0)" |grep Average 2>/dev/null|awk '{print "'$statdate'\t"$2"\t"$3"\t\t\t\t"$4}'; done
echo -e "\n"
echo -e "File System Storage Consumption"
df -hlT --sync -x tmpfs -x devtmpfs -x iso9660
echo -e "\n"
echo -e "File System Inode Consumption"
df -ilT --sync -x tmpfs -x devtmpfs -x iso9660
