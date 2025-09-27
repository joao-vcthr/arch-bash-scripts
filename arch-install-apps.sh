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
        "obs-studio"
        "flameshot"
        "gimp"
        "shotcut"
        "audacity"
        "vlc"
        "btop"
        "fastfetch"
        "corectrl"
        "libreoffice-fresh"
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
    )

    echo -e "${YELLOW}Installing flatpak packages...${NC}"
    flatpak install -y flathub "${flatpak_packages[@]}"

    echo -e "${GREEN}Flatpak packages installed! ${NC}"
}

update_icons_cache() {
    gtk-update-icon-cache -f /usr/share/icons/hicolor
    gtk-update-icon-cache -f /usr/share/icons/Adwaita
    update-desktop-database -q
}

main() {
    echo -e "${YELLOW}Running functions... ${NC}"

    install_pacman_packages
    install_flatpak_packages
    update_icons_cache

    #Install Brave Browser
    yay -Sy --needed --noconfirm brave-bin

    echo -e "${GREEN}Apps are installed!${NC}"
}

main
