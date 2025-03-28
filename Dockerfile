FROM public.ecr.aws/docker/library/alpine:3.21 AS builder

ENV VERSION "2.1.8"

ARG TARGETARCH

ENV URL "https://github.com/jedisct1/dnscrypt-proxy/releases/download/${VERSION}/dnscrypt-proxy-linux_${TARGETARCH}-${VERSION}.tar.gz"

RUN apk update \
  && apk add curl 

COPY get.sh .
RUN sh get.sh

#RUN curl -L ${URL} -o dnscrypt-proxy.tar.gz \
#&& tar xvfz dnscrypt-proxy.tar.gz \
#&& cp linux-${TARGETARCH}/dnscrypt-proxy . \
#&& cp linux-${TARGETARCH}/example-dnscrypt-proxy.toml . \
#&& sed "s/^listen_addresses.*/listen_addresses = [':5300']/" example-dnscrypt-proxy.toml > dnscrypt-proxy.toml 

FROM public.ecr.aws/docker/library/alpine:3.21

WORKDIR /opt/dnscrypt-proxy

COPY --from=builder dnscrypt-proxy .
COPY --from=builder dnscrypt-proxy.toml .

EXPOSE 5300/tcp
EXPOSE 5300/udp

ENTRYPOINT ["/opt/dnscrypt-proxy/dnscrypt-proxy"]
CMD ["-config", "/opt/dnscrypt-proxy/dnscrypt-proxy.toml"]
