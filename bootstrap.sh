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

if [ "${DOTFILES_FORCE:-0}" = "1" ]; then
  MISE_CONFIG_FILE="$config_file" "$mise_bin" bootstrap --yes --force-dotfiles
else
  if ! MISE_CONFIG_FILE="$config_file" "$mise_bin" bootstrap --yes; then
    cat >&2 <<'EOF'

dotfiles bootstrap: setup did not complete.

If mise reported existing dotfile conflicts, either move those files somewhere
safe and rerun this script, or explicitly replace them with:

  curl --proto '=https' --tlsv1.2 -fsSL \
    https://raw.githubusercontent.com/victor-almanzar/dotfiles/main/bootstrap.sh |
    DOTFILES_FORCE=1 sh
EOF
    exit 1
  fi
fi

echo
echo "Dotfiles bootstrap complete. Start a new shell to load the new environment."
