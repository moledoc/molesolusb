#!/bin/sh

# README: Update the current build to set git repo directory.

# run readmeGen
$SHELL $HOME/.scripts/gen_readme.sh

# define repository location
repo=$HOME/Documents/molecurrent

# save terminal, DE etc settings
$SHELL $HOME/.scripts/save_settings.sh

cp -RLv $HOME/.config/zsh $repo/.config
cp -RLv $HOME/.config/cinnamonDE $repo/.config
cp -RLv $HOME/.config/budgieDE $repo/.config
cp -RLv $HOME/.config/gnome $repo/.config
cp -RLv $HOME/.config/guake $repo/.config
cp -RLv $HOME/.config/gruvbox-xml $repo/.config
cp -RLv $HOME/.config/RStudio $repo/.config # Self added RStudio related files, such as gruvbox theme
cp -RLv $HOME/.config/rstudio $repo/.config # generated rstudio config. If rstudio is downloaded, it should recover all my settings
cp -RLv $HOME/.scripts $repo/


cp -v $HOME/.vimrc $HOME/.xinitrc $HOME/.Xresources $HOME/.zprofile $HOME/.zshrc $HOME/README.md $repo
cp -v $HOME/.config/solarized.vim ${repo}/.config
cp -v $HOME/.config/nvim/init.vim ${repo}/.config/nvim
cp -v $HOME/.config/wallpaper.jpg ${repo}/.config
# $HOME/.profile 

