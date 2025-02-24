# Run this inside of dotfiles/setup/

# dnf copr
# dnf install
# fisher install script


# First things first, clone nvim
# but do I have to have Nvim installed already? I dont think so.
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# -S means “stow” (i.e. install the symlinks).
# -t ~/.config tells stow to place the symlinks in your ~/.config directory.
# -d /home/Projects/dotfiles tells stow where your dotfiles (stow directory) reside.
# .config is the package (folder) you want to process.

# below /home/valman/Projects/dotfiles is my repo with a .git inside of it
# I want to make sure first that every single one of these files already exists
stow -S -t ~/.config/alacritty/ -d ./config/alacritty/ alacritty.toml
stow -S -t ~/.config/tmux/ -d ./config/tmux/ tmux.conf
# stow -S -t ~/.config/fish/ -d ./config/fish/ config.fish
# stow -S -t ~/.config/fish/ -d ./config/fish/ fish_plugins
stow -S -t ~/.config/fish/ -d ./config/fish/ *
stow -S -t ~/.config/bat/ -d ./config/bat/ config
stow -S -t ~/.config/nvim/lua/plugins/ -d ./config/nvim/lua/plugins/ colorscheme.lua

# Create a symbolic link to the theme file
ln -s "$HOME/.local/share/nvim/lazy/tokyonight.nvim/extras/sublime/tokyonight_night.tmTheme" \
"$(bat --config-dir)/themes/"

# Update bat's cache to include the new theme
bat cache --build

ln -s "$HOME/.local/share/nvim/lazy/tokyonight.nvim/extras/eza/tokyonight.yml" \
"$HOME/.config/eza/tokyonight.yml"



# TODO:
# 1. dnf copr gets sourced
# 2. dnf pkgs gets installed
# 3. anything pre stow gets done, lazyvim and fisher
# 4. stow
# 5. flatpaks
#
# Also, I dont like actual dotfiles in this repo. change .config and .var into
# config and var
