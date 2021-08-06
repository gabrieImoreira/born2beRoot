
#!/bin/bash
arc=$(uname -a)
pcpu=$(grep "physical id" /proc/cpuinfo | uniq | wc -l)
vcpu=$(grep "^processor" /proc/cpuinfo | uniq | wc -l)
fram=$(free -m | awk 'NR == 2 {print $2}')
uram=$(free -m | awk 'NR == 2 {print $3}')
pram=$(free | awk 'NR == 2 {printf("%.2f"), $3/$2*100}')
fdisk=$(df -h --total | awk 'END{print $2}')
udisk=$(df -m --total | awk 'END{print $3}')
pdisk=$(df -h --total | awk 'END{print $5}')
cpul=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')
lb=$(who -b | awk '{print $3,$4}')
lvmu=$(if [ $(/usr/sbin/blkid | grep -c '/dev/mapper') -eq 0 ]; then echo no; else echo yes; fi)
ctcp=$(ss -s | awk '/TCP:/ {print $2}')
ulog=$(who | wc -l)
ip=$(hostname -I | awk '{print $1}')
mac=$(ip link show | grep link/ether | cut -c 16-32)
cmds=$(grep -c 'COMMAND' /var/log/sudo/sudo.log)
wall "	#Architecture: $arc
	#CPU physical: $pcpu
	#vCPU: $vcpu
	#Memory Usage: $uram/${fram}MB ($pram%)
	#Disk Usage: $udisk/${fdisk}b ($pdisk%)
	#CPU load: $cpul
	#Last boot: $lb
	#LVM use: $lvmu
	#Connexions TCP: $ctcp ESTABLISHED
	#User log: $ulog
	#Network: IP $ip ($mac)
	#Sudo: $cmds cmd" 
