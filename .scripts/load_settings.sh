#!/bin/sh

# README: load terminal, DE etc settings

# load guake settings
guake --restore-preferences $HOME/.config/guake/.guakeconf &

DE=$(echo $DESKTOP_SESSION)

# load gnome settings
if [ "$DE" = 'cinnamon' ]
then
  dconf load /org/gnome/ < $HOME/.config/gnome/gnome-settings
  # dconf load /org/gnome/terminal < $HOME/.config/gnome-terminal/gnome-terminal-settings
elif [ "$DE" = 'budgie-desktop' ]
then
  dconf load /com/solus-project/ < $HOME/.config/budgieDE/budgie-settings
elif [ "$DE" = 'cinnamon' ]
then
  dconf load /org/cinnamon/ < $HOME/.config/cinnamonDE/cinnamon-settings
fi

