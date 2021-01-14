#!/bin/zsh

# README: Use fzf to go-to selected directory.

cd $(fdfind --type d --hidden --ignore-case \
  --exclude '.mozilla' \
  -E '.cache' \
  -E '.local' \
  -E '.git' \
  -E 'x86_64-pc-linux-gnu-library' \
  -E 'JetBrains' \
  -E '.jdks' \
  . $HOME | fzf)
