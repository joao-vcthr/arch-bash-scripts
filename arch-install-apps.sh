#!/usr/bin/env bash
#
# Script for installing apps in Arch Linux
#
# Stop the script if any command fails
set -e

# Output Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No color

install_pacman_packages() {
    local pacman_packages=(
        "firefox"
        "chromium"
        "gimp"
        "vlc"
        "btop"
        "fastfetch"
        "corectrl"
    )

    echo -e "${YELLOW}Installing pacman packages...${NC}"
    pacman -S --noconfirm --needed "${pacman_packages[@]}"

    echo -e "${GREEN}Pacman packages installed!${NC}"
}

install_flatpak_packages() {
    local flatpak_packages=(
        "org.telegram.desktop"
        "com.github.flxzt.rnote"
        "md.obsidian.Obsidian"
        "org.shotcut.Shotcut"
        "com.obsproject.Studio"
        "org.libreoffice.LibreOffice"
    )

    echo -e "${YELLOW}Installing flatpak packages...${NC}"
    flatpak install -y flathub "${flatpak_packages[@]}"

    echo -e "${GREEN}Flatpak packages installed! ${NC}"
}

main() {
    echo -e "${YELLOW}Running functions... ${NC}"

    install_pacman_packages
    install_flatpak_packages

    #Install Brave Browser
    yay -Sy --needed --noconfirm brave-bin

    echo -e "${GREEN}Apps are installed!${NC}"
}
