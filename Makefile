.PHONY: update
update:
	sudo rm -f /etc/yum.repos.d/fedora.repo
	sudo rm -f /etc/yum.repos.d/fedora-updates.repo
	sudo rm -f /etc/yum.repos.d/fedora-modular.repo
	sudo rm -f /etc/yum.repos.d/fedora-updates-modular.repo
	sudo ln -s $(shell pwd)/fedora/fedora.repo /etc/yum.repos.d/fedora.repo
	sudo ln -s $(shell pwd)/fedora/fedora-updates.repo /etc/yum.repos.d/fedora-updates.repo
	sudo ln -s $(shell pwd)/fedora/fedora-modular.repo /etc/yum.repos.d/fedora-modular.repo
	sudo ln -s $(shell pwd)/fedora/fedora-updates-modular.repo /etc/yum.repos.d/fedora-updates-modular.repo
	sudo dnf update --refresh --assumeyes
	sudo reboot

.PHONY: fedora
fedora:
	sudo dnf install --assumeyes \
		https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(shell rpm -E %fedora).noarch.rpm \
		https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(shell rpm -E %fedora).noarch.rpm
	sudo dnf update --refresh --assumeyes
	sudo dnf groupupdate core --assumeyes
	sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin --assumeyes
	sudo dnf groupupdate sound-and-video --assumeyes
	sudo dnf install --assumeyes akmod-nvidia xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-cuda-libs vdpauinfo \
		libva-vdpau-driver libva-utils libva-v4l2-request libvdpau-va-gl mesa-vdpau-drivers vulkan \
		fedora-workstation-repositories
	sudo dnf autoremove --assumeyes zram-generator zram-generator-defaults
	sudo dnf config-manager --set-enabled google-chrome
	sudo dnf install --assumeyes curl wget git git-lfs coreutils tree p7zip p7zip-plugins gzip xz bzip2 lzo lz4 \
		lzma drawing google-chrome-stable gnome-extensions-app gnome-tweaks dconf-editor gedit vim-X11 exa \
		terminator papirus-icon-theme meld sysprof stow
	sudo systemctl disable NetworkManager-wait-online.service
	sudo ln -fs $(shell pwd)/fedora/xorg.conf /etc/X11/xorg.conf
	sudo grubby --update-kernel=ALL \
		--args="rd.driver.blacklist=nouveau modprobe.blacklist=nouveau nvidia-drm.modeset=1 ipv6.disable=1 intel_iommu=on rhgb quiet"
	sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
	sudo reboot

.PHONY: gnome
gnome:
	mkdir -p ~/.local/share/backgrounds
	sudo cp -fR ./gnome/fonts/JetBrainsMono ./gnome/fonts/Windows /usr/share/fonts
	sudo cp -f ./gnome/fonts/local.conf /etc/fonts
	cp -f ./gnome/backgrounds/* ~/.local/share/backgrounds
	sudo fc-cache -f
	gsettings set org.gnome.desktop.interface clock-format '12h'
	gsettings set org.gnome.desktop.interface cursor-blink true
	gsettings set org.gnome.desktop.interface document-font-name 'Segoe UI 10'
	gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
	gsettings set org.gnome.desktop.interface font-hinting 'full'
	gsettings set org.gnome.desktop.interface font-name 'Segoe UI 10'
	gsettings set org.gnome.desktop.interface font-rgba-order 'rgb'
	gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
	gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
	gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
	gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 9'
	gsettings set org.gnome.desktop.interface text-scaling-factor 1.25
	gsettings set org.gnome.desktop.interface toolkit-accessibility false
	gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Segoe UI 10'
	gsettings set org.gnome.software download-updates false
	gsettings set org.gnome.software allow-updates false
	gsettings set org.gnome.desktop.interface clock-show-date true
	gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
	gsettings set org.gnome.desktop.peripherals.mouse speed 0.0
	gsettings set org.gnome.desktop.interface gtk-enable-primary-paste true
	gsettings set org.gnome.mutter center-new-windows true
	gsettings set org.gnome.mutter dynamic-workspaces false
	gsettings set org.gnome.desktop.wm.preferences num-workspaces 4
	gsettings set org.gnome.gedit.preferences.editor display-right-margin true
	gsettings set org.gnome.gedit.preferences.editor highlight-current-line false
	gsettings set org.gnome.gedit.preferences.editor insert-spaces true
	gsettings set org.gnome.gedit.preferences.editor scheme 'tango'
	gsettings set org.gnome.gedit.preferences.editor tabs-size 4
	gsettings set org.gnome.gedit.preferences.editor wrap-last-split-mode 'word'
	gsettings set org.gnome.gedit.preferences.editor wrap-mode 'none'
	gsettings set org.gnome.nautilus.preferences default-folder-viewer 'icon-view'
	gsettings set org.gnome.nautilus.preferences show-delete-permanently true
	gsettings set org.gtk.Settings.FileChooser sort-directories-first true

.PHONY: dotfiles
dotfiles:
	[ -d ~/.config/terminator ] || mkdir -p ~/.config/terminator
	ln -fs $(shell pwd)/bashrc ~/.bashrc
	ln -fs $(shell pwd)/gitconfig ~/.gitconfig
	ln -fs $(shell pwd)/config/terminator/config ~/.config/terminator/config
	ln -fs $(shell pwd)/Xresources ~/.Xresources
	cp -fR /mnt/archivos/.ssh ~/

.PHONY: emacs
emacs:
	sudo dnf install -y emacs git ripgrep fd-find ShellCheck
	rm -rf ~/.emacs.d;
	ln -fns $(shell pwd)/doom.d ~/.doom.d
	git clone https://github.com/doomemacs/doomemacs ~/.emacs.d
	~/.emacs.d/bin/doom install
