FROM debian:stretch as builder
ARG JQ_VERSION=1.6
ARG JQ_PLATFORM=linux
ARG JQ_ARCH=64
WORKDIR /build
RUN \
  apt-get update && \
  apt-get install -y curl && \
  mkdir -p asset/bin asset/lib asset/include
RUN \
  curl -LO https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-${JQ_PLATFORM}${JQ_ARCH} && \
  chmod +x jq-${JQ_PLATFORM}${JQ_ARCH} && \
  mv /build/jq-${JQ_PLATFORM}${JQ_ARCH} asset/bin/jq && \
  curl -L https://raw.githubusercontent.com/stedolan/jq/master/COPYING -o asset/include/COPYING && \
  cd asset && tar -czf sensu-assets-jq_${JQ_VERSION}_${JQ_PLATFORM}_${JQ_ARCH}.tar.gz *

FROM scratch
ARG JQ_VERSION=1.7.4
ARG JQ_PLATFORM=linux
ARG JQ_ARCH=amd64
COPY --from=builder /build/asset/sensu-assets-jq_${JQ_VERSION}_${JQ_PLATFORM}_${JQ_ARCH}.tar.gz /
