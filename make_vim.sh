#!/usr/bin/env bash
# make_vim.sh

# Installs and upgrades Vim, .vim directory, vimrc, and plugin submodules.

# Exuberant CTags:
#   System tool that indexes code for 40+ different languages.
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
  # Install ctags
  brew install ctags
}

# For APT managed systems.
function install_thru_apt() {
  # Install Vim
  sudo apt-get install -y vim
  # Install ctags
  sudo apt-get install -y exuberant-ctags
}

# For yum managed systems.
function install_thru_yum() {
  # Install Vim
  sudo yum install -y vim
  # Install ctags
  sudo yum install -y ctags
}

# Get and install plugins with Vundle.
function handle_plugins() {
  # Create .vim/bundle/ directory, even if sourced from elsewhere.
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  mkdir -p $DIR/bundle

  # Clone or pull down updates for Vundle.vim plugin.
  if [ -d "$DIR/bundle/Vundle.vim" ]; then
    cd $DIR/bundle/Vundle.vim/
    (git pull origin master && (cd - > /dev/null)) || (echo "Vundle update failed."; exit 1)
  else
    git clone https://github.com/gmarik/Vundle.vim.git $DIR/bundle/Vundle.vim
  fi

  # Run the Vundle plugin update and install function.
  vim '+PluginInstall!' +qall
}

# ==============================================================================
# Main
# ==============================================================================

# Pretty crappy but it works for now.
if [ -x $(which brew) ]; then
  install_thru_brew
elif [ -x $(which apt-get) ]; then
  install_thru_apt
elif [ -x $(which yum) ]; then
  install_thru_yum
elif [ $(uname) = "MINGW32"* ]; then
  echo "You seem to be running Windows, please see the README.md"; echo ""
else
  echo "Your system's package manager may not be supported, or you need to install Homebrew."
fi

# Check if plugins should be ignored.
if [ "$1" = "--no-plugins" ]; then
  echo "Skipping Vundle plugin installations and updates."
else
  handle_plugins
fi

