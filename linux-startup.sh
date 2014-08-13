#!/bin/sh

# Contains Linux commands that need to run at startup (Not really a dotfile)
# Can be run in Ubuntu by defining a startup program in "Startup Applications" using the command "sh path/to/dotfiles/linux-startup.sh"

# ----- Keyboard Settings -----

# --- Swap caps and escape ---

# direct way:
# setxkbmap -option caps:swapescape

# dconf setting seems to be more reliable
# dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape']"
dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"

# verify correct settings
# setxkbmap -query
