source_if_exists () {
    if test -r "$1"; then
        source "$1"
    fi
}

source_if_exists $HOME/.config/zsh/env.zsh
source_if_exists $HOME/.config/zsh/history.zsh
source_if_exists $HOME/.config/zsh/zsh/git.zsh
# source_if_exists ~/.fzf.zsh
source_if_exists $HOME/.config/zsh/aliases.zsh
source_if_exists $HOME/.config/zsh/functions.zsh
source_if_exists $HOME/.config/zsh/herd.zsh
source_if_exists $HOME/.config/zsh/settings.zsh

precmd() {
    source $HOME/.config/zsh/aliases.zsh
}
eval "$(starship init zsh)"
