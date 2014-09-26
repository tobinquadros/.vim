# Overview:

My dotfiles got way too bloated to be portable. So this repo stores Vim configs
& plugins managed through Vundle.

# Usage:

## On MacOSX (Homebrew) & Linux (APT/YUM):

```sh
git clone https://github.com/tobinquadros/Vim $HOME/.vim

cd $HOME/.vim

./make_vim.sh
```

## On Windows:

_Git Bash needs to be installed for this to work._

Use Git Bash to start a terminal.

```sh
git clone https://github.com/tobinquadros/Vim $HOME/vimfiles

cd $HOME/vimfiles

./make_vim.sh
```

(If you wish to use the tagbar plugin on Windows you will need to manually
install Exuberant Ctags http://sourceforge.net/projects/ctags )

# Options:

If you don't want plugins installed (or updated):

```sh
./make_vim.sh --no-plugins
```

