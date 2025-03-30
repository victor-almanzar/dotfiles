# Dotfiles

Personal dotfiles managed with Ansible.

## Overview

This repository contains configuration files for various tools and applications, organized as Ansible roles for easy deployment across different systems.

## Structure

- `roles/`: Contains Ansible roles
  - `config_files/`: Configuration files for tools like bat, eza, fish, git, etc.
  - `lazyvim/`: LazyVim Neovim configuration
  - `packages/`: Package installation management
  - `post_config/`: Post-installation configuration tasks

## Usage

Run the setup script to deploy configurations:

```bash
./setup.sh
```

## Supported Platforms

- Fedora
- macOS