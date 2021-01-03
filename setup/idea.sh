#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

function installPlugin() {
  wget -O plugin.zip "$1"
  unzip plugin.zip -d /opt/idea/plugins
  rm plugin.zip
}

if [[ $(/usr/bin/id -u) != "0" ]]; then
  echo "Please run the script as root!"
else
  mkdir -p /opt/idea
  wget -O- "https://download-cf.jetbrains.com/idea/ideaIU-2020.3.tar.gz" | tar -xzvC /opt/idea --strip 1

  # .ignore
  installPlugin "https://plugins.jetbrains.com/files/7495/105230/.ignore-4.0.0.zip"

  # GO & GO Templates
  installPlugin "https://plugins.jetbrains.com/files/9568/104013/go-203.5981.155.zip"
  installPlugin "https://plugins.jetbrains.com/files/10581/104141/go-template-203.5981.152.zip"

  # PHP
  installPlugin "https://plugins.jetbrains.com/files/6610/104391/php-203.5981.175.zip"

  # Python (PyCharm IDE Professional) - (Community is another plugin)
  installPlugin "https://plugins.jetbrains.com/files/631/104351/python-203.5981.165.zip"

  # PowerShell
  installPlugin "https://plugins.jetbrains.com/files/10249/94564/PowerShell-2.0.5.zip"

  # Rust
  installPlugin "https://plugins.jetbrains.com/files/8182/106545/intellij-rust-0.3.138.3572-203.zip"

  # Toml
  installPlugin "https://plugins.jetbrains.com/files/8195/106546/intellij-toml-0.2.138.3572-203.zip"

  mkdir -p "/home/${USER}/.local/share/applications"
  cat <<EOF >"/home/${USER}/.local/share/applications/jetbrains-idea.desktop"
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA Ultimate Edition
Icon=/opt/idea/bin/idea.svg
Exec="/opt/idea/bin/idea.sh" %f
Comment=Capable and Ergonomic IDE for JVM
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-idea
EOF

fi
