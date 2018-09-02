FROM alpine:3.8
#FROM ubuntu:18.04

#RUN apt-get update && \
#    apt-get install -y \
#    socat \
#    software-properties-common \
#    python-virtualenv

RUN apk update && \
    apk add dcron python py-virtualenv bash socat

ENV SENTINEL_HOME /etc/sentinel
ENV WALLET_CONF=/etc/wallet.conf

ENV SENTINEL_CONF_FILE sentinel.conf
ENV SENTINEL_REQUIREMENTS_FILE requirements.txt

ENV WALLET_CONF_KEY syscoin_conf
ENV SENTINEL_WALLET_HOST wallet
ENV SENTINEL_CRON "* * * * *"
ENV SENTINEL_WALLET_RPC_PORT 1336

COPY opt /opt

RUN chmod +x /opt/setup.sh && \
    ln -s /opt/setup.sh /usr/local/bin/setup && \
    chmod +x /opt/sentinel.sh && \
    ln -s /opt/sentinel.sh /usr/local/bin/sentinel && \
    chmod +x /opt/docker-entrypoint.sh && \
    ln -s /opt/docker-entrypoint.sh /usr/local/bin/docker-entrypoint


ENTRYPOINT docker-entrypoint

### Child Image

COPY sentinel ${SENTINEL_HOME}
RUN setup

