#!/bin/bash

architecture=$(uname -m)

# Check if running with sudo
if [[ $EUID -ne 0 ]]; then
    echo "This script needs sudo privileges to continue."
    exit 1
fi

if [[ "$architecture" == "x86_64" ]]; then
    echo "Detected 64-bit architecture"
    sleep 3
    # Install AWS CLI for 64-bit
    curl "https://awscli.amazonaws.com/awscli-exe-linux-$architecture.zip" -o "/tmp/awscliv2.zip"
    unzip /tmp/awscliv2.zip
    sudo ./tmp/aws/install
    echo "remove aws install dir and zip"
    rm -rf /tmp/aws*
elif [[ "$architecture" == "aarch64" ]]; then
    echo "Detected ARM architecture"
    sleep 3
    # Install AWS CLI for ARM
    curl "https://awscli.amazonaws.com/awscli-exe-linux-$architecture.zip" -o "/tmp/awscliv2.zip"
    unzip /tmp/awscliv2.zip
    sudo ./tmp/aws/install
    echo "remove aws install dir and zip"
    rm -rf /tmp/aws*
else
    echo "Unsupported architecture: $architecture"
    exit 1
fi
