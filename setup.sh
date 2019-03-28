#!/bin/sh

cd
if [ ! -d ~/.dotfiles ]; then
    git clone https://github.com/bernhardschaefer/.dotfiles.git
fi

# create symlinks
DIR=~/.dotfiles
ln -fvs $DIR/zshrc ~/.zshrc
mv -v ~/.bashrc ~/.bashrc.old
ln -vs $DIR/bashrc ~/.bashrc
ln -fvs $DIR/vimrc ~/.vimrc
ln -fvs $DIR/.exports ~/.exports
ln -fvs $DIR/.condarc ~/.condarc
ln -fvs $DIR/.fdignore ~/.fdignore

# jupyter lab
mkdir -p ~/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension/
ln -fvs $DIR/jupyter/plugin.jupyterlab-settings ~/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension/plugin.jupyterlab-settings

# tmux
if [ ! -d ~/.tmux ]; then
    cd
    git clone https://github.com/gpakosz/.tmux.git
    ln -s -f .tmux/.tmux.conf
    cp .tmux/.tmux.conf.local .
fi

git config --global user.name "Bernhard Schäfer"
