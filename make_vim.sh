#!/usr/bin/env bash

# Installs and upgrades Vim and plugins

# ==============================================================================
# Function Definitions
# ==============================================================================

# Download and install plugins with Vundle.
function handle_plugins() {
  echo "Running handle_plugins()..."

  # Create .vim/bundle/ directory, even if sourced from elsewhere.
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  mkdir -p $DIR/bundle

  # Clone or pull down updates for Vundle.vim plugin.
  if [[ -d "$DIR/bundle/Vundle.vim" ]]; then
    echo "Updating Vundle..."
    cd $DIR/bundle/Vundle.vim/
    (git pull origin master && (cd - > /dev/null)) || (echo "Vundle update failed."; exit 1)
  else
    git clone https://github.com/gmarik/Vundle.vim.git $DIR/bundle/Vundle.vim
  fi

  # Run the Vundle plugin clean, update, and install
  vim '+PluginClean!' +qall
  vim '+PluginInstall!' +qall
}

# For MacOSX with Hombrew available.
function install_thru_brew() {
  brew update
  brew install vim || brew upgrade --cleanup vim
  brew install ctags || brew upgrade --cleanup ctags

  brew install neovim || brew upgrade --cleanup neovim
  mkdir -p ~/.config/nvim
  cp -R -f $HOME/.vim/ $HOME/.config/nvim
  cp -f vimrc $HOME/.config/nvim/init.vim
  pip install --upgrade neovim
  gem install neovim
}

# Additional binaries are required for some plugins, unfortunately
function update_binaries() {
  echo "Running update_binaries()..."

  # Update the Vim-go binaries (requires vim-go plugin)
  if [[ -n $GOPATH ]]; then
    vim '+GoUpdateBinaries' +qall
  fi

  # Setup for YouCompleteMe (requires YCM plugin)
  brew install cmake || brew upgrade --cleanup cmake
  cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer
  cd -
}

# ==============================================================================
# Main
# ==============================================================================

install_thru_brew

# Check if plugins should be ignored.
if [[ "$@" =~ "--no-plugins" ]]; then
  echo "Skipping Vundle plugin installations and updates."
else
  handle_plugins
fi

# Check if binaries should be installed/updated.
if [[ "$@" =~ "--no-binaries" ]]; then
  echo "Skipping binary plugin installs/updates."
else
  update_binaries
fi

