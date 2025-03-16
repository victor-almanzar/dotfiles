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
  if [ ! -f "/opt/homebrew/bin/brew" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Ensure brew is in PATH
  if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  # Install Python via Homebrew if needed
  if ! brew list python &>/dev/null; then
    echo "Installing Python via Homebrew..."
    brew install python
  else
    echo "Python is already installed via Homebrew"
  fi

  # Create and activate virtual environment
  echo "Creating virtual environment..."
  python3 -m venv ./.venv

  echo "Activating virtual environment..."
  source ./.venv/bin/activate

  # Install Ansible via pip
  echo "Installing Ansible via pip..."
  pip install ansible

elif [ "$OS" = "Linux" ]; then
  # Check if it's Fedora
  if grep -q "^ID=fedora" /etc/os-release; then
    echo "Fedora detected"
    PLATFORM="fedora"

    # Check if Python is installed
    if ! rpm -q python3 python3-pip python3-libdnf5 &>/dev/null; then
      echo "Installing Python..."
      sudo dnf install -y python3 python3-pip python3-libdnf5
    fi

    # Create and activate virtual environment
    echo "Creating virtual environment..."
    python3 -m venv ./.venv

    echo "Activating virtual environment..."
    source ./.venv/bin/activate

    # Install Ansible via pip
    echo "Installing Ansible via pip..."
    pip install ansible
  else
    echo "Unsupported Linux distribution. Only Fedora is currently supported."
    exit 1
  fi
else
  echo "Unsupported operating system: $OS"
  exit 1
fi

echo "Running Ansible playbook for $PLATFORM..."
ansible-playbook --connection=local --inventory 127.0.0.1, site.yml -K

echo "Setup complete!"
