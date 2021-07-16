# Docker Desktop VNC

[![Releases](https://img.shields.io/github/v/tag/MarcelCoding/docker-desktop-vnc?label=latest%20version&style=flat-square)](https://github.com/marcelcoding/docker-desktop-vnc/releases)
[![Build](https://img.shields.io/github/workflow/status/MarcelCoding/docker-desktop-vnc/CI?label=CI&style=flat-square)](https://github.com/marcelcoding/docker-desktop-vnc/actions)
[![DockerHub](https://img.shields.io/docker/pulls/marcelcoding/docker-desktop-vnc?style=flat-square)](https://hub.docker.com/r/marcelcoding/docker-desktop-vnc)

Docker Desktop VNC is a working environment witch is running in Docker witch can be accessed
over [NoVNC](https://github.com/novnc/noVNC), a VNC client for the web.

## Deployment

This image is available in [DockerHub](https://hub.docker.com/r/marcelcoding/docker-desktop-vnc) and the
[GitHub Container Registry](https://github.com/users/MarcelCoding/packages/container/package/docker-desktop-vnc):

```
marcelcoding/docker-desktop-vnc:latest
ghcr.io/marcelcoding/docker-desktop-vnc:latest
```

### Docker "run" Command

```bash
docker run \
  -p 6901:6901 \
  -e VNC_PW=SECURE_PASSWORD \
  --restart always \
  --rm \
  marcelcoding/docker-desktop-vnc:latest
```

### Docker Compose

````yaml
# docker-compose.yaml
version: '3.8'

services:
  docker-desktop-vnc:
    image: marcelcoding/docker-desktop-vnc:latest
    restart: always
    environment:
      - 'VNC_PW=SECURE_PASSWORD' # <- NoVNC "Webinterface" Password
    # - 'VNC_RESOLUTION=1920x1080' <- NoVNC Screen Resolution (optional)
    # - 'VNC_COL_DEPTH=24'         <- NoVNC Screen Color Depth (optional)
    ports:
      - '6901:6901' # <- NoVNC Port (HTTP)
    # - '5901:5901'   <- VNC Port
````

### Persistence

Data persistence is currently work in progress.

## License

[LICENSE](LICENSE)
