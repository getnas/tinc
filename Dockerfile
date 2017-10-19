FROM alpine:latest

MAINTAINER Herald Yu <yuhr123@gmail.com>

RUN apk update && \
        apk add --no-cache --update tinc && \
        mkdir /etc/tinc

ADD ./init.sh /init.sh

RUN chmod +x /init.sh

VOLUME [ "/etc/tinc" ]
EXPOSE 655/tcp 655/udp
ENV NETNAME=p2pvpn
ENV HOSTNAME=vultr
ENV SUBNET=10.10.0.1/32
ENV IP=10.10.0.1

WORKDIR /
CMD [ "/init.sh" ]
