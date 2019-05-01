# -*- sh -*-
# vi: set ft=sh :

## Install dependencies
apt-get install -y build-essential automake autoconf libtool libgnome2-dev \
        libgnomeui-dev libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev \
        libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev \
        libxt-dev python-dev ruby-dev git-core cscope curl clang ctags cmake

## Compile Vim
cd ~
cd src
git clone --depth=1 https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope
make
make install

## Clean up
cd ~
cd src
cd vim

make clean
