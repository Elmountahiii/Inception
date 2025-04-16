#!/bin/bash
# Create FTP user if not exists
if ! id "ftpuser" &>/dev/null; then
    useradd -m ftpuser
    echo "ftpuser:elmountahi" | chpasswd
fi

# Start vsftpd
exec $@
