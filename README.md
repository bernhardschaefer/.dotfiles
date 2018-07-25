Setup
--------

```
DIR=~/ws/git/dotfiles
ln -vs $DIR/zshrc ~/.zshrc
ln -vs $DIR/vimrc ~/.vimrc
ln -vs $DIR/.exports ~/.exports
ln -vs $DIR/.fdignore ~/.fdignore
```

Deprecated?:
```
# markdown italics
tic xterm-256color-italic.terminfo
```

```
# NVIM
mkdir -p ~/.config/nvim/
cat > ~/.config/nvim/init.vim << EOL
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
EOL
```

iTerm
--------

- Install [Powerline Fonts](https://github.com/powerline/fonts)
- Setup iTerm2 solarized profile with Menlo Powerline font and Solarized colorscheme
- Enable word jumps in iTerm2: Preferences → Profiles → Keys → Load Preset... → Natural Text Editing
- Key bindings and fuzzy completion for fzf: `$(brew --prefix)/opt/fzf/install`

conda
-------

```
conda install -y conda_nb
conda install -y pandas numpy scikit-learn matplotlib seaborn
conda install -c conda-forge -y jupyterlab jupyter_contrib_nbextensions autopep8 feather-format
pip install tensorflow-gpu # omit -gpu suffix for CPU version
pip install keras-tqdm
pip install plotly cufflinks
```

