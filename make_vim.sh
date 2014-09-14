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
  # System tool that indexes code for 41 different languages.
  # To recursively index current directory use <leader>ct
  # To index the system libraries use <leader>sct
  # Run :help Exuberant_ctags in Vim for info.
  brew install -y ctags-exuberant
}

# For APT managed systems.
function install_thru_apt() {
  # Install Vim
  sudo apt-get install -y vim
  # If X windowing is available install GUI Vim.
  if [ ! -z $(which X) ]; then
    sudo apt-get install -y vim-gnome
  fi
  # System tool that indexes code for 41 different languages.
  # To recursively index current directory use <leader>ct
  # To index the system libraries use <leader>sct
  # Run :help Exuberant_ctags in Vim for info.
  sudo apt-get install -y exuberant-ctags
}

# For yum managed systems.
function install_thru_yum() {
  # Install Vim
  sudo yum install -y vim
  # If X windowing is available install GUI Vim.
  if [ ! -z $(which X) ]; then
    sudo yum install -y gvim
  fi
  # System tool that indexes code for 41 different languages.
  # To recursively index current directory use <leader>ct
  # To index the system libraries use <leader>sct
  # Run :help Exuberant_ctags in Vim for info.
  sudo yum install -y ctags
}

function add_submodules() {
  # Create bundle directory and add submodules, requires pathogen.
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  rm -rf $DIR/bundle
  mkdir -p $DIR/bundle
  git submodule update --init $DIR/bundle/
  # Pathogen is required!!!
  git submodule add https://github.com/tpope/vim-pathogen.git $DIR/bundle/
  # Personalize pathogen compatible Vim plugins here.
  git submodule add https://github.com/saltstack/salt-vim.git $DIR/bundle/
  git submodule add https://github.com/scrooloose/syntastic.git $DIR/bundle/
  git submodule add https://github.com/majutsushi/tagbar.git $DIR/bundle/ # Tagbar depends on ctags.
  git submodule add https://github.com/tpope/vim-commentary.git $DIR/bundle/
  git submodule add https://github.com/tpope/vim-fugitive.git $DIR/bundle/
  git submodule add https://github.com/tpope/vim-markdown.git $DIR/bundle/
  git submodule add https://github.com/tpope/vim-repeat.git $DIR/bundle/
  git submodule add https://github.com/tpope/vim-surround.git $DIR/bundle/
  git submodule add https://github.com/tpope/vim-unimpaired.git $DIR/bundle/
  # Pull the submodules down.
  git submodule foreach git pull origin master
}

function clean_up() {
  echo "Install complete. Don't forget to run :helptags in Vim."
}

# ==============================================================================
# Main
# ==============================================================================

# Pretty crappy but it works for now.
if [ ! -z $(which apt-get) ]; then
  install_thru_apt
elif [ ! -z $(which brew) ]; then
  install_thru_brew
elif [ ! -z $(which yum) ]; then
  install_thru_yum
elif [ $(uname) = "MINGW32_NT-6.1" ]; then
  echo "Download exuberant Ctags http://sourceforge.net/projects/ctags/files/ctags/"
  echo
  echo "Extract the Ctags zip file and move to C:\Program Files\CtagsX.Y"
  echo
  echo "Add C:\Program Files\CtagsX.Y\ to your path."
  echo
else
  echo "Your system's package manager may not be supported, or you need to install Homebrew."
fi

# Timed prompt that asks about installing plug-in submodules. This won't work
# if this file is sourced from outside the .vim folder.
echo "Would you like to install your plug-ins? (y/n) default = N"
read -t 10
if [ ! \( "$REPLY" = "y" -o "$REPLY" = "Y" \) ]; then
  echo "Skipping plug-in submodule installation."
else
  add_submodules
fi

# Clean up any mess and say goodbye.
clean_up
