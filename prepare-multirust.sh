#!/usr/bin/env bash

OUTPUT="$( multirust update $1 )"
if [ $? -ne 0 ]; then
    echo "multirust update failed:${OUTPUT}"
    exit 1
fi

OUTPUT="$( multirust override $1 )"
if [ $? -ne 0 ]; then
    echo "multirust override failed:${OUTPUT}"
    exit 1
fi

if [[ `rustc --version` =~ ^rustc.+\((.+).{11}\)$ ]]; then
    echo ${BASH_REMATCH[1]}
else
    echo "unable to parse required commit from string `rustc --version`"
    exit 1
fi