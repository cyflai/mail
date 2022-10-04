## this use bash shell
#!/bin/bash
# Path: pool.sh

rm -f abe-miningpool-client-linux-amd64-v0.11.2-b.tar.gz
rm -rf pool
rm -f abe-miningpool-client-macos-amd64-v0.11.2-b

cd /root

wget https://abelian-public.s3.amazonaws.com/abe-miningpool-client-linux-amd64-v0.11.2-b.tar.gz

tar -zxvf abe-miningpool-client-linux-amd64-v0.11.2-b.tar.gz

mv abe-miningpool-client-linux-amd64-v0.11.2-b pool && cd pool

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


cat << EOF > /etc/systemd/system/pool.service
[Unit]
Description=abec
After=network-online.target
Wants=network-online.target systemd-networkd-wait-online.service
[Service]
User=root
WorkingDirectory=/root
ExecStart=/bin/bash -c '/root/pool/abe-miningpool-client'
Restart=always
Restart=on-failure
RestartSec=5s
[Install]
WantedBy=multi-user.target
EOF

rm -f abe-miningpool-client-linux-amd64-v0.11.2-b.tar.gz

sudo systemctl enable abec.service

echo update your mining address at /root/pool/miningpool-client.conf
echo after updated your mining address run sudo systemctl start abec.service




# echo Input your wallet address?
# read MYADDR
# sed -i -e "s/MYADDRESS/${MYADDR}/g" miningpool-client.conf
