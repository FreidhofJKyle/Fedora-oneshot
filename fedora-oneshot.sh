#!/usr/bin/env bash 

# Enable rpm fusion 
# rpm fusion for non free software 
nofree="https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-39.noarch.rpm"
# rpm fusion for free software 
free="https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-39.noarch.rpm"

# Enable Flathub
hub="https://dl.flathub.org/repo/flathub.flatpakrepo"
# Add docker repo
docrepo="https://download.docker.com/linux/fedora/docker-ce.repo"

# Add openh264
openh="fedora-cisco-openh264"


# pkgs to install 
# if these fonts dont exist install them 
font=("jetbrains-mono-fonts-all" "terminus-font" "terminus-fonts-console" "neofetch")
# Neccessary pkgs 
ne=("neovim" "nitrogen" "xorg-x11-xinit.x86_64" "libXinerama-devel" "libXft-devel" "libX11-devel" 
        "gcc" "make" "gzip" "tar" "mozilla-openh264" "gstreamer1-plugin-openh264")
# media formats to install  
me=("lame\* --exclude=lame-devel" "gstreamer1-plugins-{bad-\*,good-\*,base}" "gstreamer1-plugin-openh264" "gstreamer1-plugin-libav" "--exclude=gstreamer1-plugins-bad-free-devel")

pkgs=("vlc" "mpv" "docker-ce " "docker-ce-cli" "containerd.io" "docker-buildx-plugin" "docker-compose-plugin" "discord" "pavucontrol.x86_64")

paks=("com.spotify.Client" "com.obsproject.Studio")

# pkgs to remove 
# if in gnome remove all of these packages 
r=("gnome-disk-utility-45.1-1.fc39.x86_64" "gnome-clocks-45.0-1.fc39.x86_64" "gnome-calculator-45.0.2-1.fc39.x86_64" "gnome-calendar-45.1-1.fc39.x86_64" "nautilus" "gnome-system-monitor-45.0.2-1.fc39.x86_64" "gnome-connections-45.0-1.fc39.x86_64" "totem" "yelp" "gnome-tour" "gnome-boxes" "rhythmbox-3.4.7-2.fc39.x86_64" "gnome-maps-45.0-1.fc39.x86_64" "gnome-contacts-45.0-1.fc39.x86_64" "cheese"
        "gnome-software-45.0-1.fc39.x86_64" "libreoffice-calc" "libreoffice-core" "libreoffice-impress" 
        "libreoffice-writter" "docker" "docker-client" "docker-client-latest" "docker-common" "docker-latest" "docker-latest-logrotate" "docker-logrotate" "docker-selinux" "docker-engine-selinux" "docker-engine")

remove_pkgs() {
	dnf remove -y ${r[@]}


}

enable_repos() {

dnf check-update
dnf install -y "$nonfree" "$free"
flatpak remote-add --if-not-exists "$hub"
dnf config-manager --add-repo "$dockerrepo"
wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/0ee08df0cf4527e40edc9aa28f4b5bd38bbff2b2/code-1.85.1-170246224:

dnf install -y code-1.85.1-1702462241.el7.x86_64.rpm 

dnf config-manager --set-enabled
dnf check-update 


}

pkgs_install () {
        dnf install -y "${font[@]}" "${ne[@]}" "${me[@]}" "${pkgs[@]}"

        flatpak install flathub "${paks[@]}"


}

 if [ -e /etc/os-release ]; then
         ID=$(grep -oP 'ID=\K[^\s]*'/etc/os-release)

         elif [ "$ID" == fedora ]; then

                 enable_repos 
		 pkgs_install
		 remove_pkgs


else
       	echo "Error: either the packages dont exist or your not using fedora."


fi

