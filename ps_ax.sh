#!/bin/bash
CLK_TCK=`getconf CLK_TCK`

(
echo 'PID TTY STAT TIME COMMAND'
for PID in `ls /proc | grep -E "[[:digit:]]"| sort -n`; do
        if [ -d /proc/$PID ]; then
        PID_INFO=`</proc/$PID/stat`
        TTY=`echo $PID_INFO | awk  '{print $7}'`
        COMMAND=`echo $PID_INFO | awk  '{print $2}'`
        STAT=`echo $PID_INFO | awk  '{print $3}'`
        
        UTIME=`echo $PID_INFO | awk  '{print $14}'`
        STIME=`echo $PID_INFO | awk  '{print $15}'`
        TIME=$((USTIME=UTIME + STIME,USTIME/CLK_TCK))
        echo "$PID $TTY $STAT $TIME $COMMAND"
        fi
done
) |  column -t -s " "
