#!/bin/sh
set -ex

VNC_PW=${VNC_PW:-novnc}
mkdir -p -m 700 /.vnc
x11vnc -storepasswd "$VNC_PW" /.vnc/passwd
if [ ! -z ${TOTP} -a ${TOTP} -ne 0 ]; then
  /app/vncpw-gen.sh &
fi
unset VNC_PW
chown -R novnc:novnc /.vnc
chown -R novnc:novnc /home/novnc

if [ -x /app/init.sh ]; then
  /app/init.sh &
fi

unset DEBIAN_FRONTEND
exec supervisord -c /app/supervisord.conf
