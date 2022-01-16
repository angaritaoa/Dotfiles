install:
	sudo cp -f fedora.repo fedora-updates.repo fedora-modular.repo fedora-updates-modular.repo /etc/yum.repos.d
	sudo cp -f xorg.conf /etc/X11/
	sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
	sudo dnf update --refresh
	sudo dnf groupupdate core
	sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
	sudo dnf groupupdate sound-and-video
	sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-cuda-libs vdpauinfo libva-vdpau-driver libva-utils
	sudo dnf install vulkan fedora-workstation-repositories
	sudo dnf config-manager --set-enabled google-chrome
	sudo dnf autoremove zram-generator zram-generator-defaults
	sudo systemctl disable NetworkManager-wait-online.service
	sudo dnf install curl wget git git-lfs coreutils tree p7zip p7zip-plugins gzip xz bzip2 lzo lz4 lzma google-chrome-stable code piper
	sudo grubby --update-kernel=ALL --args="rd.driver.blacklist=nouveau modprobe.blacklist=nouveau nvidia-drm.modeset=1 ipv6.disable=1 intel_iommu=on rhgb quiet"
	sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
