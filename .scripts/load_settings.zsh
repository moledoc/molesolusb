#!/bin/zsh

# README: load terminal, DE etc settings


# load guake settings
guake --restore-preferences $HOME/.config/guake/.guakeconf &

# load gnome-terminal settings
dconf load /org/gnome/terminal < $HOME/.config/gnome-terminal/gnome-terminal-settings

DE=$(echo $DESKTOP_SESSION)

if [ "$DE" = 'budgie-desktop' ]
then
  dconf load /com/solus-project/budgie-panel < $HOME/.config/budgieDE/panel-settings
  dconf load /com/solus-project/budgie-raven < $HOME/.config/budgieDE/raven-settings
  dconf load /com/solus-project/budgie-wm < $HOME/.config/budgieDE/wm-settings
elif [ "$DE" = 'cinnamon' ]
  dconf load /org/cinnamon/desktop/keybindings/ < $HOME/.config/cinnamonDE/wm-settings
  dconf load /org/cinnamon/theme/ < $HOME/.config/cinnamonDE/theme-settings
fi

