#!/bin/bash
# Simple setup script for dotfiles
# Detects OS, installs Ansible if needed, then runs the Ansible playbook

set -e

echo "Detecting operating system..."
OS=$(uname -s)

# Determine OS and set appropriate variables
if [ "$OS" = "Darwin" ]; then
    PLATFORM="macos"

    # Check if Homebrew is installed
    if [ ! -f "/opt/homebrew/bin/brew" ] && [ ! -f "/usr/local/bin/brew" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Ensure brew is in PATH
    if [ -f "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f "/usr/local/bin/brew" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    # Check if Ansible is installed
    if ! command -v ansible &>/dev/null; then
        echo "Installing Ansible..."
        brew install ansible
    fi

    ANSIBLE_COLLECTIONS_PATH=$(find /opt/homebrew/Cellar/ansible -type d \
        -path "*/site-packages/ansible_collections" 2>/dev/null | sort -V | tail -n 1)

    ANSIBLE_COLLECTIONS_PATH="$ANSIBLE_COLLECTIONS_PATH:\
    /Users/$(whoami)/.ansible/collections:/usr/share/ansible/collections"

    export ANSIBLE_COLLECTIONS_PATH

elif [ "$OS" = "Linux" ]; then
    # Check if it's Fedora
    if grep -q "^ID=fedora" /etc/os-release; then
        echo "Fedora detected"
        PLATFORM="fedora"

        # Check if Ansible is installed
        if ! command -v ansible &>/dev/null; then
            echo "Installing Ansible..."
            sudo dnf install -y ansible
        fi
    else
        echo "Unsupported Linux distribution. Only Fedora is currently supported."
        exit 1
    fi
else
    echo "Unsupported operating system: $OS"
    exit 1
fi

echo "Running Ansible playbook for $PLATFORM..."
ansible-playbook --connection=local --inventory 127.0.0.1, playbook.yml -K

echo "Setup complete!"
