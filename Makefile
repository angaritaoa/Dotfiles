uuid=$(shell gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')

.PHONY: update
update:
	sudo rm -f /etc/yum.repos.d/fedora.repo
	sudo rm -f /etc/yum.repos.d/fedora-updates.repo
	sudo rm -f /etc/yum.repos.d/fedora-modular.repo
	sudo rm -f /etc/yum.repos.d/fedora-updates-modular.repo
	sudo ln -fns $(shell pwd)/fedora/fedora.repo /etc/yum.repos.d/fedora.repo
	sudo ln -fns $(shell pwd)/fedora/fedora-updates.repo /etc/yum.repos.d/fedora-updates.repo
	sudo ln -fns $(shell pwd)/fedora/fedora-modular.repo /etc/yum.repos.d/fedora-modular.repo
	sudo ln -fns $(shell pwd)/fedora/fedora-updates-modular.repo /etc/yum.repos.d/fedora-updates-modular.repo
	sudo dnf update --refresh --assumeyes

.PHONY: fedora
fedora:
	sudo dnf install --assumeyes \
		https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(shell rpm -E %fedora).noarch.rpm \
		https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(shell rpm -E %fedora).noarch.rpm
	sudo dnf update --refresh --assumeyes
	sudo dnf groupupdate core --assumeyes
	sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin --assumeyes
	sudo dnf groupupdate sound-and-video --assumeyes
	sudo dnf install --assumeyes akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-cuda-libs \
		vdpauinfo libva-vdpau-driver libva-utils libva-v4l2-request libvdpau-va-gl mesa-vdpau-drivers vulkan \
		fedora-workstation-repositories opencl-utils mesa-libOpenCL fedora-workstation-repositories curl wget git git-lfs \
		coreutils tree p7zip p7zip-plugins gzip xz bzip2 lzo lz4 lzma gnome-tweaks dconf-editor vim-X11 exa pipewire-v4l2 \
		v4l2loopback gwe xprop xclip
	sudo dnf autoremove --assumeyes zram-generator zram-generator-defaults
	sudo dnf config-manager --set-enabled google-chrome
	sudo systemctl disable NetworkManager-wait-online.service
	sudo ln -fns $(shell pwd)/fedora/xorg.conf /etc/X11/xorg.conf
	sudo grubby --update-kernel=ALL \
		--args="rd.driver.blacklist=nouveau modprobe.blacklist=nouveau nvidia-drm.modeset=1 ipv6.disable=1 intel_iommu=on rhgb quiet"
	sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
	sudo depmod -ae
	sudo reboot

.PHONY: fonts
fonts:
	sudo cp -fR ./assets/fonts/JetBrainsMono        /usr/share/fonts
	sudo cp -fR ./assets/fonts/JetBrainsMonoNerd    /usr/share/fonts
	sudo cp -fR ./assets/fonts/MaterialDesignIcons  /usr/share/fonts
	sudo cp -fR ./assets/fonts/SF-Pro-Display       /usr/share/fonts
	sudo cp -fR ./assets/fonts/Windows              /usr/share/fonts
	sudo fc-cache -r

.PHONY: plasma
plasma:
	sudo dnf install --assumeyes NetworkManager-config-connectivity-fedora breeze-gtk breeze-icon-theme colord-kde dolphin \
		glibc-langpack-en glibc-langpack-es langpacks-core-en langpacks-core-es langpacks-core-font-en langpacks-core-font-es \
		langpacks-en langpacks-es libreoffice-langpack-en libreoffice-langpack-es tesseract-langpack-eng gnome-keyring-pam \
		kcm_systemd kde-gtk-config kde-partitionmanager kde-settings-pulseaudio kde-style-breeze kdeplasma-addons kdialog \
		kdnssd kf5-akonadi-server kf5-akonadi-server-mysql kf5-baloo-file kf5-kipi-plugins khotkeys kmenuedit konsole5 \
		kscreen kscreenlocker ksshaskpass ksysguard kwalletmanager5 kwebkitpart kwin pam-kwallet phonon-qt5-backend-gstreamer \
		pinentry-qt plasma-breeze plasma-desktop plasma-desktop-doc plasma-drkonqi plasma-nm plasma-nm-l2tp \
		plasma-nm-openconnect plasma-nm-openswan plasma-nm-openvpn plasma-nm-pptp plasma-nm-vpnc plasma-pa plasma-workspace \
		plasma-workspace-geolocation polkit-kde qt5-qtbase-gui qt5-qtdeclarative sddm sddm-breeze sddm-kcm sni-qt xorg-x11-drv-libinput \
		setroubleshoot @base-x @Fonts NetworkManager-wifi NetworkManager-wwan kf5-networkmanager-qt dhcp-client dnsmasq iptables-nft \
		wpa_supplicant kde-l10n-es kvantum bismuth kcolorchooser kf5-krunner firefox thunderbird gwenview okular libreoffice-calc \
		libreoffice-core libreoffice-data libreoffice-emailmerge libreoffice-filters libreoffice-graphicfilter libreoffice-gtk3 \
		libreoffice-help-en libreoffice-help-es libreoffice-impress libreoffice-kf5 libreoffice-langpack-en libreoffice-langpack-es \
		libreoffice-ogltrans libreoffice-opensymbol-fonts libreoffice-pdfimport libreoffice-pyuno libreoffice-ure libreoffice-ure-common \
		libreoffice-writer libreoffice-x11 libreoffice-xsltfilter libreoffice-nlpsolver inkscape ark kcalc kcharselect spectacle kwrite \
		obs-studio vlc vlc-core vlc-extras kgpg kget ffmpeg gtk-murrine-engine gtk2-engines bash-completion hunspell-es-CO \
		kffmpegthumbnailer gsettings-qt
	sudo systemctl disable gdm
	sudo systemctl enable sddm
	sudo systemctl set-default graphical.target
	sudo reboot

.PHONY: dotfiles
dotfiles:
	sudo ln -fns $(shell pwd)/local.conf /etc/fonts/local.conf
#	ln -fns $(shell pwd)/config/awesome ~/.config/awesome
#	ln -fns $(shell pwd)/config/picom ~/.config/picom
#	ln -fns $(shell pwd)/config/rofi ~/.config/rofi
#	ln -fns $(shell pwd)/config/flameshot ~/.config/flameshot
	ln -fns $(shell pwd)/config/gtk-3.0 ~/.config/gtk-3.0
	ln -fns $(shell pwd)/config/gtk-2.0/gtkrc-2.0 ~/.gtkrc-2.0
	ln -fns $(shell pwd)/bashrc ~/.bashrc
	ln -fns $(shell pwd)/gitconfig ~/.gitconfig
	ln -fns $(shell pwd)/Xresources ~/.Xresources
	ln -fns $(shell pwd)/../.ssh ~/.ssh

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
	gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
	gsettings set org.gnome.Terminal.Legacy.Settings menu-accelerator-enabled false
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${uuid}/ audible-bell false
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${uuid}/ cursor-blink-mode 'on'
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${uuid}/ cursor-shape 'underline'
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${uuid}/ default-size-columns 132
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${uuid}/ font 'JetBrainsMono Nerd Font 9'
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${uuid}/ foreground-color '#BBC2CF'
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${uuid}/ background-color '#21242B'
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${uuid}/ palette "['#1B2229', '#FF6C6B', '#98BE65', '#DA8548', '#50AFEF', '#C678DD', '#46D9FF', '#5B6268', '#1B2229', '#FF6C6B', '#98BE65', '#DA8548', '#50AFEF', '#C678DD', '#46D9FF', '#5B6268']"
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${uuid}/ scrollback-lines 10000
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${uuid}/ use-system-font false
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${uuid}/ use-theme-colors false
	gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${uuid}/ visible-name 'Personal'

.PHONY: emacs
emacs:
	sudo dnf install -y emacs git ripgrep fd-find ShellCheck tidy sqlite libtool cmake gcc g++ clang make clang-tools-extra \
		nodejs glslang
	rm -rf ~/.emacs.d;
	ln -fns $(shell pwd)/doom.d ~/.doom.d
	git clone https://github.com/doomemacs/doomemacs ~/.emacs.d
	~/.emacs.d/bin/doom install
	~/.emacs.d/bin/doom sync
	~/.emacs.d/bin/doom doctor
