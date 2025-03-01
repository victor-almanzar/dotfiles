# CLAUDE.md - AI Assistant Guide

## Commands
- `./setup.sh` - Main installation script (detects OS and runs Ansible playbook)
- `ansible-playbook --connection=local --inventory 127.0.0.1, playbook.yml -K` - Run Ansible playbook manually
- `ansible-lint playbook.yml` - Lint Ansible playbook
- `direnv allow .` - Enable direnv for the project

## Repository Structure
- `config/` - Dotfiles for various applications (fish, tmux, bat, ghostty)
- `var/` - Application-specific data (e.g., Foliate themes)
- `.envrc` - Environment variables for direnv (fixes Ansible collections path)
- `playbook.yml` - Ansible playbook for automated setup
- `setup.sh` - Main setup script

## Code Style
- **YAML**: 2-space indentation for Ansible playbooks
- **Shell Scripts**: 
  - Use `#!/bin/bash` shebang
  - Use `set -e` for error handling
  - Use double quotes for variables: `"$VARIABLE"`
- **Config Files**: Follow each application's standard format
- **Naming**: Use descriptive task names in Ansible playbooks

## Platform Support
- macOS (uses Homebrew)
- Fedora Linux (uses DNF)

## Known Issues
- `ansible-lint` may report "couldn't resolve module/action 'community.general.homebrew'" even when the module exists
  - Solution: Use direnv and .envrc to set proper ANSIBLE_COLLECTIONS_PATH