#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

if [[ $(/usr/bin/id -u) != "0" ]]; then
  echo "Please run the script as root!"
else
  mkdir -p /opt/idea
  wget -O- "https://download-cf.jetbrains.com/idea/ideaIU-2020.2.3.tar.gz" | tar -xzC /opt/idea --strip 1
  wget -O "/opt/idea/icon.svg" "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/IntelliJ_IDEA_Logo.svg/1200px-IntelliJ_IDEA_Logo.svg.png"

  cat <<EOF >/usr/share/applications/idea
[Desktop Entry]
Name=IntelliJ IDEA Ultimate
Icon=/opt/idea/icon.svg
StartupWMClass=jetbrains-idea
Comment=Capable and ergonomic Java IDE
Exec="/opt/idea/bin/idea.sh" %f
Version=1.0
Type=Application
Categories=Development;IDE;
Terminal=false"
EOF

fi
