#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

function installPlugin() {
  sudo -u "${USER}" -g "${GROUP}" code --install-extension "$1"
}

if [[ $(/usr/bin/id -u) != "0" ]]; then
  echo "Please run the script as root!"
else
  # https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
  install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'

  apt-get update
  apt-get install -y --no-install-recommends code

  # install Plugins
  installPlugin zhuangtongfa.material-theme
  installPlugin vscode-icons-team.vscode-icons
  installPlugin jaspernorth.vscode-pigments
  installPlugin ritwickdey.liveserver

  mkdir -p "/home/${USER}/.config/Code/User"
  cat <<EOF >"/home/${USER}/.config/Code/User/settings.json"
{
    "workbench.iconTheme": "vscode-icons",
    "workbench.colorTheme": "One Dark Pro",
    "window.titleBarStyle": "custom"
}
EOF
fi
