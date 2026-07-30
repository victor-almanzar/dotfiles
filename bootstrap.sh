#!/bin/sh
set -eu

repo_url="${DOTFILES_REPO_URL:-https://github.com/victor-almanzar/dotfiles.git}"
config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
repo_dir="${DOTFILES_DIR:-$config_home/mise/dotfiles}"
mise_bin="${MISE_INSTALL_PATH:-$HOME/.local/bin/mise}"

if ! command -v curl >/dev/null 2>&1; then
  echo "dotfiles bootstrap: curl is required" >&2
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "dotfiles bootstrap: git is required" >&2
  exit 1
fi

if command -v mise >/dev/null 2>&1; then
  mise_bin="$(command -v mise)"
elif [ ! -x "$mise_bin" ]; then
  curl --proto '=https' --tlsv1.2 -fsSL https://mise.run |
    MISE_INSTALL_PATH="$mise_bin" sh
fi

if [ -d "$repo_dir/.git" ]; then
  git -C "$repo_dir" pull --ff-only
elif [ -e "$repo_dir" ]; then
  echo "dotfiles bootstrap: $repo_dir exists but is not a Git checkout" >&2
  exit 1
else
  mkdir -p "$(dirname "$repo_dir")"
  git clone "$repo_url" "$repo_dir"
fi

config_file="$repo_dir/config-mise/config.toml"
"$mise_bin" trust "$config_file"

targets_file="$(mktemp)"
trap 'rm -f -- "$targets_file"' EXIT HUP INT TERM

"$mise_bin" config get -f "$config_file" dotfiles |
  sed -n 's/^\["\(~\/.*\)"\]$/\1/p' > "$targets_file"

backup_dir=""
while IFS= read -r target; do
  target="$HOME/${target#\~/}"

  # Mise can safely repoint symlinks, including broken ones. Only real files
  # and directories need to be moved out of its way.
  if [ -L "$target" ] || [ ! -e "$target" ]; then
    continue
  fi

  if [ -z "$backup_dir" ]; then
    state_home="${XDG_STATE_HOME:-$HOME/.local/state}"
    backup_dir="$state_home/dotfiles/backups/$(date +%Y%m%d-%H%M%S)-$$"
  fi

  relative_target="${target#"$HOME"/}"
  backup_target="$backup_dir/$relative_target"
  mkdir -p "$(dirname "$backup_target")"
  mv -- "$target" "$backup_target"
  echo "dotfiles bootstrap: backed up $target"
done < "$targets_file"

if [ -n "$backup_dir" ]; then
  echo "dotfiles bootstrap: existing files were preserved in $backup_dir"
fi

MISE_CONFIG_DIR="$repo_dir/config-mise" "$mise_bin" bootstrap --yes

echo
echo "dotfiles bootstrap: running mise doctor"
"$mise_bin" doctor

echo
if [ -n "$backup_dir" ]; then
  echo "Previous dotfiles backup: $backup_dir"
fi
echo "Dotfiles bootstrap complete. Start a new shell to load the new environment."
