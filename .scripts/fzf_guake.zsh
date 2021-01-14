#!/bin/zsh

# README: fzf runner in guake new tab (closes the tab and hides guake after finishing). Takes one argument. Preferably $1 is a script(s) and/or command(s)that use fzf output $sel. CURRENTLY NOT IN USE!!!

# guake --new-tab $HOME -e "sel=\$(fdfind --hidden --ignore-case --exclude '.mozilla' -E '.cache' -E '.local' -E '.git' . /bin /usr/bin/ $HOME $HOME/.AppImages | fzf);$1 \$sel;guake --hide;exit" --show
guake --new-tab $HOME -e "sel=\$(fdfind --hidden --ignore-case --exclude '.mozilla' -E '.cache' -E '.local' -E '.git' . /bin /usr/bin/ $HOME $HOME/.AppImages | fzf);$1;guake --hide;exit" --show
