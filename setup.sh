#!/bin/bash

set -e

if ! rpm -q python3 python3-pip python3-libdnf5 python3-psutil ansible &>/dev/null; then
  echo "Installing required packages..."
  sudo dnf install -y python3 python3-pip python3-libdnf5 python3-psutil ansible
fi

echo "Running Ansible playbook for $PLATFORM..."
ansible-playbook --connection=local --inventory 127.0.0.1, site.yml -K

echo "Setup complete!"
