Setup
--------

```shell
wget -O - https://raw.githubusercontent.com/bernhardschaefer/.dotfiles/master/setup.sh | bash
```

iTerm
--------

- Setup iTerm2 solarized profile: Profiles → Colors → Color Presets... → Solarized Light
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
- Fix blurry fonts on external monitor: https://osxdaily.com/2018/09/26/fix-blurry-thin-fonts-text-macos-mojave/
```shell
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
```

