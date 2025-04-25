#!/bin/bash

if ! id "${FTP_USER}" &>/dev/null; then
    useradd -m "${FTP_USER}"
    echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd
fi

exec $@
