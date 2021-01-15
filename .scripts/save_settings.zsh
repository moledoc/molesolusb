#!/bin/zsh

# README: save terminal, DE etc settings


# save guake settings
guake --save-preferences $HOME/.config/guake/.guakeconf &

# save gnome settings
# dconf dump /org/gnome/terminal > $HOME/.config/gnome-terminal/gnome-terminal-settings
dconf dump /org/gnome/ > $HOME/.config/gnome/gnome-settings

DE=$(echo $DESKTOP_SESSION)

if [ "$DE" = 'budgie-desktop' ]
then
  dconf dump /com/solus-project/ > $HOME/.config/budgieDE/budgie-settings
elif [ "$DE" = 'cinnamon' ]
  dconf dump /org/cinnamon/ > $HOME/.config/cinnamonDE/cinnamon-settings
fi

