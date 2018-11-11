#!/bin/bash

HOME_DIR="/home/vagrant"
WORKING_DIR="/tmp"
BASH_PROFILE=$HOME_DIR/.bash_profile

echo "********** Start provisioning vim **********"

#
echo "+++++ Installing yum packages"

yum install -y gcc-c++ ncurses-devel python-devel vim-enhanced git

cd $WORKING_DIR

#
echo "+++++ Installing vim v8.1.0513"

git clone https://github.com/vim/vim.git

cd vim/src && git checkout v8.1.0513

./configure \
  --disable-nls \
  --enable-cscope \
  --enable-gui=no \
  --enable-multibyte  \
  --enable-pythoninterp \
  --enable-rubyinterp \
  --prefix=/home/vagrant/.local/vim \
  --with-features=huge  \
  --with-python-config-dir=/usr/lib/python2.7/config \
  --with-tlib=ncurses \
  --without-x

make && make install

echo "+++++ Configuring .bash_profile for vim"

if ! grep -q 'vim\/bin' $BASH_PROFILE; then 
    cat <<EOF >> $HOME_DIR/.bash_profile

if [ -d "\$HOME/.local/vim/bin/" ] ; then
   PATH="\$HOME/.local/vim/bin/:\$PATH"
fi

export PATH
EOF
fi

cd $HOME_DIR
rm -rf vim

#
echo "+++++ Installing vim go"

# Don't forget to run :GoInstallBinaries in vi when first time using it
git clone https://github.com/fatih/vim-go.git $HOME_DIR/.vim/pack/plugins/start/vim-go

#
echo "+++++ Configure vimrc"

cat <<EOF > $HOME_DIR/.vimrc
syntax on
filetype plugin indent on

set backspace=indent,eol,start
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set number
set backupcopy=yes
set viminfo+=<1000

autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

let g:go_version_warning = 0
EOF

echo "********** Finished provisioning vim **********"

