#!/bin/bash

# installation.sh
# This script installs the necessary dependencies and configures the environment for Linux-Defender.

echo "Starting installation of Linux-Defender..."

# Function to detect the package manager
detect_package_manager() {
    if command -v apt > /dev/null; then
        echo "apt"
    elif command -v pacman > /dev/null; then
        echo "pacman"
    elif command -v yum > /dev/null; then
        echo "yum"
    elif command -v dnf > /dev/null; then
        echo "dnf"
    elif command -v zypper > /dev/null; then
        echo "zypper"
    else
        echo "unknown"
    fi
}

# Detect the package manager
PACKAGE_MANAGER=$(detect_package_manager)

# Function to install dependencies using the detected package manager
install_dependencies() {
    case $PACKAGE_MANAGER in
        apt)
            sudo apt update
            sudo apt install -y python3 python3-pip build-essential git
            ;;
        pacman)
            sudo pacman -Syu --noconfirm
            sudo pacman -S --noconfirm python python-pip base-devel git
            ;;
        yum)
            sudo yum update -y
            sudo yum install -y python3 python3-pip gcc gcc-c++ make git
            ;;
        dnf)
            sudo dnf update -y
            sudo dnf install -y python3 python3-pip gcc gcc-c++ make git
            ;;
        zypper)
            sudo zypper refresh
            sudo zypper install -y python3 python3-pip gcc gcc-c++ make git
            ;;
        *)
            echo "Unsupported package manager. Please install the dependencies manually."
            exit 1
            ;;
    esac
}

# Install dependencies
echo "Installing dependencies..."
install_dependencies

# Install Python dependencies
echo "Installing Python dependencies..."
pip3 install -r requirements.txt

# Create necessary directories
echo "Creating necessary directories..."
mkdir -p /var/log/linux-defender /var/quarantine

# Set permissions
echo "Setting permissions..."
sudo chown -R $USER:$USER /var/log/linux-defender /var/quarantine
sudo chmod -R 750 /var/log/linux-defender /var/quarantine

# Copy configuration files
echo "Copying configuration files..."
cp config/* /etc/linux-defender/

# Setup complete
echo "Installation complete. You can now run Linux-Defender."
