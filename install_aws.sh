#!/bin/bash

architecture=$(uname -m)

# Check if running with sudo
if [[ $EUID -ne 0 ]]; then
    echo "This script needs sudo privileges to continue."
    exit 1
fi

# Check package eg curl,unzip is installed or no
check_install() {
    for package in "$@"; do
        if ! command -v "$package" &>/dev/null; then
            echo "$package is not installed. Attempting to install..."
            if [[ -x "$(command -v apt-get)" ]]; then
                apt-get update
                apt-get install -y "$package"
            elif [[ -x "$(command -v yum)" ]]; then
                yum install -y "$package"
            # Tambahkan package manager tambahan di sini dengan perintah instalasi yang sesuai
            else
                echo "Package manager not found. Please install $package manually."
                exit 1
            fi
        else
            echo "$package is installed."
        fi
    done
}

check_install "curl" "unzip"

sleep 2

# Install AWS CLI +
if [[ "$architecture" == "x86_64" ]]; then
    echo "Detected 64-bit architecture"
    sleep 3
    # Install AWS CLI for 64-bit
    curl "https://awscli.amazonaws.com/awscli-exe-linux-$architecture.zip" -o "/tmp/awscliv2.zip"
    unzip /tmp/awscliv2.zip -d /tmp
    sudo /tmp/aws/install
    echo "remove aws install dir and zip"
    rm -rf /tmp/aws*
elif [[ "$architecture" == "aarch64" ]]; then
    echo "Detected ARM architecture"
    sleep 3
    # Install AWS CLI for ARM
    curl "https://awscli.amazonaws.com/awscli-exe-linux-$architecture.zip" -o "/tmp/awscliv2.zip"
    unzip /tmp/awscliv2.zip -d /tmp
    sudo /tmp/aws/install
    echo "remove aws install dir and zip"
    rm -rf /tmp/aws*
else
    echo "Unsupported architecture: $architecture"
    exit 1
fi
