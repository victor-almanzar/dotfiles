if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
    uv generate-shell-completion fish | source
    uvx --generate-shell-completion fish | source
    
    # Editor abbreviations
    abbr vi nvim
    abbr vim nvim
    
    # Modern CLI tool abbreviations
    abbr l. "eza -la --git --time-style=iso-short --group-directories-first .*"
    abbr ll "eza -la --git --time-style=iso-short --group-directories-first"
    abbr ls "eza"
    abbr grep "rg"
    abbr find "fd"
    abbr cat "bat --style=plain"
end

# vim: set ft=fish ts=4 sw=4 et:

