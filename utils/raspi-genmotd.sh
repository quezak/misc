#!/bin/sh
ip=`ip addr show scope global | grep inet | cut -d' ' -f6 | cut -d/ -f1`
up=`uptime | awk -F"up " '{print $2}' | awk -F"," '{print $1}'`
used=`df -h | grep 'dev/root' | awk '{print $3}'`
avail=`df -h | grep 'dev/root' | awk '{print $4}'`
temp=`awk < /sys/class/thermal/thermal_zone0/temp '{print ($1/1000) }'`
if [ -n "$1" ]; then out="$1"; else out="/dev/stdout"; fi

echo "\033[1;32m
    .~~.   .~~.
   '. \ '.' / .'   \033[0;37m                   _                          _ \033[1;31m
    .\033[1;32m~.,.^.,.~\033[1;31m.    \033[0;37m   ___ ___ ___ ___| |_ ___ ___ ___ _ _    ___|_|\033[1;31m
   : .~.'~'.~. :   \033[0;37m  |  _| .'|_ -| . | . | -_|  _|  _| | |  | . | |\033[1;31m
  ~ (   ) (   ) ~  \033[0;37m  |_| |__,|___|  _|___|___|_| |_| |_  |  |  _|_|\033[1;31m
 ( : '~'.~.'~' : ) \033[0;37m              |_|                 |___|  |_|    \033[1;31m
  ~ .~ (   ) ~. ~                      \033[1;30mcore ${temp}*C\033[1;31m
   (  : '~' :  )        \033[1;34mused | free      \033[1;30mup $up\033[1;31m
    '~ .~~~. ~'         \033[1;34m$used | $avail      \033[1;30m$ip\033[1;31m
        '~'
\033[0;30m" > $out
