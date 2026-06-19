#!/usr/bin/env bash
set -e

echo "Installing mise..."
curl https://mise.run | sh

export PATH="$HOME/.local/bin:$PATH"
eval "$(mise activate bash)"

echo "Installing chezmoi..."
mise use -g chezmoi

echo "Applying dotfiles..."
chezmoi init victor-almanzar/dotfiles --apply

echo "Installing tools..."
mise install

echo "Done. Restart your shell or run: source ~/.bashrc"
