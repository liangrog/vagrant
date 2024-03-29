#!/bin/bash

HOME_DIR="/home/vagrant"
WORKING_DIR="/tmp"
BASH_PROFILE=$HOME_DIR/.bash_profile
USER="vagrant"

install_vim () {
	echo "+++++ Installing vim v8.2.3346"

	rm -rf vim

	git clone https://github.com/vim/vim.git

	cd vim/src && git checkout v8.2.3346
	
	sudo -u $USER mkdir $HOME_DIR/.local

	./configure \
	  --disable-nls \
	  --enable-cscope \
	  --enable-gui=no \
	  --enable-multibyte  \
	  --enable-pythoninterp \
	  --enable-rubyinterp \
	  --prefix=$HOME_DIR/.local/vim \
	  --with-features=huge  \
	  --with-python-config-dir=/usr/lib/python2.7/config \
	  --with-tlib=ncurses \
	  --without-x

	make && make install

	echo "+++++ Configuring .bash_profile for vim"

	if ! grep -q 'vim\/bin' $BASH_PROFILE; then 
	    sudo -u $USER cat <<EOF >> $HOME_DIR/.bash_profile

if [ -d "\$HOME/.local/vim/bin/" ] ; then
   PATH="\$HOME/.local/vim/bin/:\$PATH"
fi

export PATH
EOF
	fi

	cd $HOME_DIR
	rm -rf vim

	echo "+++++ Configure vimrc"

	sudo -u $USER cat <<EOF > $HOME_DIR/.vimrc
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

EOF
}

install_vim_go () {
	echo "+++++ Installing vim go"

	# Don't forget to run :GoInstallBinaries in vi when first time using it
	sudo -u $USER git clone https://github.com/fatih/vim-go.git $HOME_DIR/.vim/pack/plugins/start/vim-go

	echo "+++++ Configure vimrc"

	sudo -u $USER cat <<EOF >> $HOME_DIR/.vimrc

let g:go_version_warning = 0
EOF
}

echo "********** Start provisioning vim **********"

#
echo "+++++ Installing yum packages"

yum install -y gcc-c++ ncurses-devel python-devel vim-enhanced git

cd $WORKING_DIR


VIM_VERSION=$(sudo -i -u vagrant vim --version | grep 'VIM' | cut -f 5 -d " " | sed -n '1p')

# Install vim 8.2
if [ "$VIM_VERSION" == "8.2" ]; then
	echo "vim 8.2 exists, skip installation"
else
	install_vim	
fi

# Install vim go
if [ -d $HOME_DIR/.vim/pack/plugins/start/vim-go ]; then
	echo "vim-go exists, skip installation"
else
	install_vim_go
fi

echo "********** Finished provisioning vim **********"

