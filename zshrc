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

# use the symlinked ssh-auth-sock if inside tmux session otherwise update the
# symlink
# if [[ -f "$HOME/.ssh/ssh_auth_sock" ]]; then
#     export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock;
# fi

# if we have a working socket, everything is fine
if [[ -f "$SSH_AUT_SOCK" ]]; then
    # if the socket is working, symlink it for other uses
    if ssh-add -l; then
        ln -sf $SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock;
    fi
elif [[ -f "$HOME/.ssh/ssh_auth_sock" ]]; then
    export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
fi

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
