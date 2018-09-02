#!/bin/bash

if [ -z ${WALLET_CONF_KEY+x} ]; then
    echo "ENV SENTINEL_WALLET_CONF_KEY must be defined in order to setup sentinel."
    exit 1;
fi

echo "Setting up sentinel with the following parameters:"
echo "SENTINEL_HOME = ${SENTINEL_HOME}"
echo "SENTINEL_CONF_FILE = ${SENTINEL_CONF_FILE}"
echo "SENTINEL_REQUIREMENTS_FILE = ${SENTINEL_REQUIREMENTS_FILE}"
echo "SENTINEL_CRON = ${SENTINEL_CRON}"



mkdir -p ${SENTINEL_HOME}

cd ${SENTINEL_HOME}

virtualenv venv && \
./venv/bin/pip install -r ${SENTINEL_REQUIREMENTS_FILE} && \

echo "${WALLET_CONF_KEY}=${WALLET_CONF}" >> ${SENTINEL_CONF_FILE}

echo "${SENTINEL_CRON} /usr/local/bin/sentinel > /dev/pts/0 2>&1" >> /tmp/crontab
crontab /tmp/crontab
rm -f /tmp/crontab