# Dotfiles

Personal dotfiles managed with Ansible.

## Overview

This repository contains configuration files for various tools and applications, organized as Ansible roles for easy deployment across Fedora Workstation and Fedora Asahi Linux.

## Structure

- `roles/`: Contains Ansible roles
  - `01_packages/`: Package installation management
  - `02_config_files/`: Configuration files for tools like bat, eza, fish, git, etc.
  - `03_lazyvim/`: LazyVim Neovim configuration
  - `04_post_config/`: Post-installation configuration tasks

## Usage

Run the setup script to deploy configurations:

```bash
./setup.sh
```

## Supported Platforms

- Fedora
