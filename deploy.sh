#!/bin/bash
# encoding: UTF-8

# Set default values:
BRANCH=master

# Help message of usage this script.
usage()
{
  cat << EOF
Script to deploy puppet in MasterLess mode. You can deploy specific branch and
run in test mode.

usage: $0 [--branch=name]

$0 --branch=IN-1234

OPTIONS:
  --branch Specify name of branch in git repository to deploy

EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --branch=*)
      BRANCH="${1#*=}"
      ;;
    --help)
      usage
      exit 0
      ;;
    *)
      printf "Error: Invalid argument.\n"
      usage
      exit 1
  esac
  shift
done

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
