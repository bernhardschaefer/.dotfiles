#!/bin/sh

# Contains Linux commands that need to run at startup (Not really a dotfile)
# Can be run in Ubuntu by defining a startup program in "Startup Applications" using the command "sh path/to/dotfiles/linux-startup.sh"

# ----- Keyboard Settings -----

# --- Swap caps and escape ---

# direct way:
# setxkbmap -option caps:swapescape

# dconf setting seems to be more reliable
dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape']"

# --- Switch between keyboards using alt+shift ---
# (ubuntu 13.10 text entry settings are buggy)

# direct way:
# setxkbmap -option grp:alt_shift_toggle us,de

# ppa fix 'Modifier-only input switch' 
# http://askubuntu.com/questions/356357/how-to-use-altshift-to-switch-keyboard-layouts-in-13-10


# verify correct settings
# setxkbmap -query
