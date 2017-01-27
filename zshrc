# instantaneously start tmux, if available
if command -v tmux>/dev/null; then
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi

# Device-specifig setup (ignored by git)
# source local config first to overwrite default theme if wanted
source ~/.zsh_local

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

### U S E R  C O N F I G ###

# random string function
random-string()
{
    LC_CTYPE=C tr -dc A-Za-z0-9 < /dev/urandom | fold -w ${1:-32} | head -n 1
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

# mount a remote host at /MountPoint/bla-home
mounthome () {
 sshfs $1: /MountPoints/$1-home -o auto_cache,reconnect,volname=$1-home,no_readahead,noappledouble,nolocalcaches
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

if [ -f ~/.iterm2_shell_integration.zsh ]; then
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi
