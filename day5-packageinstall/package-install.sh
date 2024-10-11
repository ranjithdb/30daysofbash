#!/bin/bash

PACKAGES="curl git"

install_apt() {
    echo "Detected Ubuntu/Debian-based system."
    sudo apt update
    for package in $PACKAGES; do
        sudo apt install -y $package
    done
    echo "Packages installed successfully using apt."
}

install_yum() {
    echo "Detected RedHat/CentOS-based system."
    sudo yum update -y
    for package in $PACKAGES; do
        sudo yum install -y $package
    done
    echo "Packages installed successfully using yum."
}

install_dnf() {
    echo "Detected Fedora-based system."
    sudo dnf update -y
    for package in $PACKAGES; do
        sudo dnf install -y $package
    done
    echo "Packages installed successfully using dnf."
}

install_pacman() {
    echo "Detected Arch-based system."
    sudo pacman -Syu
    for package in $PACKAGES; do
        sudo pacman -S --noconfirm $package
    done
    echo "Packages installed successfully using pacman."
}

install_zypper() {
    echo "Detected openSUSE-based system."
    sudo zypper refresh
    for package in $PACKAGES; do
        sudo zypper install -y $package
    done
    echo "Packages installed successfully using zypper."
}

install_emerge() {
    echo "Detected Gentoo-based system."
    for package in $PACKAGES; do
        sudo emerge --ask $package
    done
    echo "Packages installed successfully using emerge."
}

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    case "$OS" in
        ubuntu|debian|linuxmint|pop|kali|tails)
            install_apt
            ;;
        centos|rhel)
            install_yum
            ;;
        fedora)
            install_dnf
            ;;
        arch|manjaro)
            install_pacman
            ;;
        *)
            echo "Unsupported or unknown distribution: $OS"
            ;;
    esac
else
    echo "Cannot detect the operating system."
    exit 1
fi

