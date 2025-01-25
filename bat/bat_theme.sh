#!/bin/bash

# Create the themes directory if it doesn't exist
mkdir -p "$(bat --config-dir)/themes"

# Create a symbolic link to the theme file
ln -s "/Users/valman/.local/share/nvim/lazy/tokyonight.nvim/extras/sublime/tokyonight_night.tmTheme" \
      "$(bat --config-dir)/themes/"

# Update bat's cache to include the new theme
bat cache --build

# Create or modify bat's config file to use the theme
echo "--theme=tokyonight_night" > "$(bat --config-dir)/config"
