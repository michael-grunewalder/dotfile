function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

cd() {
  if [ "$#" -eq 0 ]; then
    local dir
    dir=$(fd --type d . 2> /dev/null | fzf) && builtin cd "$dir"
  else
    builtin cd "$@"
  fi
}

fcd() {
  if [ "$#" -eq 0 ]; then
    local dir
    dir=$(fd --type d . 2> /dev/null | fzf) && builtin cd "$dir"
  else
    builtin cd "$@"
  fi
}
