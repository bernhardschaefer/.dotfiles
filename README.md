Setup
--------

For setting up dotfiles see: `setup.sh`

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

New env:
```
conda create -n py37-ds -y python=3.7 numpy pandas jupyterlab seaborn matplotlib
conda activate py37-ds
jupyter labextension install @jupyterlab/toc
```

macOS
-------

- Accessibility -> Desktop -> Reduce motion

