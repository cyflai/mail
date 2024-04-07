#!/bin/bash

##################################################################
## you need to sudo su (as root) before you can run this script ##
##################################################################

## lean up if any old setting
cd /root
rm -f /etc/systemd/system/q-watchdog.service

## download the sw
mkdir -p /root/watchdog
cd /root/watchdog
wget https://poolsolution.s3.eu-west-2.amazonaws.com/watchdog


## create a systemd service
cat << EOF > /etc/systemd/system/q-watchdog.service
[Unit]
Description=pool
After=network-online.target
Wants=network-online.target systemd-networkd-wait-online.service
[Service]
User=root
WorkingDirectory=/root
ExecStart=/bin/bash -c '/root/watchdog/watchdog'
Restart=always
Restart=on-failure
RestartSec=5s
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

systemctl enable q-watchdog
