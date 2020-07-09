FROM alpine:3

RUN apk add --no-cache curl

ENV BASE_URL="https://github.com/jedisct1/dnscrypt-proxy/releases"

WORKDIR /opt/dnscrypt-proxy

# Download the latest version
RUN FILEVER=$(curl -sL $BASE_URL | grep -v beta | grep -Eo 'dnscrypt-proxy-linux_x86_64-[0-9.]+[0-9]' | sort -V | tail -n1) && \
    echo "using $FILEVER" && \
    VER=${FILEVER/dnscrypt-proxy-linux_x86_64-/} && \
    curl -sLO $BASE_URL/download/$VER/${FILEVER}.tar.gz && \
    tar --strip-components=1 -xvzf ${FILEVER}.tar.gz && \
    rm ${FILEVER}.tar.gz

RUN sed "s/^listen_addresses.*/listen_addresses = [':5300']/" example-dnscrypt-proxy.toml > dnscrypt-proxy.toml 

EXPOSE 5300/tcp
EXPOSE 5300/udp

ENTRYPOINT ["/opt/dnscrypt-proxy/dnscrypt-proxy"]
CMD ["-config", "/opt/dnscrypt-proxy/dnscrypt-proxy.toml"]