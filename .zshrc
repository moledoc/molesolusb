
# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '+' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/utt/.zshrc'

autoload -Uz compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots)

autoload -Uz promptinit
promptinit

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob notify
unsetopt beep
bindkey -v
export KEYTIMEOUT=1
# End of lines configured by zsh-newuser-install

##############
# Self defined

source $HOME/.config/zsh/.zaliases
source $HOME/.config/zsh/.zPmAliases
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Edit command in vim w/ ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Map moving in tab complete to vim keys
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

PS1="%S%2d%s -> "
