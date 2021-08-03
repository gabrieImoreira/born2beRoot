#!/bin/bash
wall ''
echo "#Architecture :" "$(uname -a)"
echo "#CPU physical :" "$(grep 'physical id' /proc/cpuinfo | uniq | wc -l)"
echo "#vCPU         :" "$(grep 'processor' /proc/cpuinfo | uniq | wc -l)"
USED_R=$(free -m |awk 'NR == 2 {print $3}')
TOTAL_R=$(free -m |awk 'NR == 2 {print $2}')
PRCT_R=$(free -m |awk 'NR == 2 {printf "%.2f", $3*100/$2}')
echo "#Memory Usage :" "${USED_R}/${TOTAL_R}MB" "(${PRCT_R}%)"
USED_D=$(df -m --total | awk 'END{print $3}')
TOTAL_D=$(df -h --total | awk 'END{print $2}')
PRCT_D=$(df -h --total | awk 'END{print $5}')
echo "#Disk Usage   :" "${USED_D}/${TOTAL_D}b" "(${PRCT_D})"
echo "#CPU Load     :" "$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')"
echo "#Last Boot    :" "$(who -b | awk '{print $3,$4}')"
echo "#LVM in Use   :" $(if [ $(/usr/sbin/blkid | grep -c '/dev/mapper') -eq 0 ]; then echo "no"; else echo "yes"; fi)
echo "#Connexions TCP  :" "$(ss -s | awk '/TCP:/ {print $2}') ESTABLISHED"
echo "#Users Logged :" "$(who | wc -l)"
echo "#Network      :" "IP $(hostname -I)" "($(/usr/sbin/ifconfig | awk '/ether/ {print $2}'))"
echo "#Sudo         :" "$(grep -c 'COMMAND' /var/log/sudo/sudo.log)" "cmd"

