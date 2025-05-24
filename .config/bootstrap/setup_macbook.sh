#!/bin/bash

#######################Install XCode CMD Tools
echo "Installing commandline tools..."
xcode-select --install

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

###################Installing YADM to get the configurations
brew install yadm


echo "Getting configuration from YADM"
#rm -rf ~/.zshrc
#yadm clone git@github.com:michael-grunewalder/dotfile.git
yadm clone https://github.com/michael-grunewalder/dotfile.git
yadm status
yadm checkout -f

##################PPLY THE CONDFIGURATION
source ~/.config/zsh/env.zsh


# Update Homebrew
echo "Updating Homebrew..."
brew update

################Installing apps from  Homebrew
brew install screenresolution
brew install eza
brew install sketchybar
brew install fzf
brew install mas
brew install starship
brew install midnight-commander
brew install switchaudio-osx
brew install tmux
brew install jesseduffield/lazygit/lazygit
brew install neofetch
brew install nowplaying-cli
brew install ffmpeg
brew install sevenzip
brew install jq
brew install poppler
brew install fd
brew install ripgrep
brew install fzf
brew install zoxide
brew install resvg
brew install imagemagick
brew install yazi
brew install font-symbols-only-nerd-font

#####uncomment this f you want to use Android phones again
# brew install --no-quarantine grishka/grishka/neardrop

################Installing CASKS
brew install --cask --no-quarantine ghostty
brew install --cask --no-quarantine font-hack-nerd-font
brew install --cask --no-quarantine sf-symbols
brew install --cask --no-quarantine font-meslo-lg-nerd-font
brew install --cask --no-quarantine sublime-text
brew install --cask --no-quarantine font-sf-mono
brew install --cask --no-quarantine visual-studio-code
brew install --cask --no-quarantine font-sf-pro
brew install --cask --no-quarantine warp
brew install --cask --no-quarantine font-sketchybar-app-font
brew install --cask --no-quarantine appcleaner
brew install --cask --no-quarantine herd
brew install --cask --no-quarantine opera-air
brew install --cask --no-quarantine arc
brew install --cask --no-quarantine google-chrome
brew install --cask --no-quarantine firefox
brew install --cask --no-quarantine dbngin
brew install --cask --no-quarantine textmate
brew install --cask --no-quarantine setapp

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

echo "Changing macOS defaults..."
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults write NSGlobalDomain AppleHighlightColor -string "0.65098 0.85490 0.58431"
defaults write NSGlobalDomain AppleAccentColor -int 1
defaults write com.apple.screencapture location -string "$HOME/Desktop"
defaults write com.apple.screencapture disable-shadow -bool false
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowStatusBar -bool false
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool truescreen -bool false && defaults write 'Apple Global Domain' _HIHideMenuBar -bool true
brew services start sketchybar
