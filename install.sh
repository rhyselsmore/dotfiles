#!/bin/bash
# install.sh

set -e  # Exit on any error

echo "==> Starting system setup..."

# Install Xcode Command Line Tools if not already installed
if ! xcode-select -p &> /dev/null; then
    echo "==> Installing Xcode Command Line Tools..."
    xcode-select --install
    
    echo "==> Waiting for Xcode Command Line Tools installation..."
    echo "    Click 'Install' in the popup and wait for completion"
    until xcode-select -p &> /dev/null; do
        sleep 5
    done
    echo "==> Xcode Command Line Tools installed"
else
    echo "==> Xcode Command Line Tools already installed"
fi
