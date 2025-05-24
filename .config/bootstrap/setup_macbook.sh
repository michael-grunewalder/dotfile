#!/bin/bash

# Check if Homebrew is already installed
if ! command -v brew &> /dev/null
then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="/opt/homebrew/bin:$PATH"
else
    echo "Homebrew is already installed."
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update

# List of packages to install
packages=(
"--cask ghostty"
    "--cask font-hack-nerd-font"
    "--cask sf-symbols"
    "--cask font-meslo-lg-nerd-font"
    "--cask sublime-text"
    "--cask font-sf-mono"
    "--cask visual-studio-code"
    "--cask font-sf-pro"
    "--cask warp"
    "--cask font-sketchybar-app-font"
    "--cask appcleaner"
    "--cask herd"
    "--cask opera-air"
    "--cask arc"
    "--cask google-chrome"
    "--cask firefox"
    "--cask dbngin"
    "--cask textmate"
    "screenresolution"
    "eza"
    "sketchybar"
    "fzf"
    "mas"
    "starship"
    "midnight-commander"
    "switchaudio-osx"
    "tmux"
    "jesseduffield/lazygit/lazygit"
    "neofetch"
    "nowplaying-cli"
    "yadm"
	"ffmpeg"
	"sevenzip"
	"jq"
	"poppler"
	"fd"
	"ripgrep"
	"fzf"
	"zoxide"
	"resvg"
	"imagemagick"
	"yazi"
	"font-symbols-only-nerd-font"
    "--no-quarantine grishka/grishka/neardrop"
)

# Install packages
echo "Installing packages..."
for package in "${packages[@]}"
do
    echo "Installing $package..."
    brew install $package
done
echo "Upgrading packages..."
brew upgrade
echo "Installation of Homebrew Apps complete!"
echo "***************************************************DONE************************************"


echo "Installing Apple AppStore Applications"
echo "SnailGit Lite"
mas install 1099475282
echo "Transmit 5"
mas install 1436522307
echo "Bitwarden"
mas install 1352778147
echo "Core Tunnel"
mas install 1354318707
echo "Important Apps installed"
echo "***************************************************DONE************************************"

echo "Getting configuration from YADM"
#rm -rf ~/.zshrc
#yadm clone git@github.com:michael-grunewalder/dotfile.git
yadm clone https://github.com/michael-grunewalder/dotfile.git
yadm status
yadm checkout -f
