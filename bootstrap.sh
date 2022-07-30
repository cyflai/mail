#!/bin/bash


cat << EOF | > /etc/systemd/system/abec.service
[Unit]
Description=abec

[Service]
User=root
WorkingDirectory=/root
ExecStart=/bin/bash -c 'LD_LIBRARY_PATH=/root/abec/lib /root/abec/abec --generate'
Restart=always

[Install]
WantedBy=multi-user.target
EOF
