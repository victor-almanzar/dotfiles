if status is-interactive
    # todoist
    [ -f ~/.config/tabtab/fish/__tabtab.fish ];
    and . ~/.config/tabtab/fish/__tabtab.fish; or true
    [ -f ~/.local/bin/mise ];
    and ~/.local/bin/mise activate fish | source
end

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
