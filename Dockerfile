FROM alpine:3.8

ARG BUILD_DATE

MAINTAINER topperblues
LABEL maintainer="topperblues"

# install packages
RUN apk add --no-cache nginx openvpn

VOLUME /config
EXPOSE 80