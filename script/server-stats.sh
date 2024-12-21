#!/bin/sh
echo  "TOTAL_CPU_USAGE"
uptime | awk -F'load average:' '{ print $2 }'
echo "-----------------------------"
echo "TOTAL_MEM_USAGE"
awk '/MemTotal/ {total=$2} /MemFree/ {free=$2} /Buffers/ {buffers=$2} /Cached/ {cached=$2} END {used=total-(free+buffers+cached); print "Total: " total/1024 " MB\nUsed: " used/1024 " MB (" used/total*100 "%)\nFree: " free/1024 " MB (" free/total*100 "%)"}' /proc/meminfo
echo "-----------------------------"
echo "TOTAL_DISK_USAGE"
df -h
echo "-----------------------------"
echo "TOP_5_CPU_PROC"
ps -eo pid,%cpu,command --sort=-%cpu | head -n 6 | awk '{print $1, $2, substr($3, 1, 40)}' | column -t
echo "-----------------------------"
echo "TOP_5_MEM_USAGE"
ps -eo pid,%mem,command --sort=-%mem | head -n 6 | awk '{print $1, $2, substr($3, 1, 40)}' | column -t
echo "-----------------------------"
echo -n "HOSTNAME   = "
hostname
echo "-------------"
echo -n "TIMEZONE   = "
timedatectl | grep -e "Time zone:" | sed 's/^[ \t]*//'
echo "-------------"
echo -n "USER       = "
whoami
echo "-------------"
echo -n "OS         = "
grep -e "PRETTY_NAME" /etc/os-release
echo "-------------"
echo -n "DATE       = "
date
echo "-------------"
echo -n "UPTIME     = "
uptime --pretty
echo "-------------"
echo "LAST_USERS"
last | head -n 10
