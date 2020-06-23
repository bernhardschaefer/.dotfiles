#!/bin/sh

set -o errexit

cd
if [ ! -d ~/.dotfiles ]; then
    git clone https://github.com/bernhardschaefer/.dotfiles.git
fi

# create symlinks
DIR=~/.dotfiles
ln -fvs $DIR/zshrc ~/.zshrc
if [ -f ~/.bashrc ]; then
    mv -v ~/.bashrc ~/.bashrc.old
fi
ln -vs $DIR/bashrc ~/.bashrc
ln -fvs $DIR/vimrc ~/.vimrc
ln -fvs $DIR/.exports ~/.exports
ln -fvs $DIR/.condarc ~/.condarc
ln -fvs $DIR/.fdignore ~/.fdignore

# tmux
if [ ! -d ~/.tmux ]; then
    cd
    git clone https://github.com/gpakosz/.tmux.git
    ln -s -f .tmux/.tmux.conf
    cp .tmux/.tmux.conf.local .
fi

git config --global user.name "Bernhard Schäfer"

# macvim enable thin fonts
#defaults write org.vim.MacVim AppleFontSmoothing -int 0
