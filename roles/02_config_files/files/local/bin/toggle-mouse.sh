#!/bin/bash

# Function to send notifications
notify() {
  notify-send "Mouse Control" "$1" --icon=input-mouse
}

# Get current touchpad status
touchpad_status=$(gsettings get org.gnome.desktop.peripherals.touchpad send-events)
# Get current cursor size
cursor_size=$(gsettings get org.gnome.desktop.interface cursor-size)

if [ "$touchpad_status" = "'enabled'" ] || [ "$cursor_size" != "0" ]; then
  # Disable touchpad and hide cursor
  gsettings set org.gnome.desktop.peripherals.touchpad send-events disabled
  gsettings set org.gnome.desktop.interface cursor-size 0
  notify "Touchpad disabled and cursor hidden"
else
  # Enable touchpad and show cursor
  gsettings set org.gnome.desktop.peripherals.touchpad send-events enabled
  gsettings set org.gnome.desktop.interface cursor-size 24
  notify "Touchpad enabled and cursor visible"
fi
