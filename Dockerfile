FROM ubuntu:20.04

ARG SETUP_DIR="/tmp/setup"
ARG TIME_ZONE="Europe/Berlin"

ARG NOVNC_VERSION="v1.2.0"
ARG WEBSOCKIFY_VERSION="v0.9.0"
ARG TIGER_VNC_VERSION="1.11.0"

ENV NOVNC_HOME="/opt/novnc"
ENV VNC_PORT=5901
ENV NOVNC_PORT=6901
ENV VNC_COL_DEPTH=24
ENV VNC_RESOLUTION=1920x1080

EXPOSE $VNC_PORT $NOVNC_PORT

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

RUN apt-get update \
 && apt-get install -y --no-install-recommends wget ca-certificates locales tzdata net-tools tar

# setup timezone
RUN echo $TIME_ZONE > /etc/timezone \
 && dpkg-reconfigure -f noninteractive tzdata

# setup locale
RUN locale-gen en_US.UTF-8

# setup xfce
RUN apt-get install -y supervisor xfce4 xfce4-terminal \
 && apt-get purge -y pm-utils xscreensaver*

# setup vnc
RUN apt-get install -y --no-install-recommends tigervnc-standalone-server tigervnc-common # tigervnc-xorg-extension

# ====================================================
# https://wiki.ubuntuusers.de/VNC/#noVNC-BrowserClient
# setup novnc  #python3-websockify
RUN mkdir -p ${NOVNC_HOME} \
 && wget -qO- "https://github.com/novnc/noVNC/archive/${NOVNC_VERSION}.tar.gz" | tar xz --strip 1 -C ${NOVNC_HOME} \
 && apt-get install -y --no-install-recommends websockify \
 && chmod +x -v ${NOVNC_HOME}/utils/*.sh \
 && ln -s ${NOVNC_HOME}/vnc_lite.html ${NOVNC_HOME}/index.html
#RUN apt-get install -y --no-install-recommends novnc

# Add all install scripts for further steps
COPY ./setup/ ${SETUP_DIR}/scripts
RUN find ${SETUP_DIR}/scripts -iname "*.sh" -exec chmod +x {} + \
 && find ${SETUP_DIR}/scripts -iname "*.sh" -exec bash {} +

RUN apt-get install --no-install-recommends -y -f \
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/* ${SETUP_DIR}

# setup entrypoint
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
