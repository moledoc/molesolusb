#!/bin/zsh

# README: Script to open or focus given file with defined default opener, depending on the file extension.

# file full path, filename and extension.
if [ -n "$1" ]
then
  file="$1"
  given="yes"
else
  file=$(fd --hidden --ignore-case --exclude '.mozilla' -E '.cache' -E '.local' -E '.git' . /bin /usr/bin/ $HOME $HOME/.AppImages | fzf)
  case "$file" in
    *.*sh)
      action=$(echo "edit\nlaunch" | fzf)
      ;;
  esac
fi
filename=${file##*\/}
filepath=${file%\/*}
extension=${filename##*\.}

# check if file param is empty
if [ -z $file ]
then
  exit
fi

# if is directory, open it in gui file manager
if [ -d "$file" ]
then
  $FILEMANAGER $file &
  exit
fi

# check if file param contains defined cases. 
# If yes, then do according to case.
case "$file" in
  */bin/*)
    $file
    ;;
  *.R|*.Rmd)
    rstudio $file &
    ;;
  *.pdf)
    $READER $file&
    ;;
  *.mp3|*.mp4)
    $MEDIA $file&
    ;;
  *.jpg|*.jpeg|*.png)
    $IMAGES $file &
    ;;
  *.py|*.hs|*.txt|*.csv|*.md|*.scala)
    $EDITOR $file
    ;;
  *.*sh)
    if [ "$given" = "yes" ] || [ "$action" = "edit" ]
    then
      $EDITOR $file
    else
      $SHELL $file
    fi
    ;;
  *Bazecor*.AppImage)
    sudo chmod 666  /dev/ttyACM0; $file&
    ;;
  *.AppImage)
    $file
    ;;
  */.*)
    $EDITOR $file
    ;;
  *)
    $EDITOR $file
    ;;
esac
