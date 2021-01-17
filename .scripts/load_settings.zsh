#!/bin/zsh

# README: load terminal, DE etc settings

# load guake settings
guake --restore-preferences $HOME/.config/guake/.guakeconf &

# load gnome settings
dconf load /org/gnome/ < $HOME/.config/gnome/gnome-settings
# dconf load /org/gnome/terminal < $HOME/.config/gnome-terminal/gnome-terminal-settings

DE=$(echo $DESKTOP_SESSION)

if [ "$DE" = 'budgie-desktop' ]
then
  dconf load /com/solus-project/ < $HOME/.config/budgieDE/budgie-settings
elif [ "$DE" = 'cinnamon' ]
then
  dconf load /org/cinnamon/ < $HOME/.config/cinnamonDE/cinnamon-settings
fi

