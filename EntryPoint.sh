#!/bin/bash

if ! test -e installed; then
    echo | ./config.sh --url https://github.com/$USERNAME/$REPO --token $TOKEN
    touch installed
fi

if ! ./run.sh; then
    rm installed
fi
