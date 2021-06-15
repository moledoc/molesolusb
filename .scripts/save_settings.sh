#!/bin/sh

# README: save terminal, DE etc settings


# save guake settings
guake --save-preferences $HOME/.config/guake/.guakeconf &

# get DE name
DE=$(echo $DESKTOP_SESSION)

# save gnome settings
# dconf dump /org/gnome/terminal > $HOME/.config/gnome-terminal/gnome-terminal-settings
if [ "$DE" = 'ubuntu' ]
then
  dconf dump /org/gnome/ > $HOME/.config/gnome/gnome-settings
elif [ "$DE" = 'budgie-desktop' ]
then
  dconf dump /com/solus-project/ > $HOME/.config/budgieDE/budgie-settings
elif [ "$DE" = 'cinnamon' ]
then
  dconf dump /org/cinnamon/ > $HOME/.config/cinnamonDE/cinnamon-settings
fi

