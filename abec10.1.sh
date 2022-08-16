

#!/bin/bash


## sudo su and cd /root before you run the boostraps script


# rm the existing abec
systemctl stop abec
rm -rf /root/abec
rm -f abec.tar.gz

# download the abec targ
cd /root
wget https://www.dropbox.com/s/heno4pgi9xeuv4l/abec-linux-amd64-v0.10.1.tar.gz=?dl=0

mv 'abec-linux-amd64-v0.10.1.tar.gz=?dl=0' abec-linux-amd64-v0.10.1.tar.gz
tar -vxf abec-linux-amd64-v0.10.1.tar.gz
mv abec-linux-amd64-v0.10.1 abec

# start abec 
systemctl start abec

# clean up
rm -f  abec-linux-amd64-v0.10.1.tar.gz
