# Dotfiles

Personal dotfiles managed with Ansible.

## Overview

This repository contains configuration files for various tools and applications, organized as Ansible roles for easy deployment across Fedora Workstation and Fedora Asahi Linux.

## Structure

- `roles/`:
  - `01_packages/`: Packages
  - `02_config_files/`: Config Files
  - `03_lazyvim/`: LazyVim
  - `04_nerdfont/`: Nerd Fonts
  - `04_post_config/`: Post tasks

## Usage

Run the setup script to deploy configurations:

```bash
./setup.sh
```
