#!/bin/bash

# Check system architecture with uname
architecture=$(uname -m)

if [[ "$architecture" == "x86_64" ]]; then
    echo "Detected 64-bit architecture"
    # Install AWS CLI for 64-bit
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
    unzip /tmp/awscliv2.zip
    sudo ./tmp/aws/install
    echo "remove aws install dir and zip"
    rm -rf /tmp/aws*
elif [[ "$architecture" == "aarch64" ]]; then
    echo "Detected ARM architecture"
    # Install AWS CLI for ARM
    curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "/tmp/awscliv2.zip"
    unzip /tmp/awscliv2.zip
    sudo ./tmp/aws/install
    rm -rf /tmp/aws*
else
    echo "Unsupported architecture: $architecture"
    exit 1
fi