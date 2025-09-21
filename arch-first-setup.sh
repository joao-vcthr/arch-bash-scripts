#!/usr/bin/env bash
#
# Arch Linux post install setup script
#
# Stop the script if any command fails
set -e

# Output Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No color

# Set up and sync clock
setup_clock() {
    echo -e "${YELLOW}Setting clock to local time... ${NC}"
    timedatectl set-local-rtc 1 --adjust-system-clock

    echo -e "${YELLOW}Syncing clock... ${NC}"
    systemctl restart systemd-timesyncd.service

    echo -e "${GREEN}Clock adjustments completed! ${NC}"
}

# Configure connection
setup_connection() {
    echo -e "${YELLOW}Configuring connection... ${NC}"

    nmcli connection modify "Wired connection 1" ipv4.dns "1.1.1.1 1.0.0.1"
    nmcli connection modify "Wired connection 1" ipv4.ignore-auto-dns yes
    nmcli connection down "Wired connection 1"
    nmcli connection up "Wired connection 1"

    echo -e "${GREEN}Connection setup completed! ${NC}"
}

# Schedule TRIM
setup_trim() {
    echo -e "${YELLOW}Setting up TRIM... ${NC}"

    fstrim -av
    systemctl enable --now fstrim.timer

    echo -e "${GREEN}TRIM setup completed! ${NC}"
}

main() {
    echo -e "${YELLOW}Running functions... ${NC}"

    setup_clock
    setup_connection
    setup_trim

    # Update system
    echo -e "${YELLOW}Updating System... ${NC}"
    pacman -Syu --noconfirm

    echo -e "${GREEN}Done! Restarting the system! ${NC}"

    systemctl reboot
}

main
