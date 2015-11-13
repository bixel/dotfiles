# vim:ft=zsh ts=2 sw=2 sts=2
# first approach to simple template using some functions from agnoster theme

# Git: branch/detached head, dirty status
prompt_git() {
  local color dirty branch
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    if [[ -n $dirty ]]; then
      color='yellow'
    else
      color='green'
    fi
    branch=$(git rev-parse --abbrev-ref HEAD)
    echo -n "%F{$color}➤ $branch%f"
  fi
}

PROMPT='%F{blue}%~%f '
RPROMPT='$(prompt_git)'
