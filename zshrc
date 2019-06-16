# Device-specifig setup (ignored by git)
# source local config first to overwrite default theme if wanted
source ~/.zsh_local

# start tmux in a nice way, if available
t () {
  if command -v tmux>/dev/null; then
    [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && tmux new-session -A -s main
  fi
}

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

### U S E R  C O N F I G ###

# Override agnosters prompt_dir
# Using prompt_sorin's abbreviation
prompt_dir() {
  local pwd="${PWD/#$HOME/~}"

  if [[ "$pwd" == (#m)[/~] ]]; then
    prompt="$MATCH"
    unset MATCH
  else
    prompt="${${${${(@j:/:M)${(@s:/:)pwd}##.#?}:h}%/}//\%/%%}/${${pwd:t}//\%/%%}"
  fi
  prompt_segment blue $PRIMARY_FG " $prompt "
}

export PATH="$HOME/go/bin:$PATH"

# random string function
random-string()
{
  LC_ALL=C tr -dc A-Za-z0-9 < /dev/urandom | fold -w ${1:-32} | head -n 1
}

# make code printable with pandocs
# printable-code filename.ext [forced-extension]
printable-code()
{
  body=`cat ${1}`
  [[ ${1} =~ "([^.]+).([^.]+)" ]] && name=$match[1] && ext=$match[2]
  ext=`test -n "${2}" && echo ${2} || echo $ext`
  doc="# ${1}\n\`\`\`$ext\n$body\n\`\`\`"
  oformat=`test -n "${3}" && echo ${3} || echo "pdf"`
  echo $doc | pandoc -o "$name.$oformat"
}

# mount a remote's ($1) host dir ($2) at $3/$2 or ~/mounts/$2 if $3 is not set
mountremote () {
  # set the root mount dir
  mountroot="${3:-$HOME/mounts}";
  if [ -z "$2" ]; then
      mountpoint=$1-home
  else
      mountpoint=$1-`echo $2 | sed -E "s/\///g"`
  fi
  mkdir -p $mountroot/$mountpoint
  sshfs $1:$2 "$mountroot/$mountpoint" -o auto_cache,reconnect,volname=$mountpoint,no_readahead,noappledouble,nolocalcaches
  unset mountroot
  unset mountpoint
}

# check number of tmux sessions running on list of ssh hosts
function tmux-num-sessions () {
    if (( $# == 0 )) then;
        echo usage: tmux-num-sessions ssh-host-1 ssh-host-2 ...
    fi
    hosts=$@
    for i; do
        sessions=$(ssh $i tmux ls 2>/dev/null)
        if (( $? )) then;
            echo $i: No sessions
        else
            echo $i: $(echo $sessions | wc -l) sessions
        fi
    done
}

# make the clipboard working on remote
if [[ -n "$SSH_CLIENT" ]]; then
  SSH_IP=$(echo $SSH_CLIENT | awk '{print $1}')
  alias pbcopy="ssh $SSH_IP pbcopy"
fi

#
# Aliases
#

# Git
alias glol="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glola="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"
alias imgcat="~/.dotfiles/imgcat"

# Utility
alias rm="nocorrect rm"

#
# Python
#

# virtualenvwrapper
if [ -f ~/virtualenvwrapper.sh ]; then
  source ~/virtualenvwrapper.sh
  export VIRTUAL_ENV_DISABLE_PROMT=yes
fi

if [[ -n "$ITERM_INTEGRATION" && -f ~/.iterm2_shell_integration.zsh ]]; then
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

# a new attempt to forward ssh sockets to tmux

if [[ -n "$SSH_AUTH_SOCK" ]]; then
    # based on/using http://stackoverflow.com/questions/21378569 and
    # https://gist.github.com/martijnvermaat/8070533

    # Fix SSH auth socket location so agent forwarding works with tmux
    if [[ -z "$TMUX" ]] ; then
        ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
    else
        export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
    fi
fi

# taskwarrior setup, stolen from https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/taskwarrior/taskwarrior.plugin.zsh
zstyle ':completion:*:*:task:*' verbose yes
zstyle ':completion:*:*:task:*:descriptions' format '%U%B%d%b%u'

zstyle ':completion:*:*:task:*' group-name ''

alias t=task
compdef _task t=task
