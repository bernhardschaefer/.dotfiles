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

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k font (automatically installs when opening a new iterm2 window)
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

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

# macvim enable thin fonts
#defaults write org.vim.MacVim AppleFontSmoothing -int 0
