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

# Additional binaries are required for some plugins, unfortunately
function update_binaries() {
  echo "Running update_binaries()..."

  # Setup for YouCompleteMe (requires YCM plugin)
  cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer
  cd -
}

# ==============================================================================
# Main
# ==============================================================================

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

