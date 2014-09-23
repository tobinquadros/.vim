#!/usr/bin/env bash
# make_vim.sh

# Installs and upgrades Vim, .vim directory, vimrc, and plugin submodules.
#
# Exuberant CTags:
#   System tool that indexes code for 41 different languages.
#   To recursively index current directory use <leader>ct
#   To index the system libraries use <leader>sct
#   Run :help Exuberant_ctags in Vim for info.

# ==============================================================================
# Function Definitions
# ==============================================================================

# For MacOSX with Hombrew available.
function install_thru_brew() {
  # Install Vim
  brew install vim
  # If caskroom/homebrew-cask is available install thru cask, else brew only.
  brew cask install macvim || brew install macvim
  # Install ctags
  brew install ctags-exuberant
}

# For APT managed systems.
function install_thru_apt() {
  # Install Vim
  sudo apt-get install -y vim
  # If X windowing is available install GUI Vim.
  if [ ! -z $(which X) ]; then
    sudo apt-get install -y vim-gnome
  fi
  # Install ctags
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
  # Install ctags
  sudo yum install -y ctags
}

function handle_plugins() {
  # Create bundle directory and add submodules, requires pathogen.
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  mkdir -p $DIR/bundle
  git submodule update --init $DIR/bundle
  # Pathogen is required!!!
  git submodule add https://github.com/tpope/vim-pathogen.git $DIR/bundle/vim-pathogen
  # Personalize pathogen compatible Vim plugins here.
  git submodule add https://github.com/saltstack/salt-vim.git $DIR/bundle/salt-vim
  git submodule add https://github.com/scrooloose/syntastic.git $DIR/bundle/syntastic
  git submodule add https://github.com/majutsushi/tagbar.git $DIR/bundle/tagbar # Tagbar depends on ctags.
  git submodule add https://github.com/tpope/vim-commentary.git $DIR/bundle/vim-commentary
  git submodule add https://github.com/tpope/vim-fugitive.git $DIR/bundle/vim-fugitive
  git submodule add https://github.com/tpope/vim-markdown.git $DIR/bundle/vim-markdown
  git submodule add https://github.com/tpope/vim-repeat.git $DIR/bundle/vim-repeat
  git submodule add https://github.com/tpope/vim-surround.git $DIR/bundle/vim-surround
  git submodule add https://github.com/tpope/vim-unimpaired.git $DIR/bundle/vim-unimpaired
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

# Check if plug-ins should be ignored.
# Used single equal (=) sign is for posix compliance.
if [ "$1" = "--no-plugins" ]; then
  HANDLE_PLUGINS=0
else
  HANDLE_PLUGINS=1
fi

# If set, update or install plug-in submodules.
if [ $HANDLE_PLUGINS -eq 1 ]; then
  handle_plugins
else
  echo "Skipping plug-in submodule installation."
fi

# Clean up any mess and say goodbye.
clean_up

