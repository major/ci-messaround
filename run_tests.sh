#!/bin/bash
set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive

# Install Ansible
sudo apt-get -qq update
sudo apt-get -qq -y install openssh-server
sudo pip3 install ansible

# Set up ssh keys and ssh daemon.
ssh-keygen -b 4096 -t rsa -f /tmp/sshkey -q -N ""
mkdir -vp ~/.ssh && chmod 0700 ~/.ssh
cat /tmp/sshkey.pub >> ~/.ssh/authorized_keys && chmod 0700 ~/.ssh/authorized_keys
sudo systemctl enable --now ssh

# Run Ansible playbook.
export ANSIBLE_CONFIG=ansible.cfg
export ANSIBLE_PRIVATE_KEY_FILE=/tmp/sshkey
ansible-playbook -i localhost, playbook.yml

# Get any journald messages during the deployment.
# journalctl --boot