# Dotfiles

My personal dotfiles for macOS and Fedora setup using Ansible.

## Features

- Cross-platform support for both macOS and Fedora
- Automated package installation using Homebrew (macOS) and DNF (Fedora)
- Configuration for:
  - Fish shell
  - Tmux
  - Bat
  - Ghostty
  - LazyVim
  - Tokyo Night theme for various tools
- Single command setup

## Requirements

- A fresh macOS or Fedora installation
- Internet connection
- For Fedora: sudo access

## Installation

Simply run:

```bash
./setup.sh
```

This script will:
1. Detect your operating system (macOS or Fedora)
2. Install Homebrew if on macOS and it's not already installed
3. Install Ansible using the appropriate package manager
4. Run the Ansible playbook to install all packages and configure everything

## What Gets Installed

### Package Managers
- Homebrew (macOS only)

### Shell and Terminal
- Fish shell
- Tmux
- Ghostty

### Development Tools
- Neovim (with LazyVim configuration)
- Git
- GitHub CLI (gh)
- Ansible
- Python

### Utilities
- bat (syntax highlighting cat replacement)
- eza (modern ls replacement)
- fd (find replacement)
- fzf (fuzzy finder)
- ripgrep (grep replacement)
- tealdeer (tldr client)
- htop (process viewer)
- lazygit (git TUI)

### Containerization
- Podman
- Podman TUI
- Podlet

### Infrastructure tools
- OpenTofu (Terraform alternative)

## Customization

Edit `playbook.yml` to add or remove packages as needed.

## License

MIT