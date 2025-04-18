if status is-interactive
    # fish
    set -g fish_greeting
    fish_config theme choose tokyonight_night

    # paths
    fish_add_path -g ~/.local/bin
    fish_add_path -g ~/.cargo/bin

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

    # nvim
    set -gx EDITOR nvim

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
    alias ls "eza -h --git --icons --time-style=iso --git-repos-no-status"
    alias ll "ls -l --git-ignore"
    alias l. "ls -l -a -d .*"
    alias la "ls -l -a"
    alias l1 "ls -1 --git-ignore"
    alias tree "ls --git-ignore --tree"
    alias trea "ls -a --tree"
end

# vim: set ft=fish ts=4 sw=4 et:
