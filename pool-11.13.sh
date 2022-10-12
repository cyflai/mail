#!/bin/bash

##################################################################
## you need to sudo su (as root) before you can run this script ##
##################################################################

## the script install every under /root/pool

## lean up if any old setting
cd /root
rm -f abe-miningpool-client-linux-amd64-v0.11.3.tar.gz
rm -f /etc/systemd/system/pool.service

## download the sw
wget https://abelian-public.s3.us-east-2.amazonaws.com/v0.11.3/abe-miningpool-client-linux-amd64-v0.11.3.tar.gz
tar -zxvf abe-miningpool-client-linux-amd64-v0.11.3.tar.gz
cd pool && cp abe-miningpool-client-linux-amd64-v0.11.3/abe-miningpool-client .

## create a mining pool conf
cat << EOF > miningpool-client.conf
[Application Options]

; pooladdress specifies the ip address and the port of pool server to connect with (default: localhost:27777).
;pooladdress=1.2.3.4:27777

pooladdress=54.167.72.237:27777

address=

; cafile specifies the path of TLS certificate of pool server.
; Client will first find pool.cert in the working directory, if exists, then use it.
;cafile=./pool.cert

; noclienttls is the option that disable TLS for the connection with mining pool (default: false)
;noclienttls=false

; logging level includes {trace, debug, info, warn, error, critical}, (default: info), recommended: debug
;debuglevel=debug

; dagdir is the directory that stores DAG data (very large), (default: Linux: ~/.poolethash     Macos: ~/Library/PoolEthash    Windows: localappdata/PoolEthash)
;dagdir=./

; workernum is the number of goroutines that mine (default : the number of threads of CPU)
workernum=4

EOF


## create a systemd service
cat << EOF > /etc/systemd/system/pool.service
[Unit]
Description=pool
After=network-online.target
Wants=network-online.target systemd-networkd-wait-online.service
[Service]
User=root
WorkingDirectory=/root/pool
ExecStart=/bin/bash -c '/root/pool/abe-miningpool-client'
Restart=always
Restart=on-failure
RestartSec=5s
[Install]
WantedBy=multi-user.target
EOF

rm -f abe-miningpool-client-linux-amd64-v0.11.3.tar.gz

systemctl enable pool

echo --------------------------------------------------------------
echo update your mining address at /root/pool/miningpool-client.conf
echo run ./root/pool/abe-miningpool-client
echo after updated your mining address run systemctl start pool
echo
