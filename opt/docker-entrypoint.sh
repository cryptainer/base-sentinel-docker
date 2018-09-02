#!/bin/bash

# Ensure cron is running, so sentinel is run periodically
crond

if [ -z ${RPC_HOST+x} ]; then
    echo "ENV RPC_HOST must be defined in order to run sentinel."
    exit 1;
fi

if [ -z ${RPC_PORT+x} ]; then
    echo "ENV RPC_PORT must be defined in order to run sentinel."
    exit 1;
fi

if [ -z ${RPC_USER+x} ]; then
    echo "ENV RPC_USER must be defined in order to run sentinel."
    exit 1;
fi

if [ -z ${RPC_PASSWORD+x} ]; then
    echo "ENV RPC_PASSWORD must be defined in order to run sentinel."
    exit 1;
fi

echo "rpcport=80" > ${WALLET_CONF}
echo "rpcuser=${RPC_USER}" >> ${WALLET_CONF}
echo "rpcpassword=${RPC_PASSWORD}" >> ${WALLET_CONF}

echo "Forwarding TCP traffic from localhost:80 to ${RPC_HOST}:${RPC_PORT}..."

socat TCP-LISTEN:${RPC_PORT},fork TCP:${RPC_HOST}:${RPC_PORT}