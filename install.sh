#! /bin/sh
#
# vim, goのインストールを行います。
#
# Usage:
# 	~/.dotfiles/install.sh

# 0以外の終了ステータスが出た瞬間にスクリプトを止める。

IFS='
 	'

set -e

# Install Section

# sudo権限でなければ実行できない
if [ ${EUID:-${UID}} = 0 ]; then
    apt update
    apt -y upgrade
    # Golang {{{
    echo "install golang"
    apt -y install golang-go
    # }}}
    # ruby {{{
    echo "install rbenv and ruby"
    # }}}
    # Java {{{
    echo "install java"
    apt -y install default-jre
    # }}}

    # For Latest Vim {{{
    apt -y install libxmu-dev libgtk3.0-dev libxpm-dev build-essential install python3-dev ruby-dev
else
    echo 'Not root user'
fi

# Symbolic Link
if [ ! -e ~/.vim ]; then
    ln -sf ~/.dotfiles/vimfiles ~/.vim
fi

build_vim() {
    # Build Vim {{{
    if [ ! -e ~/vim ]; then
        mkdir ~/vim
    fi
    if [ ! -e ~/vim/vim ]; then
        # ~/vim/vimが存在しなければgit cloneする。
        git clone https://github.com/vim/vim.git ~/vim/vim
    else
        cd ~/vim/vim/
        git pull
    fi
    # Build Process Start
    cd ~/vim/vim/src
    make distclean
    ./configure \
        --enable-multibyte --enable-multibyte --enable-fontset \
        --enable-gui=yes --enable-gui=gtk2 \
        --enable-perlinter=yes \
        --enable-rubyinterp=yes \
        --enable-luainterp=yes \
        --with-luajit \
        --enable-python3interp=yes \
        --prefix=/usr/local \
        --with-features=huge \

    make

    if [ ! -e ~/vim/vim ]; then
        make install
    fi

    vim +":PlugInstall" + ":q" + ":q"
    # }}}

    echo "source ~/.dotfiles/.bash_setting" >> ~/.bashrc
}
