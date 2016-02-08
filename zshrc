# Device-specifig setup (ignored by git)
# source local config first to overwrite default theme if wanted
source .zsh_local

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

#
# Aliases
#

# Git
alias glol="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glola="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"

# Utility
alias rm="nocorrect rm"

#
# Python
#

# virtualenvwrapper
source virtualenvwrapper.sh
export VIRTUAL_ENV_DISABLE_PROMT=yes
