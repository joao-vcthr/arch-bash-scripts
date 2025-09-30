#!/usr/bin/env bash
#
# Script for installing essential packages in Arch Linux
#
# Stop the script if any command fails
set -e

# Output Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No color

install_firewall() {
    echo -e "${YELLOW}Installing Firewall... ${NC}"
    sudo pacman -S ufw

    echo -e "${YELLOW}Setting up Firewall... ${NC}"

    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw enable

    echo -e "${GREEN}Firewall installed and configured! ${NC}"
}

install_essential_packages() {
    local essential_packages=(
        "gst-plugins-good"
        "gst-plugins-bad"
        "gst-plugins-ugly"
        "gst-libav"
        "power-profiles-daemon"
    )

    echo -e "${YELLOW}Installing essential packages... ${NC}"

    sudo pacman -S --noconfirm --needed "${essential_packages[@]}"

    echo -e "${GREEN}Essential packages installed! ${NC}"
}

install_repositories() {
    # Install Flatpak
    echo -e "${YELLOW}Installing Flapak... ${NC}"

    sudo pacman -S --noconfirm --needed flatpak
	sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

	echo -e "${GREEN}Flatpak installed and flathub repo added! ${NC}"

    # Install Yay
	echo -e "${YELLOW}Installing Yay... ${NC}"


	sudo pacman -S --noconfirm --needed git base-devel
    cd "$HOME"

 	git clone https://aur.archlinux.org/yay.git
 	cd yay
 	makepkg -si --noconfirm

    cd ..
    rm -rf yay

    echo -e "${GREEN}Yay installed! ${NC}"
}

install_compilers() {
    echo -e "${YELLOW}Installing Compilers... ${NC}"

    sudo pacman -S --noconfirm --needed clang jdk-openjdk

    echo -e "${GREEN}Compilers installed! ${NC}"
}

install_fonts() {
    local fonts=(
        "noto-fonts"
        "ttf-liberation"
        "ttf-dejavu"
        "noto-fonts-emoji"
        "ttf-fira-code"
        "ttf-jetbrains-mono"
        "noto-fonts-cjk"
    )

    echo -e "${YELLOW}Installing Fonts... ${NC}"

    pacman -S --noconfirm --needed "${fonts[@]}"

    echo -e "${GREEN}Fonts installed! ${NC}"
}

main() {
    echo -e "${YELLOW}Running functions...${NC}"

    install_firewall
    install_essential_packages
    install_compilers
    install_fonts

    echo -e "${GREEN}Essential packages installed! Restart the system ${NC}"
}


main
