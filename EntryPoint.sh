#!/bin/bash

if ! grep -q $TOKEN installed; then
    rm .runner
    echo | ./config.sh --url https://github.com/$USERNAME/$REPO --token $TOKEN
    echo $TOKEN > installed
fi

if ./run.sh; then
    rm installed
fi
