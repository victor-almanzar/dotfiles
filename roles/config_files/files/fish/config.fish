if status is-interactive
    # fish
    set -g fish_greeting
    fish_config theme choose tokyonight_night

    # paths
    fish_add_path -g ~/.local/bin
    fish_add_path -g ~/.cargo/bin

    # homebrew
    /opt/homebrew/bin/brew shellenv | source

    # starship
    set -gx STARSHIP_CONFIG "$HOME/.config/starship/config.toml"
    starship init fish | source

    # eza
    set -gx EZA_CONFIG_DIR "$HOME/.config/eza/"

    # fzf
    fzf --fish | source
    set -gx FZF_DEFAULT_COMMAND "fd --type f --strip-cwd-prefix --follow"
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    fzf_key_bindings
    bind --erase \ec
    bind --erase -M insert \ec
    bind \ed fzf-cd-widget
    bind -M insert \ed fzf-cd-widget

    # uv
    uv generate-shell-completion fish | source
    uvx --generate-shell-completion fish | source

    # abbreviations
    abbr vim nvim
    abbr vi nvim
    abbr ga "git add"
    abbr gc "git commit"
    abbr gp "git push"
    abbr gl "git log"
    abbr gd "git diff"
    abbr grep rg
    abbr find fd

    # aliases
    alias ll "eza -lh --git --icons --time-style=iso --git-repos-no-status"
    alias l. "ll -a -d .*"
    alias ls "ll -1"
    alias la "ll -a"
end

# vim: set ft=fish ts=4 sw=4 et:
