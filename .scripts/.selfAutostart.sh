#!/bin/sh

# README: autostart my own programs and settings.
# README-: until I dig out how to add the autostarts to xinit or xsessions so that DE also grabs them, I'll start following processes manually via this script.

xrdb -merge $HOME/.Xresources; xrdb -load $HOME/.Xresources &
#xsetroot -cursor_name left_ptr& # cursor
# setxkbmap -option caps:swapescape # not necessary with programmable keyboard
#nitrogen --restore &
#xbindkeys -p &
#firefox &
guake --restore-preferences $HOME/.config/guake/.guakeconf &
#guake &
# dconf dump /org/cinnamon/desktop/keybindings/ < $HOME/.config/cinnamonDE/dconf-settings.conf # import
dconf load /org/cinnamon/desktop/keybindings/ < $HOME/.config/cinnamonDE/dconf-settings.conf # import cinnamon settings
dconf load /org/cinnamon/theme/ < .config/cinnamonDE/theme-settings.conf # import theme settings
dconf load /org/gnome/terminal/ < $HOME/.config/gnome-terminal/dconf-settings.conf # import gnome-terminal settings

gruvbox_script='$HOME/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh'
if [ -e "$gruvbox_script" ]
then
  sh $gruvbox_script &
fi
 
