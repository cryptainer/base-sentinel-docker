#!/bin/bash

cd ${SENTINEL_HOME};
if [ ! -f .lock ]; then
    echo "[`date +%Y-%m-%d\ %H:%M:%S\ %Z`] Running Sentinel. See logs below if any."
    touch .lock
    ./venv/bin/python bin/sentinel.py;
    rm .lock;
fi