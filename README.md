# Overview:

My dotfiles got too bloated to be portable, this is a fairly lightweight config
& plugin installer for Vim on various operating systems. It uses Vundle for
plugins, and a bash script to install, that's about it.

## On MacOSX, Ubuntu, CentOS:

```bash
git clone https://github.com/tobinquadros/.vim ~/.vim

cd ~/.vim

./make_vim.sh
```

## On Windows:

**Note:** This still requires a bash shell like Git Bash or Cygwin.

```bash
git clone https://github.com/tobinquadros/.vim $HOME/vimfiles

cd $HOME/vimfiles

./make_vim.sh
```

If you wish to use the tagbar plugin on Windows you will need to manually
install Exuberant Ctags http://sourceforge.net/projects/ctags.

+ Download exuberant Ctags from http://sourceforge.net/projects/ctags/files/ctags/
+ Extract the Ctags zip file and move to C:\Program Files\Ctags5.8
+ Add C:\Program Files\Ctags5.8\ to your path.

# Options:

If you don't want any plugins installed (or updated):

```bash
./make_vim.sh --no-plugins
```
