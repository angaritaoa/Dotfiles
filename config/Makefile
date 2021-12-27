PACKAGES=vim-X11 \
	exa \
	git

install :
	ln -fs ~/develop/dotfiles/config/bash/bashrc ~/.bashrc
	ln -fs ~/develop/dotfiles/config/git/gitconfig ~/.gitconfig
	[ -d ~/.config/terminator ] || mkdir -p ~/.config/terminator
	ln -fs ~/develop/dotfiles/config/terminator/config ~/.config/terminator/config
	sudo dnf install -y $(PACKAGES)
