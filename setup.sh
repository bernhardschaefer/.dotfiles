#!/bin/sh

set -o errexit

cd
if [ ! -d ~/.dotfiles ]; then
    git clone https://github.com/bernhardschaefer/.dotfiles.git
fi

# create symlinks
DIR=~/.dotfiles
# TODO create function that creates a backup for each file if exists (and has according echo)
ln -fvs $DIR/zshrc ~/.zshrc
if [ -f ~/.bashrc ]; then
    mv -v ~/.bashrc ~/.bashrc.old
fi
ln -vs $DIR/bashrc ~/.bashrc
ln -fvs $DIR/vimrc ~/.vimrc
ln -fvs $DIR/.exports ~/.exports
ln -fvs $DIR/.condarc ~/.condarc
ln -fvs $DIR/.fdignore ~/.fdignore
ln -fvs $DIR/.p10k.zsh ~/.p10k.zsh

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# MacVim thin strokes
defaults write org.vim.MacVim AppleFontSmoothing -int 0

# tmux
if [ ! -d ~/.tmux ]; then
    cd
    git clone https://github.com/gpakosz/.tmux.git
    ln -s -f .tmux/.tmux.conf
    cp .tmux/.tmux.conf.local .
fi

git config --global user.name "Bernhard Schäfer"
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global rebase.autoStash true
git config --global fetch.prune true
git config --global diff.colorMoved zebra
