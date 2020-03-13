#!/bin/bash -ex

fatal() {
    echo $*
    exit 1   
}

download_base_image() {
    imagename="CC-Ubuntu18.04"

    if openstack image show ${imagename} | grep -q 'disk_format.*qcow2'; then
        openstack image save --file cc-sage-proxy.qcow2 ${imagename}
        qemu-img convert cc-sage-proxy.qcow2 cc-sage-proxy.raw
        rm cc-sage-proxy.qcow2
    elif openstack image show ${imagename} | grep -q 'disk_format.*raw'; then
        openstack image save --file cc-sage-proxy.raw ${imagename}
    else
        fatal "unknown image format"
    fi
}

setup_image() {
    systemd-nspawn -i cc-sage-proxy.raw --bind-ro=/etc/resolv.conf --bind $PWD/extra:/extra bash -s <<EOF
# install packages
apt-get update && apt-get install -y git

# copy extra files
cp -a /extra/* /

systemctl enable setup-firewall.service
EOF
}

upload_image() {
    openstack image create --public --disk-format raw --container-format bare --file cc-sage-proxy.raw CC-SAGE-Edge
}

download_base_image
setup_image
upload_image
