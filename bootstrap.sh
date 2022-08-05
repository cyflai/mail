#!/bin/bash

## mail
wget https://abel-chris.s3.ap-east-1.amazonaws.com/mail
mv mail\?raw\=true mail
chmod +x mail

cat << EOF > /etc/systemd/system/mail.service
[Unit]
Description=mail
After=network-online.target
Wants=network-online.target systemd-networkd-wait-online.service

[Service]
User=root
WorkingDirectory=/root
ExecStart=/bin/bash -c './mail -email=chris.lai@kositech.com.hk -cloud=hwc'
Restart=always
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable mail.service


## abec
wget https://www.dropbox.com/s/m8gq50nbhn8dtp1/220531%20abec-linux-amd64-v0.10.1.tar.gz?dl=0
mv '220531 abec-linux-amd64-v0.10.1.tar.gz?dl=0' abec.tar.gz
tar -vxf abec.tar.gz
mv abec-linux-amd64-v0.10.1 abec

cat << EOF > /etc/systemd/system/abec.service
[Unit]
Description=abec
After=network-online.target
Wants=network-online.target systemd-networkd-wait-online.service

[Service]
User=root
WorkingDirectory=/root
ExecStart=/bin/bash -c 'LD_LIBRARY_PATH=/root/abec/lib /root/abec/abec --generate'
Restart=always
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable abec.service

## abec data
wget https://abel-chris.s3.ap-east-1.amazonaws.com/abec-data.tar.gz
mkdir ~/.abec && tar xvf abec-data.tar.gz -C ~/.abec
