# -*- sh -*-
# vi: set ft=sh :

## Install dependencies
apt-get install -y build-essential autoconf automake libtool \
        xorg-dev libgif-dev libtiff5-dev libjpeg-dev libncurses5-dev \
        libtinfo-dev libxml2-dev libm17n-dev libpng12-dev libdbus-1-dev \
        libcairo2-dev librsvg2-dev libgnutls28-dev libotf-dev gnutls-bin \
        texinfo git-core curl markdown aspell aspell-en ctags

## Compile Emacs
cd ~
mkdir src
cd src
git clone --depth=1 git://git.savannah.gnu.org/emacs.git
cd emacs
sh autogen.sh
./configure --with-cairo
make
make install

## Clean up
cd ~
cd src
cd emacs

make clean
