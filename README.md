# dnscrypt-proxy
A lightweight container image of [dnscrypt-proxy](https://github.com/jedisct1/dnscrypt-proxy) with support for armv7, arm64 and amd64

### Listens on port 5300

## docker-compose.yml
```yaml
services:
  dnscrypt-proxy:
    container_name: dnscrypt-proxy
    image: ghcr.io/shmick/docker-dnscrypt-proxy
    ports:
      - "5300:5300/tcp"
      - "5300:5300/udp"
    restart: unless-stopped
```
