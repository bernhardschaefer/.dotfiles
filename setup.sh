#!/bin/sh

cd
if [ ! -d ~/.dotfiles ]; then
    git clone https://github.com/bernhardschaefer/.dotfiles.git
fi

# create symlinks
DIR=~/.dotfiles
ln -vs $DIR/zshrc ~/.zshrc
mv -v ~/.bashrc ~/.bashrc.old
ln -vs $DIR/bashrc ~/.bashrc
ln -vs $DIR/vimrc ~/.vimrc
ln -vs $DIR/.exports ~/.exports
ln -vs $DIR/.condarc ~/.condarc
ln -vs $DIR/.fdignore ~/.fdignore

# tmux
if [ ! -d ~/.tmux ]; then
    cd
    git clone https://github.com/gpakosz/.tmux.git
    ln -s -f .tmux/.tmux.conf
    cp .tmux/.tmux.conf.local .
fi

git config --global user.name "Bernhard Schäfer"
