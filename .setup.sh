#!/bin/sh

# README: setup my (ubuntu) system, after git pull or downloading the repo.

# should exit script, when it fails
set -e

notice()
{
  echo "\n--------------------------------------"
  echo $1
}

# set update, install, package manager etc variables
sleeping=2
case "$1" in
  ubuntu)
    updateCmd="sudo apt update; sudo apt upgrade"
    installCmd="apt install"
    pkg_manager="apt"
    extraCmds=""
    dryRun="--dry-run"
    echo "Setup for Ubuntu(/Debian) will start in ${sleeping}sec (Ctrl+c to cancel)"
    ;;
  # solus)
  #   updateCmd="sudo eopkg upgrade -y"
  #   installCmd="eopkg install -y"
  #   pkg_manager="eopkg"
  #   extraCmds="sudo eopkg install -c system.devel" # https://getsol.us/articles/package-management/basics/en/#base-development-tools
  #   dryRun="--dry-run"
  #   echo "Setup for Solus will start in ${sleeping}sec (Ctrl+c to cancel)"
  #   ;;
  *)
    echo "Selected distro is not supported"
    echo "run again as: ./.setup.sh ubuntu"
    exit
    ;;
esac

# Give user ${sleeping}sec to cancel setup
sleep ${sleeping}

# get user name
user=$(who)
user=${user%% *}

# Download packages (set for ubuntu atm).
packages="xterm zsh zsh-syntax-highlighting neovim vim firefox fzf wget curl keepassxc htop fd-find ripgrep zathura-pdf-poppler xclip dconf-cli gnome-tweak-tool zip unzip vlc doas exa" # guake
additionalPkgs="gnome-boxes transmission redshift tmux eog gnome-mpv texlive pandoc" # libxtst-devel libpng-devel
forFun="cowsay"

# gnome-boxes = VM
# transmission = torrent
# eog - eye of gnome (image viewer)
# dconf-cli to load gnome settings
# wmctrl to list window processes
# libxtst-devel libpng-devel -- for some R packages
# gnome-tweak-tool -- extra tweaks in gnome DE
# programmingPkg= vscode  # rstudio 
# comms = discord

# ecosystem = google -- testing


if [ ! -z "$installCmd" ]
then
  notice "Update package manager"
  eval $updateCmd
  eval $extraCmds
  notice "Dry run package installation"
	$installCmd $dryRun $packages $forFun #$programmingPkg #$additionalPkgs 
	notice "Installing packages: $packages $forFun" # $programmingPkg #$additionalPkgs
	sudo $installCmd $packages $forFun #$programmingPkg #$additionalPkgs 
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
new_shell="zsh"
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

# add gruvbox and solarized for vim (and nvim) as well
notice "Add gruvbox colorscheme to vim colors"
sudo cp -v $HOME/.config/nvim/plugged/gruvbox/colors/gruvbox.vim /usr/share/vim/vim8*/colors
sudo cp -v $HOME/.config/solarized.vim /usr/share/vim/vim8*/colors
sudo cp -v $HOME/.config/solarized.vim /usr/share/nvim/runtime/colors

## make guake dropdown terminal autostarting
#notice "Make guake dropdown terminal autostarting"
#sudo cp -v /usr/share/applications/guake.desktop /etc/xdg/autostart

## load DE settings
notice "Load DE settings"
$new_shell $HOME/.scripts/load_settings.sh
notice "DE settings loaded"

# Set up root passwd
notice "Set root password"
sudo passwd
notice "Root password changed"

# set up sudo and doas
notice "Make doas config (both in /etc and /user/local/etc)"
echo "permit nopass ${user}" | sudo tee /usr/local/etc/doas.conf
echo "permit nopass ${user}" | sudo tee /etc/doas.conf
notice "doas configured"
notice "Update sudo config"
# make backup of the original file
sudo cat /etc/sudoers | sudo tee /etc/sudoers.bu
# make working copy for sudoers file
sudo cat /etc/sudoers | sudo tee /etc/sudoers.copy
# remove %sudo line from the sudoers file, when it exists
sudo sed '/\%sudo/d;' /etc/sudoers | sudo tee /etc/sudoers.copy
# make temp file containing no pass lines 
echo "# COMMENT: nopass added by moledoc setup script
%wheel ALL=(ALL) NOPASSWD: ALL
%sudo ALL=(ALL) NOPASSWD: ALL" > /tmp/sudoNoPass
# compose sudoers file with nopass option for wheel and sudo
sudo cat /etc/sudoers.copy /tmp/sudoNoPass | sudo tee /etc/sudoers
# clean /tmp dir
rm /tmp/sudoNoPass
# sudo rm -fv /etc/sudoers.tmp
notice "sudo configured"

# set up Yaru
notice "Add Yaru themes, icons and sounds to the system"
unzip $HOME/.config/appearance.zip -d $HOME/.config/
sudo cp -rv $HOME/.config/appearance/* /usr/share/
rm -r $HOME/.config/appearance
notice "Yaru added"

# Set up default wallpaper
sudo cp -v $HOME/.config/wallpaper.jpg /usr/share/backgrounds


notice "Copy github_key.pub to clipboard"
xclip -selection clipboard < $HOME/.ssh/github_key.pub

notice "Opening firefox for chrome, vscode, discord install;
github to add ssh key;
bazecor for DygmaRaise software;
appimage launcher for integrated appimage launching
(install .deb files, so those can be installed automatically afterwards)"
firefox "chrome.com"
firefox "https://code.visualstudio.com/"
firefox "https://discord.com/"

notice "GitHub ssh key is in the clipboard, you have to manually add it to github, to set up ssh for git"
firefox "github.com/login"

notice "Select wanted install .deb"
firefox "https://github.com/TheAssassin/AppImageLauncher/releases"

notice "Install bazecor .appimage and open it with AppImageLauncher later"
firefox "https://dygma.com/pages/bazecor"

# install the .deb files we just downloaded
echo "Press enter, when all wanted .deb files are downloaded to $HOME/Downloads/ directory." 
for filename in $HOME/Downloads/*.deb
do
  sudo dpkg -i ${filename}
done

# install digidoc
notice "Downloading and installing digidoc"
curl https://installer.id.ee/media/install-scripts/install-open-eid.sh > "$HOME"/Downloads/install-open-eid.sh
chmod +x "$HOME"/Downloads/install-open-eid.sh
sh "$HOME"/Downloads/install-open-eid.sh

cowsay -f bud-frogs "SETUP DONE!
Logging out in 5sec"

# Log user out
sleep 5
gnome-session-quit --force
