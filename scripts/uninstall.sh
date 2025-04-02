#!/bin/bash

# uninstall.sh
# This script uninstalls Linux-Defender and cleans up the environment.

echo "Uninstalling Linux-Defender..."

# Remove directories and files
sudo rm -rf /var/log/linux-defender /var/quarantine /etc/linux-defender

# Detect the package manager
PACKAGE_MANAGER=$(detect_package_manager)

# Function to uninstall dependencies using the detected package manager
uninstall_dependencies() {
    case $PACKAGE_MANAGER in
        apt)
            sudo apt remove --purge -y python3 python3-pip build-essential git
            ;;
        pacman)
            sudo pacman -Rns --noconfirm python python-pip base-devel git
            ;;
        yum)
            sudo yum remove -y python3 python3-pip gcc gcc-c++ make git
            ;;
        dnf)
            sudo dnf remove -y python3 python3-pip gcc gcc-c++ make git
            ;;
        zypper)
            sudo zypper remove -y python3 python3-pip gcc gcc-c++ make git
            ;;
        *)
            echo "Unsupported package manager. Please remove the dependencies manually."
            exit 1
            ;;
    esac
}

# Uninstall dependencies
echo "Uninstalling dependencies..."
uninstall_dependencies

# Cleanup
sudo apt autoremove -y
sudo apt clean

# Uninstallation complete
echo "Uninstallation complete. Linux-Defender has been removed."
