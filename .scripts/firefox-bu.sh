#!/bin/sh

# README: Backup/restore firefox settings. 

choice=$(echo "backup\nrestore" | fzf)

if [ "$choice" = "backup" ]
then
  # pack .mozilla
  echo "Packing"
  tar -jcvf $HOME/firefox_profile.tar.bz2 $HOME/.mozilla
  # encrypt it
  echo "Encrypting"
  gpg -c $HOME/firefox_profile.tar.bz2
  # copy it to repo
  echo "Coping to $HOME/Documents/molecurrent/.config/mozilla"
  cp $HOME/firefox_profile.tar.bz2.gpg $HOME/Documents/molecurrent/.config/mozilla/
elif [ "$choice" = "restore" ]
then
  # decrypt
  echo "Decrypting"
  gpg $HOME/Documents/molecurrent/.config/mozilla/firefox_profile.tar.bz2.gpg
  # unpack
  echo "Unpacking to $HOME/Documents/molecurrent"
  tar -xvf $HOME/Documents/molecurrent/.config/mozilla/firefox_profile.tar.bz2 --directory $HOME
  echo "Cleaning up"
  rm -f firefox_profile.tar.bz2 --verbose
  # go back to previous dir
  cd -
  rm -f $HOME/Documents/molecurrent/.config/mozilla/firefox_profile.tar.bz2 --verbose
else
  echo "Incorrect argument"
fi
