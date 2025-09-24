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
    pacman -S ufw

    echo -e "${YELLOW}Setting up Firewall... ${NC}"
    ufw default deny incoming
    ufw default allow outgoing
    ufw enable

    echo -e "${GREEN}Firewall installed and configured! ${NC}"
}

install_essential_packages() {
    echo -e "${YELLOW}Installing essential packages... ${NC}"

    local essential_packages=(
        "gst-plugins-good"
        "gst-plugins-bad"
        "gst-plugins-ugly"
        "gst-libav"
        "power-profiles-daemon"
    )

    pacman -S --noconfirm --needed "${essential_packages[@]}"

    echo -e "${GREEN}Essential packages installed! ${NC}"
}

install_repositories() {
    #Install Flatpak
    echo -e "${YELLOW}Installing Flapak... ${NC}"

    pacman -S flatpak
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

	echo -e "${GREEN}Flatpak installed and flathub repo added! ${NC}"

    #Install Yay
	echo -e "${YELLOW}Installing Yay... ${NC}"

	pacman -S --needed git base-devel
 	git clone https://aur.archlinux.org/yay.git
 	cd yay
 	makepkg -si

    echo -e "${GREEN}Yay installed! ${NC}"
}

install_compilers() {
    echo -e "${YELLOW}Installing Compilers... ${NC}"

    pacman -S clang jdk-openjdk

    echo -e "${GREEN}Compilers installed! ${NC}"
}

main() {
    echo -e "${YELLOW}Running functions...${NC}"

    install_firewall
    install_essential_packages
    install_compilers

    echo -e "${GREEN}Essential packages installed! Restarting the system ${NC}"
}
