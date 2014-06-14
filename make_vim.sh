#!/usr/bin/env bash
# make_vim.sh

# Installs and upgrades Vim, vimrc, .vim directory, and submodule plugins.

# Install Vim
sudo apt-get install -y vim
sudo apt-get install -y vim-gnome

# System tools that help with C code.
# Run :help cscope, or :help Exuberant_ctags in Vim for info.
sudo apt-get install -y cscope
sudo apt-get install -y exuberant-ctags

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

