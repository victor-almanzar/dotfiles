if status is-interactive
    set -g fish greeting
    set ZELLIJ_AUTO_ATTACH true
    set ZELLIJ_AUTO_EXIT true
    if command -q zellij
        eval (zellij setup --generate-auto-start fish | string collect)
    end
    if test -x ~/.local/bin/mise
        ~/.local/bin/mise activate fish | source
    end
    command -q hx; and abbr vi hx; and set -gx EDITOR hx
    command -q bat; and abbr cat bat
    command -q lazygit; and abbr lg lazygit
end
