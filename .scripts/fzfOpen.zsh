#!/bin/zsh

# README: Run launcher using fzf, similar to dmenu and rofi

# $TERM -e "fzf $* < /proc/$$/fd/0 > /proc/$$/fd/1"
$TERM -e "fdfind --hidden --ignore-case --exclude '.mozilla' -E '.cache' -E '.local' -E '.git' . /bin /usr/bin/ $HOME $HOME/.AppImages | fzf $* > /proc/$$/fd/1"
# $TERM -e "fzf $*"


