#!/bin/bash
# install.sh

set -e  # Exit on any error

echo "==> Starting system setup..."

#
# Install Xcode Command Line Tools if not already installed
#
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

#
# Install Homebrew if not already installed
#
if ! command -v brew &> /dev/null; then
    echo "==> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH (for Apple Silicon)
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "==> Homebrew already installed"
fi

#
# Install chezmoi
#
if ! command -v chezmoi &> /dev/null; then
    echo "==> Installing chezmoi..."
    brew install chezmoi
else
    echo "==> chezmoi already installed"
fi

#
# Install 1password
#
brew install --cask 1password
brew install --cask 1password-cli

echo ""
echo "==> MANUAL STEP REQUIRED:"
echo "    1. Open 1Password and sign in"
echo "    2. Go to Settings → Developer"
echo "    3. Enable 'Connect with 1Password CLI'"
echo "    4. Run: eval \$(op signin)"
echo ""
echo "Press Enter when complete..."
read -r

#
# Apply dotfiles with chezmoi
#
echo "==> Applying dotfiles..."
chezmoi init --apply https://github.com/rhyselsmore/dotfiles.git

