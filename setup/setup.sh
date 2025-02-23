Here:

    -S means “stow” (i.e. install the symlinks).
    -t ~/.config tells stow to place the symlinks in your ~/.config directory.
    -d /home/Projects/dotfiles tells stow where your dotfiles (stow directory) reside.
    .config is the package (folder) you want to process.

stow -S -t ~/.config/alacritty/ -d /home/valman/Projects/dotfiles/.config/alacritty/ alacritty.toml
stow -S -t ~/.config/alacritty/ -d /home/valman/Projects/dotfiles/.config/alacritty/ tmux.toml

stow -S -t ~
