#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

# change vnc password
mkdir -p "/home/${USER}/.vnc"
PASSWD_PATH="/home/${USER}/.vnc/passwd"

if [[ -f $PASSWD_PATH ]]; then
  rm -f "$PASSWD_PATH"
fi

if [[ -z "$VARIABLE" ]]; then
  VARIABLE="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)"
fi

echo "$VNC_PW" | vncpasswd -f >"$PASSWD_PATH"
echo "VNC Password: $VNC_PW"
chmod 600 "$PASSWD_PATH"

# novnc
"${NOVNC_HOME}/utils/launch.sh" --vnc "localhost:$VNC_PORT" --listen "$NOVNC_PORT" &>/dev/stdout &# Add Prefix

vncserver -kill "${DISPLAY}" &>/dev/stdout ||
  rm -rfv /tmp/.X*-lock /tmp/.X11-unix

vncserver "${DISPLAY}" -xstartup /usr/bin/xfce4-terminal -depth "$VNC_COL_DEPTH" -geometry "$VNC_RESOLUTION" &>/dev/stdout

### disable screensaver and power management
xset -dpms &
xset s noblank &
xset s off &

# window manager
/usr/bin/startxfce4 --replace
