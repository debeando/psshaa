#!/bin/bash
# encoding: UTF-8

# Set default values:
BRANCH=master

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

# Deploy ansible:
echo "Deploy branch: ${BRANCH}"

cd /usr/local/etc/ansible || exit 1
/usr/bin/git checkout -f "$BRANCH"
/usr/bin/git fetch origin
/usr/bin/git reset --hard origin/"$BRANCH"

# Run ansible in local mode:
echo "Run ansible..."
/usr/local/bin/ansible-playbook -i hosts servers.yml
