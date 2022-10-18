#!/bin/bash

RECORD_OUTPUT=$1
RECORD_SECONDS=$2
RECORD_HOST=$3
RECORD_PORT=$4
RECORD_MOUNT=$5


while true
do
    echo "Running: fIcy -s .mp3 -o $RECORD_OUTPUT -M $RECORD_SECONDS -d $RECORD_HOST $RECORD_PORT $RECORD_MOUNT"
    fIcy -s .mp3 -o $RECORD_OUTPUT -M $RECORD_SECONDS -d $RECORD_HOST $RECORD_PORT $RECORD_MOUNT
    echo "Sleeping for 30 seconds"
    sleep 30
done