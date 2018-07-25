Setup
--------

Symlinks:
```
DIR=~/ws/git/dotfiles
ln -vs $DIR/zshrc ~/.zshrc
ln -vs $DIR/vimrc ~/.vimrc
ln -vs $DIR/.exports ~/.exports
ln -vs $DIR/.fdignore ~/.fdignore
```

tmux:
```
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
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
conda install -c conda-forge jupyter_contrib_nbextensions autopep8
conda install -c conda-forge jupyterlab
conda install -c conda-forge feather-format 
pip install tensorflow-gpu # omit -gpu suffix for CPU version
pip install keras-tqdm
pip install plotly cufflinks
```

macOS
-------

- Accessibility -> Desktop -> Reduce motion

