# Dotfiles for Termux

## Dependencies

Dotfiles are managed using [GNU Stow](https://www.gnu.org/software/stow/).


## Instructions

Install packages
```
pkg install bat fish git git-delta gopass neovim-nightly newsboat starship stow
```

1. Clone repository
```
git clone git@github.com:ishrq/termux.git ~/.dotfiles/
```

2. Change directory
```
cd ~/.dotfiles/
```

3. Copy configs with Stow
```
stow -S bat fish git gopass newsboat nvim scripts starship termux
```

