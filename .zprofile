source $HOME/.zshrc
source $HOME/.config/zsh/.zshenv
#sh $HOME/.scripts/.selfAutostart.sh &
guake --restore-preferences $HOME/.config/guake/.guakeconf &
setxkbmap -option caps:swapescape # not necessary with programmable keyboard
