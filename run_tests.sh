  #!/bin/bash
  set -euxo pipefail

  ansible-playbook -i localhost, playbook.yml

  ansible-playbook \
    -i /tmp/hosts.ini \
    -e testing_os=${TESTING_OS} \
    -e testing_os_version=${TESTING_OS_VERSION} \
    /tmp/ansible-osbuild/playbook.yml