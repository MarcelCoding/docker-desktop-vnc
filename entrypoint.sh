#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

#VNC_IP=$(hostname -i)

# novnc
"${NOVNC_HOME}/utils/launch.sh" --vnc "localhost:$VNC_PORT" --listen "$NOVNC_PORT" &>/dev/stdout &# Add Prefix
#/usr/share/novnc/utils/launch.sh --vnc "localhost:$VNC_PORT" --listen "$NOVNC_PORT" &>/dev/stdout &# Add Prefix

## change vnc password
echo -e "\n------------------ change VNC password  ------------------"
# first entry is control, second is view (if only one is valid for both)
mkdir -p "$HOME/.vnc"
PASSWD_PATH="$HOME/.vnc/passwd"

if [[ -f $PASSWD_PATH ]]; then
  echo -e "\n---------  purging existing VNC password settings  ---------"
  rm -f "$PASSWD_PATH"
fi

if [[ $VNC_VIEW_ONLY == "true" ]]; then
  echo "start VNC server in VIEW ONLY mode!"
  #create random pw to prevent access
  echo $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20) | vncpasswd -f >$PASSWD_PATH
fi
echo "$VNC_PW" | vncpasswd -f >>"$PASSWD_PATH"
echo "VNC Pass: $VNC_PW"
chmod 600 "$PASSWD_PATH"

# vnc
# Add Prefix
vncserver -kill "${DISPLAY}" &>/dev/stdout ||
  rm -rfv /tmp/.X*-lock /tmp/.X11-unix

echo -e "start vncserver with param: VNC_COL_DEPTH=$VNC_COL_DEPTH, VNC_RESOLUTION=$VNC_RESOLUTION\n..."
vncserver "${DISPLAY}" -xstartup /usr/bin/xfce4-terminal -depth "$VNC_COL_DEPTH" -geometry "$VNC_RESOLUTION" &>/dev/stdout

echo -e "\n------------------ startup of mate window manager ------------------"

### disable screensaver and power management
xset -dpms &
xset s noblank &
xset s off &

/usr/bin/startxfce4 --replace
