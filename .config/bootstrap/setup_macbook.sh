#!/bin/bash
set -e  # Exit on error

echo "Getting configuration from YADM"
if [ -z "$GITHUB_TOKEN" ]; then
    echo "ERROR: GITHUB_TOKEN is not set. Please set it before running this script."
    exit 1
fi

# Install XCode CMD Tools and wait for completion
echo "Installing commandline tools..."
xcode-select --install 2>/dev/null || true
echo "Waiting for Xcode Command Line Tools to complete installation..."
until xcode-select -p &>/dev/null; do
  sleep 5
done
echo "Xcode Command Line Tools installation complete."

# Check if Homebrew is already installed
if ! command -v brew &> /dev/null
then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Handle different architectures (Apple Silicon vs Intel)
    if [[ $(uname -m) == 'arm64' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        export PATH="/opt/homebrew/bin:$PATH"
    else
        eval "$(/usr/local/bin/brew shellenv)"
        export PATH="/usr/local/bin:$PATH"
    fi
else
    echo "Homebrew is already installed."
    # Ensure brew is in PATH regardless
    if [[ $(uname -m) == 'arm64' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

# Installing YADM to get the configurations
echo "Installing YADM..."
brew install yadm || { echo "Failed to install YADM"; exit 1; }

# Clone dotfiles repository

# Clone the dotfiles repository
yadm clone "https://${GITHUB_TOKEN}@github.com/michael-grunewalder/dotfile.git" || { echo "Failed to clone dotfiles"; exit 1; }
yadm status
yadm checkout -f

# Source configuration if it exists
if [ -f ~/.config/zsh/env.zsh ]; then
    echo "Sourcing environment configuration..."
    source ~/.config/zsh/env.zsh
else
    echo "Warning: ~/.config/zsh/env.zsh not found, skipping."
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update

# Installing apps from Homebrew
echo "Installing Homebrew packages..."
BREW_PACKAGES=(
    "atuin"
    "bat"
    "eza"
    "fd"
    "ffmpeg"
    "font-symbols-only-nerd-font"
    "fzf"
    "imagemagick"
    "jesseduffield/lazygit/lazygit"
    "jq"
    "lua"
    "mas"
    "midnight-commander"
    "neofetch"
    "nowplaying-cli"
    "onedrive"
    "poppler"
    "resvg"
    "ripgrep"
    "screenresolution"
    "sevenzip"
    "starship"
    "switchaudio-osx"
    "thefuck"
    "tmux"
    "yazi"
    "zoxide"
    "zsh-autosuggestions"
    "zsh-completions"
    "zsh-syntax-highlighting"
)
for package in "${BREW_PACKAGES[@]}"; do
    echo "Installing $package..."
    brew install "$package" || echo "Failed to install $package, continuing..."
done

# Installing casks
echo "Installing cask applications..."
BREW_CASKS=(
#    "wezterm"
    "font-hack-nerd-font"
    "sf-symbols"
    "font-meslo-lg-nerd-font"
    "sublime-text"
    "font-sf-mono"
    "visual-studio-code"
    "font-sf-pro"
    "warp"
#    "font-sketchybar-app-font"
    "appcleaner"
    "herd"
    "opera-air"
    "arc"
    "google-chrome"
    "firefox"
    "dbngin"
    "textmate"
    "setapp"
    "phpstorm"
    "tinkerwell"
    "ray"
    "windsurf"
    "postman"
    "slack"
    "upscayl"
)

for cask in "${BREW_CASKS[@]}"; do
    echo "Installing $cask..."
    brew install --cask "$cask" || echo "Failed to install $cask, continuing..."
done

echo "Installation of Homebrew Apps complete!"
echo "****DONE****"

# Check if user is logged into Mac App Store
echo "Checking Mac App Store login..."
if ! mas account &>/dev/null; then
    echo "Please log in to the Mac App Store before continuing."
    open -a "App Store"
    echo "Press Enter after logging in to the Mac App Store..."
    read -r
fi

# Installing Mac App Store applications
echo "Installing Apple AppStore Applications"
MAS_APPS=(
    "1099475282:SnailGit Lite"
    "1436522307:Transmit 5"
    "1352778147:Bitwarden"
    "1354318707:Core Tunnel"
)

for app in "${MAS_APPS[@]}"; do
    id="${app%%:*}"
    name="${app#*:}"
    echo "Installing $name..."
    mas install "$id" || echo "Failed to install $name, continuing..."
done

echo "Important Apps installed"
echo "****DONE****"

# Changing macOS defaults
echo "Changing macOS defaults..."
mkdir "$HOME/Desktop/Screenshots"
defaults write NSGlobalDomain _HIHideMenuBar -bool true
# defaults write NSGlobalDomain AppleHighlightColor -string "0.47 0.65 0.9"
defaults write NSGlobalDomain AppleAccentColor -int 1
defaults write com.apple.screencapture location -string "$HOME/Desktop/Screenshots"
defaults write com.apple.screencapture disable-shadow -bool false
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowStatusBar -bool false
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
#defaults write 'Apple Global Domain' _HIHideMenuBar -bool true

# Menu Bar setup
#echo "Setting up Menu Bar..."
#brew tap FelixKratz/formulae
#brew install sketchybar
#curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.28/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
#(git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)

# Start sketchybar service
#echo "Starting sketchybar service..."
#brew services start sketchybar

#logging into atuin
#atuin login

echo "Setup complete! You may need to restart your Mac for all changes to take effect."
# Ask user if they want to reboot
echo ""
echo "Would you like to reboot now? (Y/N)"
read -r response
case "$response" in
    [Yy]|[Jj])
        echo "Rebooting now..."
        sudo shutdown -r now
        ;;
    *)
        echo "Reboot skipped. Remember to reboot later to apply all changes."
        ;;
esac
