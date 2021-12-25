CP_DIR_ROOT		= sudo cp -fR
CP_DIR_USER		= cp -fR
CP_FILE_ROOT	= sudo cp -f
CP_FILE_USER	= cp -f
FONTS_FOLDERS	= fonts/all-the-icons fonts/JetBrainsMono fonts/MesloLGS fonts/Windows

install :
	$(CP_DIR_ROOT) $(FONTS_FOLDERS) /usr/share/fonts/
	$(CP_FILE_ROOT) fonts/local.conf /etc/fonts/
	$(CP_FILE_USER) fonts/Xresources ~/.Xresources
	$(CP_FILE_USER) backgrounds/* ~/.local/share/backgrounds/
	sudo dnf install -y gnome-extensions-app
