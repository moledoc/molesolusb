#!/bin/sh

# README: setup user system, after git pull.

# Set up root passwd
echo "Set root passwd"
sudo passwd

# update repository
# CHANGE ACCORDING TO PACKAGE MANAGER!!!
updateCmd="sudo eopkg upgrade"
installCmd="eopkg install"
pkg_manager="eopkg"

# Download packages.
packages="zsh zsh-syntax-highlighting guake neovim vim firefox fzf keepass htop fd ripgrep zathura-mupdf tmux xclip git"
additional_pkg="vlc redshift wget tmux" 

# dconf-cli to load cinnamon keyboard shortcuts in/out
# wmctrl to list window processes
programming_pkg="rstudio vscode"

if [ ! -z "$installCmd" ]
then
	echo "Installing packages: $packages $programming_pkg #$additional_pkg"
	sudo $installCmd $packages $programming_pkg #$additional_pkg 
  echo "Packages installed"
else
	echo "Missing argument, exiting script!"
	exit
fi

# swap esc and caps
setxkbmap -option caps:swapescape
echo "CapsLock and escape swapped"

# change shell to zsh
# echo "What user's shell do we change?"
# read user
new_shell="zsh"
echo "Changing shell to $new_shell"
chsh -s /bin/$new_shell
echo "Shell changed to $new_shell"

# set up git
echo "Setting up git for user"
echo "Insert git --global user.name: " 
read varUsername
git config --global user.name "$varUsername"
echo "Insert git --global user.email: " 
read varEmail
git config --global user.email "$varEmail"
echo "Minimal git config set up"

# create ssh key for github
echo "Create ssh key for accessing git."
mkdir $HOME/.ssh
ssh-keygen -t rsa -b 4096 -C "$varEmail" -f $HOME/.ssh/github_key -P ""
# change git remote from https to ssh
echo "Change git remote from https to ssh"
git remote set-url origin git@github.com:moledoc/molecurrent.git  
echo "Copy github_key.pub to clipboard"
xclip -selection clipboard < $HOME/.ssh/github_key.pub

echo "IGNORE THESE cp ERRORS"
# Copy contents of the repository to the right places.
cp -r .scripts .config $HOME > /dev/null
# cp .setup.sh .x* .X* .z* $HOME
cp .* $HOME
echo "Repository contents copied to $HOME"

# add symlink to package manager aliases
rm -f $HOME/.config/$new_shell/.z_pm_aliases
ln -s $HOME/.config/$new_shell/.z_${pkg_manager}_aliases $HOME/.config/$new_shell/.z_pm_aliases
echo "Symlink to package manager aliases created"

# install VimPlug (nvim/vim pluggin manager)
echo "Install VimPlug to $HOME/.config/nvim/plugged"
mkdir -p $HOME/.config/nvim/plugged
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs\
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "Run PlugInstall, to install defined pluggins to neovim"
nvim +PlugInstall +qa

# add gruvbox for vim as well
echo "Add gruvbox colorscheme to vim colors"
sudo cp $HOME/.config/nvim/plugged/gruvbox/colors/gruvbox.vim /usr/share/vim/vim8*/colors

## Setup bazecor, the DygmaRaise keyboard tool.
#echo "Install Bazecor for Dygma keyboard"
#mkdir $HOME/.AppImages
#echo "Directory $HOME/.AppImages made"
#wget --output-file=$HOME/.AppImages/Bazecor.AppImage https://github.com/Dygmalab/Bazecor/releases/download/bazecor-0.2.6/Bazecor-0.2.6.AppImage
#chmod +x $HOME/.AppImages/Bazecor.AppImage
#rm Bazecor-0.2.6.AppImage
#echo "Bazecor installed"

# pull additional repos, if ssh key is set.
echo "Is ssh key added to github? (if added, type 'yes'; if not, but this is wanted, then do it now and then type 'yes')" 
read hasSSHKey
if [ "$hasSSHKey" = "yes" ]
then
  echo "Download other repositories"
  eval $(ssh-agent -s);ssh-add $HOME/.ssh/github_key
  cd $HOME/Pictures
  git clone https://github.com/moledoc/wallpapers.git
  cd $HOME/Documents
  git clone https://github.com/moledoc/dygmaraise.git
  #git clone https://github.com/moledoc/showcase.git
  #git clone https://github.com/moledoc/parse.json.git
  killall ssh-agent&
  cd
fi

## make guake dropdown terminal autostarting
#echo "Make guake dropdown terminal autostarting"
#sudo cp /usr/share/applications/guake.desktop /etc/xdg/autostart

#echo "Visit github repo and add the ssh public key to allowed ssh keys (public key should be copied to the clipboard)!"
echo "Setup DONE!"
