#!/usr/bin/env bash
# make_vim.sh

# Installs and upgrades Vim, vimrc, .vim directory, and submodule plugins.

# ==============================================================================
# Function Definitions
# ==============================================================================

# For MacOSX with Hombrew available.
function do_vim_macosx() {
  # Install Vim
  brew install -y vim
  brew install -y gvim

  # System tools that help with C code.
  # Run :help cscope, or :help Exuberant_ctags in Vim for info.
  brew install -y cscope
  brew install -y ctags-exuberant
}

# For Ubuntu.
function do_vim_ubuntu() {
  # Install Vim
  sudo apt-get install -y vim
  sudo apt-get install -y vim-gnome

  # System tools that help with C code.
  # Run :help cscope, or :help Exuberant_ctags in Vim for info.
  sudo apt-get install -y cscope
  sudo apt-get install -y exuberant-ctags
}

# ==============================================================================
# Main
# ==============================================================================

# Pretty crappy system check but it works for this.
if [ ! -z $(which apt-get) ]; then
  echo do_vim_ubuntu
elif [ ! -z $(which brew) ]; then
  echo do_vim_macosx
else
  echo "Your system may not be supported, or you need to install Homebrew."
  exit 1
fi

# Create $HOME/.vim/bundle directory and add submodules.
mkdir -p $HOME/.vim/bundle
cd bundle
git submodule update --init
git submodule add https://github.com/tpope/vim-pathogen.git
git submodule add https://github.com/scrooloose/syntastic.git
git submodule add https://github.com/majutsushi/tagbar.git
git submodule add https://github.com/tpope/vim-commentary.git
git submodule add https://github.com/tpope/vim-markdown.git
git submodule add https://github.com/tpope/vim-repeat.git
git submodule add https://github.com/tpope/vim-surround.git
git submodule add https://github.com/tpope/vim-unimpaired.git

# Pull the submodules down.
git submodule foreach git pull origin master

