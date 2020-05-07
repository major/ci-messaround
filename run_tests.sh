#!/bin/bash
set -euxo pipefail

# Install Ansible
sudo apt-get update
sudo apt-get -qy install ansible openssh-server

# Set up ssh keys and ssh daemon.
ssh-keygen -b 4096 -t rsa -f /tmp/sshkey -q -N ""
mkdir -vp ~/.ssh && chmod 0700 ~/.ssh
cat /tmp/sshkey.pub >> ~/.ssh/authorized_keys && chmod 0700 ~/.ssh/authorized_keys
sudo systemctl enable --now ssh

# Run Ansible playbook.
export ANSIBLE_CONFIG=ansible.cfg
export ANSIBLE_PRIVATE_KEY_FILE=/tmp/sshkey
ansible-playbook -v -i localhost, playbook.yml

# Get any journald messages during the deployment.
journalctl --boot