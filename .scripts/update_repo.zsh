#!/bin/zsh

# README: Update the current build to set git repo directory.

# run readmeGen
$SHELL $HOME/.scripts/gen_readme.zsh

# define repository location
repo=$HOME/Documents/molecurrent

# save terminal, DE etc settings
save_settings.zsh

cp -RL $HOME/.config/zsh $repo/.config
cp -RL $HOME/.config/cinnamonDE $repo/.config
cp -RL $HOME/.config/budgieDE $repo/.config
cp -RL $HOME/.config/gnome $repo/.config
cp -RL $HOME/.config/guake $repo/.config
cp -RL $HOME/.config/gruvbox-xml $repo/.config
cp -RL $HOME/.config/RStudio $repo/.config # Self added RStudio related files, such as gruvbox theme
cp -RL $HOME/.config/rstudio $repo/.config # generated rstudio config. If rstudio is downloaded, it should recover all my settings
cp -RL $HOME/.scripts $repo/


cp $HOME/.setup.sh $HOME/.vimrc $HOME/.xinitrc $HOME/.Xresources $HOME/.zprofile $HOME/.zshrc $HOME/README.md $repo
# $HOME/.profile 

