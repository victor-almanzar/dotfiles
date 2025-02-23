if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
    uv generate-shell-completion fish | source
    uvx --generate-shell-completion fish | source
    abbr vi nvim
    abbr vim nvim
    abbr cat "bat --style=plain"
end

# vim: set ft=fish ts=4 sw=4 et:

