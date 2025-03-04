if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
    /opt/homebrew/bin/brew shellenv | source
    fish_add_path -g ~/.local/bin
    fzf --fish | source
    uv generate-shell-completion fish | source
    uvx --generate-shell-completion fish | source
    starship init fish | source

    # Modern CLI tool abbreviations
    abbr vim nvim
    abbr l. "eza -la --git --time-style=long-iso --header --group-directories-first -d .*"
    abbr la "eza -la --git --time-style=long-iso --header --group-directories-first"
    abbr ll "eza -l --git --time-style=long-iso --group-directories-first"
    abbr ls eza
    abbr grep rg
    abbr find fd
    abbr cat "bat --style=plain"
    abbr code "code -r"
end

# vim: set ft=fish ts=4 sw=4 et:
