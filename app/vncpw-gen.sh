#!/bin/sh

x11vnc -storepasswd "$(oathtool --totp -b -s 3600 $VNC_PW)" /.vnc/passwd

_sec=$(expr 60 - $(date +%S))
sleep "$_sec"

_min=$(date +%M)
_wait=$(expr 60 - $_min)
_wait2=$(expr $_wait \* 60)
sleep "$_wait2"

x11vnc -storepasswd "$(oathtool --totp -b -s 3600 $VNC_PW)" /.vnc/passwd
date > /tmp/.vnc.time

while $(sleep 3600);
do
  x11vnc -storepasswd "$(oathtool --totp -b -s 3600 $VNC_PW)" /.vnc/passwd
  date > /tmp/.vnc.time
  oathtool --totp -b -s 3600 $VNC_PW >> /tmp/.vnc.time
  #/usr/bin/oathtool --totp -b -s 3600 "$VNC_PW" | /usr/bin/vncpasswd /.vnc/passwd
done &
