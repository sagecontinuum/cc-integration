#!/bin/bash -ex

# save ubuntu 18.04 base image
openstack image save --file cc-sage-proxy.raw CC-Ubuntu18.04

# spin up image in container and make modifications
systemd-nspawn -i cc-sage-proxy.raw --bind-ro=/etc/resolv.conf --bind $PWD/extra:/extra bash -s <<EOF
# install packages
apt-get update && apt-get install -y git

# copy extra files
cp -a /extra/* /
EOF

# create new image
openstack image create --public --disk-format raw --container-format bare --file cc-sage-proxy.raw CC-SAGE-Edge
