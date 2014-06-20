#!/usr/bin/env bash
# make_vim.sh

# Installs and upgrades Vim, .vim directory, vimrc, and plugin submodules.

# ==============================================================================
# Function Definitions
# ==============================================================================

# For MacOSX with Hombrew available.
function install_thru_brew() {
  # Install Vim
  brew install -y vim
  brew install -y macvim

  # System tools that help with C code.
  # Run :help cscope, or :help Exuberant_ctags in Vim for info.
  brew install -y cscope
  brew install -y ctags-exuberant
}

# For APT managed systems.
function install_thru_apt() {
  # Install Vim
  sudo apt-get install -y vim
  sudo apt-get install -y vim-gnome

  # System tools that help with C code.
  # Run :help cscope, or :help Exuberant_ctags in Vim for info.
  sudo apt-get install -y cscope
  sudo apt-get install -y exuberant-ctags
}

# Copy/overwrite updated Vim directory to ~/.vim for current user's configs.
function copy_dotvim() {
mkdir -p $HOME/.vim
cp -R $DIR/* $HOME/.vim/
}

# ==============================================================================
# Main
# ==============================================================================

# Create bundle directory and add submodules.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir -p $DIR/bundle
git submodule update --init $DIR/bundle/
git submodule add https://github.com/tpope/vim-pathogen.git $DIR/bundle/
git submodule add https://github.com/scrooloose/syntastic.git $DIR/bundle/
git submodule add https://github.com/majutsushi/tagbar.git $DIR/bundle/
git submodule add https://github.com/tpope/vim-commentary.git $DIR/bundle/
git submodule add https://github.com/tpope/vim-markdown.git $DIR/bundle/
git submodule add https://github.com/tpope/vim-repeat.git $DIR/bundle/
git submodule add https://github.com/tpope/vim-surround.git $DIR/bundle/
git submodule add https://github.com/tpope/vim-unimpaired.git $DIR/bundle/

# Pull the submodules down.
git submodule foreach git pull origin master

# Pretty crappy but it works for now.
if [ ! -z $(which apt-get) ]; then
  install_thru_apt
elif [ ! -z $(which brew) ]; then
  install_thru_brew
else
  echo "Your system's package manager may not be supported, or you need to install Homebrew."
fi

# Timed prompt that asks about writing $HOME/.vim directory. 
echo "Would you like to create a $HOME/.vim directory? (y/n) default = Yes"
read -t 10
if [ \( -z "$REPLY" \) -o \( "$REPLY" = "y" -o "$REPLY" = "Y" \) ]; then
  copy_dotvim
else
  echo "Exiting without copying .vim directory."
  exit
fi
