#!/bin/sh
# Script to save current path to a variable 'cur'
# The main magic for setting the current path to variable 'cur' happens in .bash_aliases or .zsh_aliases
# running alias 'cur' the following command is launched: . ~/scripts/current.sh
# This runs the contens of this script again in the terminal, meaning the variable 'cur' is set with value $PWD.

cur=$PWD
