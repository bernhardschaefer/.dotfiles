#!/bin/bash

DIR=~/ws/git/dotfiles
ln -vs $DIR/.exports ~/.exports
mv ~/.bashrc{,.old}
ln -vs $DIR/bashrc ~/.bash_profile
ln -vs $DIR/vimrc ~/.vimrc

# markdown italics
tic xterm-256color-italic.terminfo

# NVIM
mkdir -p ~/.config/nvim/
cat > ~/.config/nvim/init.vim << EOL
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
EOL

