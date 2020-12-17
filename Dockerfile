FROM ubuntu:20.04

ARG SETUP_DIR="/tmp/setup"
ARG TIME_ZONE="Europe/Berlin"

ARG NOVNC_VERSION="v1.2.0"

ENV NOVNC_HOME="/opt/novnc" \
 VNC_PORT=5901 \
 NOVNC_PORT=6901 \
 VNC_COL_DEPTH=24 \
 VNC_RESOLUTION=1920x1080 \

 GROUP=group \
 USER=user \

 DEBIAN_FRONTEND=noninteractive \
 DISPLAY=:1

EXPOSE $VNC_PORT $NOVNC_PORT

RUN apt-get update \
 && apt-get install -y --no-install-recommends wget ca-certificates locales tzdata net-tools tar apt-transport-https \
 # setup timezone
 && echo $TIME_ZONE > /etc/timezone \
 && dpkg-reconfigure -f noninteractive tzdata \
 # setup locale
 && locale-gen en_US.UTF-8 \
 # setup mate
 && apt-get install -y supervisor xfce4 xfce4-terminal \
 && apt-get purge -y pm-utils xscreensaver* cups \
 # setup vnc
 && apt-get install -y --no-install-recommends tigervnc-standalone-server tigervnc-common \
 # setup novnc
 && mkdir -p ${NOVNC_HOME} \
 && wget -qO- "https://github.com/novnc/noVNC/archive/${NOVNC_VERSION}.tar.gz" | tar xz --strip 1 -C ${NOVNC_HOME} \
 && apt-get install -y --no-install-recommends websockify \
 && chmod +x -v ${NOVNC_HOME}/utils/*.sh \
 && ln -s ${NOVNC_HOME}/vnc_lite.html ${NOVNC_HOME}/index.html \
 # setup basic tools
 && apt-get install --no-install-recommends -y git vim nano htop sudo \
 # setup user
 && set -o errexit -o nounset \
 && groupadd --system --gid 1000 ${GROUP} \
 && useradd --system --gid ${GROUP} --uid 1000 --shell /bin/bash --create-home ${USER} \
 && chown --recursive ${USER}:${GROUP} /home/${USER} \
 && usermod -aG sudo ${USER} \
 && sed -i 's|%sudo\s\{1,\}ALL=(ALL:ALL) ALL|%sudo   ALL=(ALL:ALL) NOPASSWD:ALL|g' /etc/sudoers

# add all install scripts for further steps
COPY ./setup/ ${SETUP_DIR}/scripts

# updating package lists
RUN apt-get update \
 # executing speficic tool installation scripts
 && cd "${SETUP_DIR}/scripts" \
 && find ${SETUP_DIR}/scripts -iname "*.sh" -exec chmod +x {} + \
 && for script in $(ls | grep --ignore-case ".sh"); do ./"$script"; done \
 # clean
 && apt-get install --no-install-recommends -y -f \
 && apt-get autoremove -y \
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/* ${SETUP_DIR}

# setup entrypoint
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER ${USER}
ENTRYPOINT ["/entrypoint.sh"]
