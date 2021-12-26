PACKAGES=vim-X11 \
	exa \
	git

install :
	cp -f bash/bashrc ~/.bashrc
	cp -f git/gitconfig ~/.gitconfig
	[ -d ~/.config/terminator ] || mkdir -p ~/.config/terminator
	cp -f terminator/config ~/.config/terminator/config
	sudo dnf install -y $(PACKAGES)
