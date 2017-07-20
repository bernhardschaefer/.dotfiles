#!/bin/bash

DIR=~/ws/git/dotfiles
ln -vs $DIR/bashrc ~/.bashrc 
ln -vs $DIR/vimrc ~/.vimrc 

mkdir -p ~/.config/nvim/

cat > ~/.config/nvim/init.vim << EOL
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
EOL

