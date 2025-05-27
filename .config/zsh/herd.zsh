

if [ -d "/Users/michael.grunewalder/Library/Application Support/Herd/bin" ]; then
    echo "Setting up Herd environment"
    # Herd injected PHP 8.4 configuration.
    export HERD_PHP_84_INI_SCAN_DIR="/Users/michael.grunewalder/Library/Application Support/Herd/config/php/84/"

    # Herd injected NVM configuration
    export NVM_DIR="/Users/michael.grunewalder/Library/Application Support/Herd/config/nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

    [[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"
    
    # Herd injected PHP 8.3 configuration.
    export HERD_PHP_83_INI_SCAN_DIR="/Users/michael.grunewalder/Library/Application Support/Herd/config/php/83/"

    # Herd injected PHP 8.2 configuration.
    export HERD_PHP_82_INI_SCAN_DIR="/Users/michael.grunewalder/Library/Application Support/Herd/config/php/82/"

    # Herd injected PHP 8.1 configuration.
    export HERD_PHP_81_INI_SCAN_DIR="/Users/michael.grunewalder/Library/Application Support/Herd/config/php/81/"
    
else
    echo "Skipping Setup if HERD environment"
fi



