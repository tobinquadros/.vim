# Overview:

My dotfiles got too bloated to be portable, this is a fairly light-weight
config & plugin installer for Vim on various operating systems. It uses Vundle
for plugins, and a bash script to install, that's about it.

## On MacOSX, Ubuntu, CentOS:

```bash
git clone https://github.com/tobinquadros/.vim ~/.vim

cd ~/.vim

./make_vim.sh
```

## On Windows:

**Note:** Installing Git can be done manually or through a package manager like
[chocolately](https://chocolatey.org/). This script still requires a bash
shell, you can run this inside of Git Bash.

```bash
git clone https://github.com/tobinquadros/.vim $HOME/vimfiles

cd $HOME/vimfiles

./make_vim.sh
```

If you wish to use the tagbar plugin on Windows you will need to install
[Exuberant Ctags](http://ctags.sourceforge.net/) To manually install
Exuberant Ctags:

+ Download Exuberant Ctags binary from http://sourceforge.net/projects/ctags/files/ctags/
+ Extract Ctags from the zip file and move to C:\Program Files\Ctags5.8
+ Add C:\Program Files\Ctags5.8\ to your path.

# Options:

If you don't want any plugins installed (or updated):

```bash
./make_vim.sh --no-plugins
```
