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
zplug "modules/completion", from:prezto
zplug "docker/compose", use:contrib/completion/zsh
zplug "docker/cli", use:contrib/completion/zsh
zplug "Azure/azure-cli", use:az.completion, defer:3

### U S E R  C O N F I G ###

zmodload zsh/complist
zstyle ':completion:*' menu select

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

# help creating links to emails
# in apple mail, go to viewing → Show message headers → Custom... → Add "Message-ID"
function murl () {
    echo message://"%3c"$@"%3e"
}


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

alias pip_update_all="pip install -r <(pip freeze | sed 's|==.*||') -U"


#
# direnv
#

eval "$(direnv hook zsh)"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# load homebrew autocompletions
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

zplug load

# use up and down keys for substring search (needs to be called after plugin loading)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

[[ ! -f ~/.zsh_local_completions ]] || source ~/.zsh_local_completions
