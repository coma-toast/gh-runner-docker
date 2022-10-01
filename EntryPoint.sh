#!/bin/bash

cd actions-runner

if ! test -e installed; then
    echo | ./config.sh --url https://github.com/$USERNAME/$REPO --token $TOKEN
    touch installed
fi

./run.sh

if ! $? eq 0; then
    rm installed
fi
