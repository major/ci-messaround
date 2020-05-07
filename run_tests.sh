#!/bin/bash
set -euxo pipefail

FEDORA_MIRROR=http://mirror.lstn.net/fedora/releases/32/Cloud/x86_64/images
FEDORA_QCOW=Fedora-Cloud-Base-32-1.6.x86_64.qcow2

sudo apt-get -q update
sudo apt-get -qy install aria2 bridge-utils cpu-checker libguestfs-tools \
    libvirt-bin libvirt-clients libvirt-daemon libvirt-daemon-system \
    kmod qemu-kvm wget

kvm-ok

sudo systemctl enable --now libvirtd

virsh list --all

aria2c -x 4 ${FEDORA_MIRROR}/${FEDORA_QCOW}

virt-customize -a ${FEDORA_QCOW} \
    --root-password password:secrete --uninstall cloud-init

virt-install \
    --name fedora-test \
    --memory 1024 \
    --vcpus 1 \
    --disk $(pwd)/${FEDORA_QCOW} \
    --import \
    --os-variant fedora

virsh list --all

ip addr

journalctl --boot

