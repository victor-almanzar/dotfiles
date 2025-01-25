if status is-interactive
    eval (/opt/homebrew/bin/brew shellenv)
    source (/opt/homebrew/bin/starship init fish --print-full-init | psub)
    uv generate-shell-completion fish | source
    uvx --generate-shell-completion fish | source
    # Commands to run in interactive sessions can go here
    abbr vim "nvim"
    abbr cat "bat --style=plain"
    set -g fish_greeting

     # Set fzf configuration file
    set -gx FZF_DEFAULT_OPTS_FILE ~/.config/fzf.conf

    source (/opt/homebrew/bin/fzf --fish | psub)

    # Unbind the default fzf keys
    bind -e \ct  # Unbind Ctrl+T
    bind -e \cr  # Unbind Ctrl+R
    bind -e \ec  # Unbind Alt+C
    # Then override the bindings
    bind -k nul fzf-file-widget  # Ctrl+Space
    bind \e/ fzf-history-widget  # Alt+/
    bind \e. fzf-cd-widget  # Alt+.

    # uv
    fish_add_path "/Users/valman/.local/bin"
    # go
    fish_add_path "/Users/valman/go/bin"
end

# vim: set ft=fish ts=4 sw=4 et: vim: set ft=fish ts=4 sw=4 et:

