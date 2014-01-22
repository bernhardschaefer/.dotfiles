#!/bin/sh

# Contains Linux commands that need to run at startup (Not really a dotfile)
# Can be run in Ubuntu by defining a startup program in "Startup Applications" using the command "sh path/to/dotfiles/linux-startup.sh"

# ----- Keyboard Settings -----

# clear all previous options
setxkbmap -option

# Set caps as escape
# setxkbmap -option caps:escape
# Swap caps and escape
setxkbmap -option caps:swapescape

# Switch between us/de keyboard using alt+shift (ubuntu 13.10 text entry settings are buggy)
setxkbmap -option grp:alt_shift_toggle us,de

# verify correct settings
# setxkbmap -query
