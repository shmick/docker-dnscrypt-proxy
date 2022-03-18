#!/bin/sh

export BUILDARCH=$TARGETARCH

if [ "$TARGETARCH" = "amd64" ] 
then export BUILDARCH="x86_64" 
fi

export URL="https://github.com/jedisct1/dnscrypt-proxy/releases/download/${VERSION}/dnscrypt-proxy-linux_${BUILDARCH}-${VERSION}.tar.gz"

curl -L ${URL} -o dnscrypt-proxy.tar.gz \
&& tar xvfz dnscrypt-proxy.tar.gz \
&& cp linux-${BUILDARCH}/dnscrypt-proxy . \
&& cp linux-${BUILDARCH}/example-dnscrypt-proxy.toml . \
&& sed "s/^listen_addresses.*/listen_addresses = [':5300']/" example-dnscrypt-proxy.toml > dnscrypt-proxy.toml
