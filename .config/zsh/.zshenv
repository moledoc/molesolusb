
# Export variables
export PATH=$PATH:/usr/local/bin:$HOME/.scripts:$HOME/.AppImages:$HOME/go/bin
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=nvim
export TERMINAL=gnome-terminal
# export BROWSER="firefox --private-window"
export BROWSER="firefox"
export HISTCONTROL=ignoreboth

# export GIT_SSH='ssh -i $HOME/.ssh/github_key'
export elevate="doas --" # sudo

### Set some defaults for opening programs.
### Defined for usage in scripts.
#export FILEMANAGER=nautilus #nemo
#export IMAGES=mupdf-x11 #eog #xviewer #sxiv
#export MEDIA=gnome-mpv #mpv #vlc
#export READER=zathura
#export PASSWD=keepass
##export LOCK=slock

## Define fzf commands
# export FZF_DEFAULT_COMMAND="fdfind --hidden --ignore-case --exclude '.mozilla' -E '.cache' -E '.local' -E '.git' . /bin /usr/bin/ $HOME"
