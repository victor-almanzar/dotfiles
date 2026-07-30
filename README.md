# dotfiles

Personal workstation configuration managed by
[mise](https://mise.jdx.dev/).

## Bootstrap

The target machine needs `curl`, `git`, and standard TLS certificates. Mise
will be installed automatically when it is not already available.

```sh
curl --proto '=https' --tlsv1.2 -fsSL \
  https://raw.githubusercontent.com/victor-almanzar/dotfiles/main/bootstrap.sh |
  sh
```

The repository is cloned to `${XDG_CONFIG_HOME:-$HOME/.config}/mise/dotfiles`.
`mise bootstrap` then links the managed configuration, installs the declared
tools, and regenerates the Nushell integrations.

The bootstrap is safe to run again. An existing checkout is updated with a
fast-forward-only pull before mise converges the machine.
