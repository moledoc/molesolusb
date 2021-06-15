#!/bin/sh

# README: setup user system, after git pull.

# should exit script, when it fails
set -e

notice()
{
  echo "--------------------------------------"
  echo $1
  echo "--------------------------------------"
}

# set update, install, package manager etc variables
sleeping=5
case "$1" in
  arch)
    updateCmd="sudo pacman --color=always -Syu"
    installCmd="pacman -S"
    pkg_manager="pacman"
    extraCmds=""
    dryRun=""
    echo "Setup for Arch will start in ${sleeping}sec (Ctrl+c to cancel)"
    echo "THIS IS DEPR AT THE MOMENT"
    exit
    ;;
  solus)
    updateCmd="sudo eopkg upgrade -y"
    installCmd="eopkg install -y"
    pkg_manager="eopkg"
    extraCmds="sudo eopkg install -c system.devel" # https://getsol.us/articles/package-management/basics/en/#base-development-tools
    dryRun="--dry-run"
    echo "Setup for Solus will start in ${sleeping}sec (Ctrl+c to cancel)"
    ;;
  ubuntu|debian)
    updateCmd="sudo apt update; sudo apt upgrade"
    installCmd="apt install"
    pkg_manager="apt"
    extraCmds=""
    dryRun="--dry-run"
    echo "Setup for Ubuntu(/Debian) will start in ${sleeping}sec (Ctrl+c to cancel)"
    ;;
  *)
    echo "Selected distro is not supported"
    echo "run again as: ./.setup.sh (ubuntu|debian,solus,(depreciated currently)arch)"
    exit
    ;;
esac

# Give user ${sleeping}sec to cancel setup
sleep ${sleeping}

# get user name
user=$(who)
user=${user%% *}

# Download packages (set for ubuntu atm).
packages="zsh zsh-syntax-highlighting guake neovim vim firefox fzf wget curl keepassxc htop fd-find ripgrep zathura-pdf-poppler xclip dconf-cli dash exa" #alacritty 
additionalPkgs="gnome-boxes transmission redshift tmux eog gnome-mpv texlive pandoc" #vlc  libxtst-devel libpng-devel
forFun="cowsay"

# dash = minimal posix complient shell
# gnome-boxes = VM
# transmission = torrent
# eog - eye of gnome
# dconf-cli to load gnome/cinnamon/budgie settings
# wmctrl to list window processes
# libxtst-devel libpng-devel -- for some R packages
#programming_pkg="rstudio vscode"

if [ ! -z "$installCmd" ]
then
  notice "Update package manager"
  eval $updateCmd
  eval $extraCmds
  notice "Dry run package installation"
	$installCmd $dryRun $packages $forFun #$programming_pkg #$additionalPkgs 
	notice "Installing packages: $packages $forFun" # $programming_pkg #$additionalPkgs
	sudo $installCmd $packages $forFun #$programming_pkg #$additionalPkgs 
  notice "Packages installed"
else
	notice "Missing argument, exiting script!"
	exit
fi

# swap esc and caps
notice "Swapping CapsLock and escape"
setxkbmap -option caps:swapescape
notice "CapsLock and escape swapped"

# change shell to dash
# read user
new_shell="dash"
notice "Changing shell to $new_shell"
chsh -s /bin/$new_shell
notice "Shell changed to $new_shell"

# set up minimal git
notice "Setting up git for user"
echo "Insert git --global user.name: " 
read varUsername
git config --global user.name "$varUsername"
echo "Insert git --global user.email: " 
read varEmail
git config --global user.email "$varEmail"
notice "Minimal git config set up"

# create ssh key for github
notice "Create ssh key for accessing git."
if [ ! -d "$HOME/.ssh" ]; then mkdir -v $HOME/.ssh; fi
ssh-keygen -t rsa -b 4096 -C "$varEmail" -f $HOME/.ssh/github_key -P ""
# change git remote from https to ssh
notice "Change git remote from https to ssh"
git remote -v set-url origin git@github.com:moledoc/molecurrent.git  

notice "Copy repository to $HOME"
# Copy contents of the repository to the right places.
cp -vr .scripts .config $HOME 
# cp .setup.sh .x* .X* .z* $HOME
cp -v README.md .vimrc .xinitrc .Xresources .zprofile .zshrc $HOME
notice "Repository contents copied to $HOME"

# add symlink to package manager aliases
notice "Create symlink to correct package manager aliases"
rm -vf $HOME/.config/zsh/.z_pm_aliases
ln -vs $HOME/.config/zsh/.z_${pkg_manager}_aliases $HOME/.config/zsh/.z_pm_aliases
notice "Symlink to package manager aliases created"

# install VimPlug (nvim/vim pluggin manager)
notice "Install VimPlug to $HOME/.config/nvim/plugged"
mkdir -vp $HOME/.config/nvim/plugged
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs\
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

notice "Run PlugInstall, to install defined pluggins to neovim"
nvim +PlugInstall +qa

# add gruvbox for vim as well
notice "Add gruvbox colorscheme to vim colors"
sudo cp -v $HOME/.config/nvim/plugged/gruvbox/colors/gruvbox.vim /usr/share/vim/vim8*/colors

## make guake dropdown terminal autostarting
notice "Make guake dropdown terminal autostarting"
sudo cp -v /usr/share/applications/guake.desktop /etc/xdg/autostart

## load DE settings
$new_shell $HOME/.scripts/load_settings.sh

# Set up root passwd
notice "Set root passwd"
sudo passwd

# set up sudo and doas
notice "Make doas config"
echo "permit ${user} nopass" | sudo tee /usr/local/etc/doas.conf
notice "Update sudo config"
echo "%wheel ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.tmp
sudo cat /etc/sudoers /etc/sudoers.tmp | sudo tee /etc/sudoers
sudo rm -fv /etc/sudoers.tmp
notice "doas and sudo configured"

notice "Copy github_key.pub to clipboard"
xclip -selection clipboard < $HOME/.ssh/github_key.pub
notice "GitHub ssh key is in the clipboard, you have to manually add it to github, to set up ssh for git"

cowsay -f bud-frogs "SETUP DONE!"

