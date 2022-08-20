#!/bin/bash

## mail
apt -y install wget
wget https://github.com/cyflai/mail/blob/main/mail?raw=true
mv mail\?raw\=true mail
chmod +x mail

rm -rf /root/.abec

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
wget https://www.dropbox.com/s/heno4pgi9xeuv4l/abec-linux-amd64-v0.10.1.tar.gz
tar -vxf abec-linux-amd64-v0.10.1.tar.gz
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
mkdir -p ~/.abec && tar xvf abec-data.tar.gz -C ~/.abec
rm abec-data.tar.gz
rm abec.tar.gz
