#!/bin/bash


cat << EOF | > /etc/systemd/system/abec.service
[Unit]
Description=abec

[Service]
User=$1
WorkingDirectory=$2
ExecStart=/bin/bash -c 'LD_LIBRARY_PATH=$2/abec/lib $2/abec/abec --generate'
Restart=always

[Install]
WantedBy=multi-user.target
EOF
