#!/bin/bash
arc=$(uname -a)
pcpu=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)
vcpu=$(grep "^processor" /proc/cpuinfo | wc -l)
fram=$(free -m | awk '$1 == "Mem:" {print $2}')
uram=$(free -m | awk '$1 == "Mem:" {print $3}')
pram=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')
fdisk=$(df -h --total | awk 'END{print $2}')
udisk=$(df -m --total | awk 'END{print $3}')
pdisk=$(df -h --total | awk 'END{print $5}')
cpul=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')
lboot=$(who -b | awk '$1 == "system" {print $3 " " $4}')
lvm=$(lsblk | grep "lvm" | wc -l)
lvmu=$(if [ $lvm -eq 0 ]; then echo no; else echo yes; fi)
ctcp=$(ss -s | awk '/TCP:/ {print $2}') 
ulog=$(who | wc -l)
ip=$(hostname -I)
mac=$(/usr/sbin/ifconfig | awk '/ether/ {print $2}')
cmds=$(grep -c 'COMMAND' /var/log/sudo/sudo.log)
wall "	#Architecture: $arc
	#CPU physical: $pcpu
	#vCPU: $vcpu
	#Memory Usage: $uram/${fram}MB ($pram%)
	#Disk Usage: $udisk/${fdisk}b ($pdisk%)
	#CPU load: $cpul
	#Last boot: $lboot
	#LVM use: $lvmu
	#Connexions TCP: $ctcp ESTABLISHED
	#User log: $ulog
	#Network: IP $ip ($mac)
	#Sudo: $cmds cmd" 
