#!/bin/zsh

# README: Update the current build to set git repo directory.

# run readmeGen
$SHELL $HOME/.scripts/readmeGen.zsh

# define repository location
repo=$HOME/Documents/molelinux

dconf dump /org/cinnamon/desktop/keybindings/ > $HOME/.config/cinnamonDE/dconf-settings.conf # export (cinnamon keybindings)
dconf dump /org/cinnamon/theme/ > $HOME/.config/cinnamonDE/theme-settings.conf # export theme settings
dconf dump /org/gnome/terminal/ > $HOME/.config/gnome-terminal/dconf-settings.conf # gnome-terminal settings
guake --save-preferences $HOME/.config/guake/.guakeconf # save guake keybindings

cp -RL $HOME/.config/zsh $repo/.config
cp -RL $HOME/.config/cinnamonDE $repo/.config
cp -RL $HOME/.config/gnome-terminal $repo/.config
cp -RL $HOME/.config/guake $repo/.config
cp -RL $HOME/.config/tilda $repo/.config
cp -RL $HOME/.config/gruvbox-xml $repo/.config
cp -RL $HOME/.config/RStudio $repo/.config # Self added RStudio related files, such as gruvbox theme
cp -RL $HOME/.config/rstudio $repo/.config # generated rstudio config. If rstudio is downloaded, it should recover all my settings
cp -RL $HOME/.scripts $repo/


cp $HOME/.setup.sh $HOME/.vimrc $HOME/.xinitrc $HOME/.Xresources $HOME/.zprofile $HOME/.zshrc $HOME/README.md $HOME/.xbindkeysrc $HOME/.profile $repo


