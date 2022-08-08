#!/bin/bash


## sudo su and cd /root before you run the boostraps script


# rm the existing abec
systemctl stop abec
rm -rf /root/abec

# download the abec targ
cd /root
wget https://www.dropbox.com/s/nz9uu405lpbwij8/abec-linux-amd64-v0.11.0.tar.gz?dl=0
mv 'abec-linux-amd64-v0.11.0.tar.gz?dl=0' abec.tar.gz
tar -vxf abec.tar.gz
mv abec-linux-amd64-v0.10.1 abec

# start the abec
systemctl start abec
