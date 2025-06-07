alias ls='eza --icons=always' # Basic replacement for ls with eza
alias l='eza --icons=always --long -bF' # Extended details with binary sizes and type indicators
alias ll='eza --icons=always --long -a' # Long format, including hidden files
alias llm='eza --icons=always --long -a --sort=modified' # Long format, including hidden files, sorted by modification date
alias la='eza -a --icons=always --group-directories-first' # Show all files, with directories listed first
alias lx='eza -a --icons=always --group-directories-first --extended' # Show all files and extended attributes, directories first
alias tree='eza --icons=always --tree' # Tree view
alias lS='eza --oneline--icons=always' # Display one entry per line
artisan() {
  local dir="$PWD"
  while [ "$dir" != "/" ]; do
    if [ -f "$dir/artisan" ]; then
      (cd "$dir" && php artisan "$@")
      return
    fi
    dir="$(dirname "$dir")"
  done
  echo "No artisan script found in this directory or any parent directories."
  return 1
}
alias find='fd'
alias cat='bat'
