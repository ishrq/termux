# Dot-files for Termux

Managed using [GNU Stow](https://www.gnu.org/software/stow/).


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

3. Create symlink with Stow
```
stow -S bat fish git gopass newsboat nvim scripts starship termux
```

Delete symlink: `stow -D package`

Re-add symlink: `stow -R package`


### Fish Plugins

Fish plugins managed with [Fisher](https://github.com/jorgebucaran/fisher)

Install Fisher:

```
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
```

Install plugins:

[Patrickf1/fzf.fish](https://github.com/PatrickF1/fzf.fish)
```
fisher install Patrickf1/fzf.fish
```

[meaningful-ooo/sponge](https://github.com/meaningful-ooo/sponge)
```
fisher install meaningful-ooo/sponge
```

[jorgebucaran/autopair.fish](https://github.com/jorgebucaran/autopair.fish)
```
fisher install jorgebucaran/autopair.fish
```

Update plugin: `fisher update <plugin`

Update all: `fisher update`

Remove plugin: `fisher remove <plugin>`

Remove all: `fisher list | fisher remove`
