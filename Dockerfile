FROM public.ecr.aws/docker/library/alpine:3.22 AS builder

ARG VERSION="2.1.15"

ARG TARGETARCH

ARG URL="https://github.com/jedisct1/dnscrypt-proxy/releases/download/${VERSION}/dnscrypt-proxy-linux_${TARGETARCH}-${VERSION}.tar.gz"

RUN apk update \
  && apk add curl 

COPY get.sh .
RUN sh get.sh

FROM public.ecr.aws/docker/library/alpine:3.22

WORKDIR /opt/dnscrypt-proxy

COPY --from=builder dnscrypt-proxy .
COPY --from=builder dnscrypt-proxy.toml .

EXPOSE 5300/tcp
EXPOSE 5300/udp

ENTRYPOINT ["/opt/dnscrypt-proxy/dnscrypt-proxy"]
CMD ["-config", "/opt/dnscrypt-proxy/dnscrypt-proxy.toml"]
