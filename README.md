Setup
--------

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/bernhardschaefer/.dotfiles/main/setup.sh)"
```

iTerm2
--------

- see also: https://gist.github.com/kevin-smets/8568070
- Solarized profile: Profiles → Colors → Color Presets... → Solarized Light
- Enable word jumps: Profiles → Keys → Key Mappings → Presets... → Natural Text Editing
- Disable Bell:      Profiles → Terminal → Notifications → Silence bell
- Key bindings and fuzzy completion for fzf: `$(brew --prefix)/opt/fzf/install`

macOS
-------

Disable Cmd+Shift+A shortcut so that it can be used in PyCharm:
- https://intellij-support.jetbrains.com/hc/en-us/articles/360005137400-Cmd-Shift-A-hotkey-opens-Terminal-with-apropos-search-instead-of-the-Find-Action-dialog

- Accessibility -> Desktop -> Reduce motion
- Fix blurry fonts on external monitor: https://osxdaily.com/2018/09/26/fix-blurry-thin-fonts-text-macos-mojave/
```shell
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
```

Python
-----

Install nbdime and enable globally (changes ~/.gitconfig)
```shell
nbdime config-git --enable --global
```
