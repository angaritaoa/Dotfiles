UUID=$(shell gsettings get com.gexperts.Tilix.ProfilesList default | tr -d \')
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
	sudo dnf group install --with-optional @virtualization
	sudo dnf config-manager --set-enabled google-chrome
	sudo dnf install --assumeyes akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-cuda-libs \
		vdpauinfo libva-vdpau-driver libva-utils libva-v4l2-request libvdpau-va-gl mesa-vdpau-drivers vulkan \
		fedora-workstation-repositories opencl-utils mesa-libOpenCL curl wget git git-lfs coreutils tree p7zip \
		p7zip-pluginsgzip xz bzip2 lzo lz4 lzma vim-X11 exa pipewire-v4l2 v4l2loopback gwe xprop xclip gnome-tweaks \
		dconf-editor libreoffice-langpack-es libreoffice-core libreoffice-data libreoffice-emailmerge libreoffice-filters \
		libreoffice-graphicfilter libreoffice-help-es libreoffice-impress libreoffice-ogltrans libreoffice-opensymbol-fonts \
		libreoffice-pdfimport libreoffice-pyuno libreoffice-ure libreoffice-ure-common libreoffice-xsltfilter \
		libreoffice-nlpsolver inkscape vlc vlc-core vlc-extras bash-completion hunspell-es-CO kernel-tools gedit \
		google-chrome-stable tilix meld sysprof flameshot piper
	sudo dnf autoremove --assumeyes zram-generator zram-generator-defaults
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
	sudo systemctl disable NetworkManager-wait-online.service
	sudo systemctl enable cpupower
	sudo systemctl enable libvirtd
	sudo cpupower frequency-set -g performance
	sudo reboot

.PHONY: fonts
fonts:
	sudo cp -fR ./assets/fonts/JetBrainsMono /usr/share/fonts
	sudo cp -fR ./assets/fonts/JetBrainsMonoNerd /usr/share/fonts
	sudo cp -fR ./assets/fonts/Windows /usr/share/fonts
	sudo fc-cache -r

.PHONY: gnome
gnome:
	gsettings set org.gnome.desktop.interface clock-format '12h'
	gsettings set org.gnome.desktop.interface cursor-blink true
	gsettings set org.gnome.desktop.interface document-font-name 'Segoe UI Regular 10'
	gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
	gsettings set org.gnome.desktop.interface font-hinting 'full'
	gsettings set org.gnome.desktop.interface font-name 'Segoe UI Regular 10'
	gsettings set org.gnome.desktop.interface font-rgba-order 'rgb'
	gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
	gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
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
	gsettings set com.gexperts.Tilix.Settings app-title 'Terminal'
	gsettings set com.gexperts.Tilix.Settings control-scroll-zoom true
	gsettings set com.gexperts.Tilix.Settings enable-wide-handle false
	gsettings set com.gexperts.Tilix.Settings quake-specific-monitor 0
	gsettings set com.gexperts.Tilix.Settings terminal-title-show-when-single true
	gsettings set com.gexperts.Tilix.Settings terminal-title-style 'none'
	gsettings set com.gexperts.Tilix.Settings use-overlay-scrollbar false
	gsettings set com.gexperts.Tilix.Settings window-save-state true
	gsettings set com.gexperts.Tilix.Settings window-style 'disable-csd-hide-toolbar'
	gsettings set com.gexperts.Tilix.Profile:/com/gexperts/Tilix/profiles/${UUID}/ background-color '#212124242B2B'
	gsettings set com.gexperts.Tilix.Profile:/com/gexperts/Tilix/profiles/${UUID}/ bold-is-bright false
	gsettings set com.gexperts.Tilix.Profile:/com/gexperts/Tilix/profiles/${UUID}/ cursor-blink-mode 'on'
	gsettings set com.gexperts.Tilix.Profile:/com/gexperts/Tilix/profiles/${UUID}/ cursor-shape 'underline'
	gsettings set com.gexperts.Tilix.Profile:/com/gexperts/Tilix/profiles/${UUID}/ default-size-columns 140
	gsettings set com.gexperts.Tilix.Profile:/com/gexperts/Tilix/profiles/${UUID}/ default-size-rows 26
	gsettings set com.gexperts.Tilix.Profile:/com/gexperts/Tilix/profiles/${UUID}/ foreground-color '#BBBBC2C2CFCF'
	gsettings set com.gexperts.Tilix.Profile:/com/gexperts/Tilix/profiles/${UUID}/ palette "['#1B1B22222929', '#FFFF6C6C6B6B', '#9898BEBE6565', '#DADA85854848', '#5050AFAFEFEF', '#C6C67878DDDD', '#4646D9D9FFFF', '#5B5B62626868', '#1B1B22222929', '#FFFF6C6C6B6B', '#9898BEBE6565', '#DADA85854848', '#5050AFAFEFEF', '#C6C67878DDDD', '#4646D9D9FFFF', '#5B5B62626868']"
	gsettings set com.gexperts.Tilix.Profile:/com/gexperts/Tilix/profiles/${UUID}/ scrollback-lines 10000
	gsettings set com.gexperts.Tilix.Profile:/com/gexperts/Tilix/profiles/${UUID}/ terminal-bell 'none'
	gsettings set com.gexperts.Tilix.Profile:/com/gexperts/Tilix/profiles/${UUID}/ use-theme-colors false
	gsettings set com.gexperts.Tilix.Profile:/com/gexperts/Tilix/profiles/${UUID}/ visible-name 'Personal'

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
	ln -fns ${PWD}/config/flameshot ~/.config/flameshot
	ln -fns ${PWD}/bashrc ~/.bashrc
	ln -fns ${PWD}/gitconfig ~/.gitconfig
	ln -fns ${PWD}/../.ssh ~/.ssh

.PHONY: themes
themes:
	cd ~/
	git clone git@github.com:vinceliuice/Tela-icon-theme.git
	Tela-icon-theme/install.sh
	rm -rf Tela-icon-theme

.PHONY: emacs
emacs:
	sudo dnf install -y emacs git ripgrep fd-find ShellCheck tidy sqlite libtool cmake gcc g++ clang make \
	clang-tools-extra nodejs glslang
	rm -rf ~/.emacs.d;
	ln -fns ${PWD}/doom.d ~/.doom.d
	git clone https://github.com/doomemacs/doomemacs ~/.emacs.d
	~/.emacs.d/bin/doom install
	~/.emacs.d/bin/doom sync
	~/.emacs.d/bin/doom doctor
