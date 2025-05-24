source_if_exists () {
    if test -r "$1"; then
        source "$1"
    fi
}

source_if_exists $HOME/.config/zsh/env.zsh
source_if_exists $HOME/.config/zsh/history.zsh
source_if_exists $HOME/.config/zsh/zsh/git.zsh
# source_if_exists ~/.fzf.zsh
source_if_exists $HOME/.config/zsh/zsh/aliases.zsh

precmd() {
    source $HOME/.config/zsh/zsh/aliases.zsh
}


export PATH="$PATH:/usr/local/sbin:$DOTFILES/bin:$HOME/.local/bin:$DOTFILES/scripts/"

eval "$(starship init zsh)"
