#!/bin/bash
set -euxo pipefail

ansible-playbook \
    -i localhost, \
    -e testing_os=${TESTING_OS} \
    -e testing_os_version=${TESTING_OS_VERSION} \
    playbook.yml

ansible-playbook \
    -i /tmp/hosts.ini \
    /tmp/ansible-osbuild/playbook.yml