# Device-specifig setup (ignored by git)
# source local config first to overwrite default theme if wanted
source ~/.zsh_local

# activate plugin manager
export ZPLUG_HOME=$HOME/.dotfiles/external/zplug
source $ZPLUG_HOME/init.zsh

zplug "romkatv/powerlevel10k", as:theme, use:"*10k.zsh-theme", depth:1
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "junegunn/fzf", use:"shell/*.zsh"
zplug "modules/git", from:prezto

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

### U S E R  C O N F I G ###

zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|?=** r:|?=**'

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

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
  mountroot="${REMOTE_MOUNT_ROOT:-$HOME/mounts}";
  if [ -n "$3" ]; then
      mountpoint=$3
  elif [ -z "$2" ]; then
      mountpoint=$1-home
  else
      mountpoint=$1-`echo $2 | sed -E "s/\///g"`
  fi
  mkdir -p $mountroot/$mountpoint
  if [[ $(uname -a) == *"Darwin"* ]]; then
      # following line is apple-specific
      sshfs $1:$2 "$mountroot/$mountpoint" -o auto_cache,reconnect,volname=$mountpoint,no_readahead,noappledouble,nolocalcaches
  else
      sshfs $1:$2 "$mountroot/$mountpoint" -o auto_cache,reconnect,no_readahead
  fi
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

# help creating links to emails
# in apple mail, go to viewing → Show message headers → Custom... → Add "Message-ID"
function murl () {
    echo message://"%3c"$@"%3e"
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zplug load

# use up and down keys for substring search (needs to be called after plugin loading)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
