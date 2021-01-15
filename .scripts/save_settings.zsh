#!/bin/zsh

# README: save terminal, DE etc settings


# save guake settings
guake --save-preferences $HOME/.config/guake/.guakeconf &

# save gnome-terminal settings
dconf dump /org/gnome/terminal > $HOME/.config/gnome-terminal/gnome-terminal-settings

DE=$(echo $DESKTOP_SESSION)

if [ "$DE" = 'budgie-desktop' ]
then
  dconf dump /com/solus-project/budgie-panel > $HOME/.config/budgieDE/panel-settings
  dconf dump /com/solus-project/budgie-raven > $HOME/.config/budgieDE/raven-settings
  dconf dump /com/solus-project/budgie-wm > $HOME/.config/budgieDE/wm-settings
elif [ "$DE" = 'cinnamon' ]
  dconf dump /org/cinnamon/desktop/keybindings/ > $HOME/.config/cinnamonDE/wm-settings
  dconf dump /org/cinnamon/theme/ > .config/cinnamonDE/theme-settings
fi

