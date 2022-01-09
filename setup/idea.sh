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
  wget -O- "https://download.jetbrains.com/idea/ideaIU-2021.1.3.tar.gz" | tar -xzvC /opt/idea --strip 1

  # .ignore
  installPlugin "https://plugins.jetbrains.com/files/7495/116929/.ignore-4.1.0.zip"

  # GO & GO Templates
  installPlugin "https://plugins.jetbrains.com/files/9568/126651/go-212.4638.7.zip"
  installPlugin "https://plugins.jetbrains.com/files/10581/126654/go-template-212.4638.7.zip"

  # Python (PyCharm IDE Professional) - (Community is another plugin)
  installPlugin "https://plugins.jetbrains.com/files/631/126660/python-212.4638.7.zip"

  # PowerShell
  installPlugin "https://plugins.jetbrains.com/files/10249/120542/PowerShell-2.0.7.zip"

  # Rust
  installPlugin "https://plugins.jetbrains.com/files/8182/126137/intellij-rust-0.4.150.3968-211.zip"

  # Toml
  installPlugin "https://plugins.jetbrains.com/files/8195/126135/intellij-toml-0.2.150.3968-211.zip"

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
