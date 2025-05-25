

if [ -d "/Users/michael.grunewalder/Library/Application Support/Herd/bin" ]; then
    echo "Setting up Herd environment"
    export HERD_PHP_84_INI_SCAN_DIR="/Users/michael.grunewalder/Library/Application Support/Herd/config/php/84/"
    # Herd injected NVM configuration
    export NVM_DIR="/Users/michael.grunewalder/Library/Application Support/Herd/config/nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm  

    [[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"
    export PATH="/Users/michael.grunewalder/Library/Application Support/Herd/bin/":$PATH
else
    echo "Skipping Setup if HERD environment"
fi