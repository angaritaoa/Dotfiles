PWD=$(shell pwd)

.PHONY: update
update:
	sudo rm -f /etc/yum.repos.d/fedora-updates-modular.repo
	sudo rm -f /etc/yum.repos.d/fedora.repo
	sudo rm -f /etc/yum.repos.d/fedora-updates.repo
	sudo rm -f /etc/yum.repos.d/fedora-modular.repo
	sudo ln -fns ${PWD}/fedora/fedora-updates-modular.repo /etc/yum.repos.d/fedora-updates-modular.repo
	sudo ln -fns ${PWD}/fedora/fedora.repo /etc/yum.repos.d/fedora.repo
	sudo ln -fns ${PWD}/fedora/fedora-updates.repo /etc/yum.repos.d/fedora-updates.repo
	sudo ln -fns ${PWD}/fedora/fedora-modular.repo /etc/yum.repos.d/fedora-modular.repo
	sudo dnf update --refresh --assumeyes

.PHONY: fedora
fedora:
	sudo dnf install --assumeyes \
		https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(shell rpm -E %fedora).noarch.rpm \
		https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(shell rpm -E %fedora).noarch.rpm
	sudo dnf update --refresh --assumeyes
	sudo dnf groupupdate core --assumeyes
	sudo dnf groupupdate sound-and-video --assumeyes
	sudo dnf install --assumeyes akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-cuda-libs \
		vdpauinfo libva-vdpau-driver libva-utils libva-v4l2-request libvdpau-va-gl mesa-vdpau-drivers vulkan \
		fedora-workstation-repositories opencl-utils mesa-libOpenCL curl wget git git-lfs coreutils tree p7zip \
		p7zip-pluginsgzip xz bzip2 lzo lz4 lzma vim-X11 exa pipewire-v4l2 v4l2loopback gwe xprop xclip
	sudo dnf autoremove --assumeyes zram-generator zram-generator-defaults
	sudo dnf config-manager --set-enabled google-chrome
	sudo cp -f ${PWD}/10-xorg.conf /etc/X11/xorg.conf.d
	sudo cp -f ${PWD}/environment /etc
	sudo grubby --update-kernel=ALL --args="rd.driver.blacklist=nouveau"
	sudo grubby --update-kernel=ALL --args="modprobe.blacklist=nouveau"
	sudo grubby --update-kernel=ALL --args="nvidia-drm.modeset=1"
	sudo grubby --update-kernel=ALL --args="ipv6.disable=1"
	sudo grubby --update-kernel=ALL --args="intel_iommu=on"
	sudo grubby --update-kernel=ALL --args="rhgb quiet"
	sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
	sudo depmod -ae
	sudo reboot

.PHONY: fonts
fonts:
	sudo cp -fR ./assets/fonts/JetBrainsMono /usr/share/fonts
	sudo cp -fR ./assets/fonts/JetBrainsMonoNerd /usr/share/fonts
	sudo cp -fR ./assets/fonts/MaterialDesignIcons /usr/share/fonts
	sudo cp -fR ./assets/fonts/SF-Pro-Display /usr/share/fonts
	sudo cp -fR ./assets/fonts/Windows /usr/share/fonts
	sudo fc-cache -r

.PHONY: plasma
plasma:
	sudo dnf install libreoffice-langpack-es sddm-breeze kde-l10n-es kvantum bismuth kcolorchooser firefox thunderbird \
		gwenview okular libreoffice-calc libreoffice-core libreoffice-data libreoffice-emailmerge libreoffice-filters \
		libreoffice-graphicfilter libreoffice-gtk3 libreoffice-help-en libreoffice-help-es libreoffice-impress \
		libreoffice-kf5 libreoffice-langpack-en libreoffice-langpack-es libreoffice-ogltrans libreoffice-opensymbol-fonts \
		libreoffice-pdfimport libreoffice-pyuno libreoffice-ure libreoffice-ure-common libreoffice-writer libreoffice-x11 \
		libreoffice-xsltfilter libreoffice-nlpsolver inkscape kcharselect vlc vlc-core vlc-extras bash-completion \
		hunspell-es-CO kernel-tools ddcutil
	sudo dnf group install --with-optional @virtualization
	sudo systemctl disable NetworkManager-wait-online.service
	sudo systemctl enable cpupower
	sudo systemctl enable libvirtd
	sudo cpupower frequency-set -g performance

.PHONY: awesome
awesome:
	mkdir -p ~/.config
	ln -fns ${PWD}/config/awesome ~/.config/awesome
	ln -fns ${PWD}/config/picom ~/.config/picom
	ln -fns ${PWD}/config/rofi ~/.config/rofi

.PHONY: dotfiles
dotfiles:
	mkdir -p ~/.config
	sudo ln -fns ${PWD}/local.conf /etc/fonts/local.conf
	sudo ln -fns ${PWD}/Xresources /etc/X11/Xresources
	ln -fns ${PWD}/config/gtk-3.0 ~/.config/gtk-3.0
	ln -fns ${PWD}/config/gtk-2.0/gtkrc-2.0 ~/.gtkrc-2.0
	ln -fns ${PWD}/config/flameshot ~/.config/flameshot
	ln -fns ${PWD}/bashrc ~/.bashrc
	ln -fns ${PWD}/gitconfig ~/.gitconfig
	ln -fns ${PWD}/../.ssh ~/.ssh

.PHONY: themes
themes:
	cd ~/
	git clone git@github.com:vinceliuice/Layan-kde.git
	git clone git@github.com:vinceliuice/Layan-gtk-theme.git
	git clone git@github.com:vinceliuice/Tela-icon-theme.git
	Layan-kde/install.sh
	Layan-gtk-theme/install.sh
	Tela-icon-theme/install.sh
	rm -rf Layan-kde Layan-gtk-theme Tela-icon-theme

.PHONY: emacs
emacs:
	sudo dnf install -y emacs git ripgrep fd-find ShellCheck tidy sqlite libtool cmake gcc g++ clang make clang-tools-extra \
		nodejs glslang
	rm -rf ~/.emacs.d;
	ln -fns ${PWD}/doom.d ~/.doom.d
	git clone https://github.com/doomemacs/doomemacs ~/.emacs.d
	~/.emacs.d/bin/doom install
	~/.emacs.d/bin/doom sync
	~/.emacs.d/bin/doom doctor

.PHONY: gnome
gnome:
	gsettings set org.gnome.desktop.interface clock-format '12h'
	gsettings set org.gnome.desktop.interface cursor-blink true
	gsettings set org.gnome.desktop.interface document-font-name 'Segoe UI Regular 10'
	gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
	gsettings set org.gnome.desktop.interface font-hinting 'full'
	gsettings set org.gnome.desktop.interface font-name 'Segoe UI Regular 10'
	gsettings set org.gnome.desktop.interface font-rgba-order 'rgb'
	gsettings set org.gnome.desktop.interface gtk-theme 'Layan-Dark-Solid'
	gsettings set org.gnome.desktop.interface cursor-theme 'Breeze_Snow'
	gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font Regular 9'
	gsettings set org.gnome.desktop.interface text-scaling-factor 1.25
	gsettings set org.gnome.desktop.interface toolkit-accessibility false
	gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Segoe UI Regular 10'
	gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:close'
	gsettings set org.gnome.desktop.interface enable-animations false
	gsettings set org.gnome.desktop.interface clock-show-date true
	gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
	gsettings set org.gnome.desktop.peripherals.mouse speed 0.0
	gsettings set org.gnome.desktop.interface gtk-enable-primary-paste true
	gsettings set org.gnome.desktop.wm.preferences num-workspaces 4
	gsettings set org.gnome.mutter center-new-windows true
	gsettings set org.gnome.mutter dynamic-workspaces false
	gsettings set org.gnome.software download-updates false
	gsettings set org.gnome.software allow-updates false
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
