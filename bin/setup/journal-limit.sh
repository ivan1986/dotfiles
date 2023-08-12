#!/bin/sh

mkdir /etc/systemd/journald.conf.d
cat > /etc/systemd/journald.conf.d/size.conf <<FILE
[Journal]
SystemMaxUse=100M
SystemMaxFileSize=20M
FILE

systemctl restart systemd-journald.service
