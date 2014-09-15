# Overview:

My dotfiles got way too bloated to be portable. This is Vim configs and
plug-ins. Handy if you jump around alot.

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
When prompted if you would like to install plugins type "y".

(If you wish to use the tagbar plug-in you will need Exuberant Ctags http://sourceforge.net/projects/ctags )

# Options:

If you don't want plug-ins installed (or updated):

```sh
./make_vim.sh --no-plugins
```

