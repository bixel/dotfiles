### O H - M Y - Z S H  C O N F I G ###

## Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Device-specifig setup (ignored by git)
# source local config first to overwrite default theme if wanted
source .zsh_local

plugins=(git pass brew)

source $ZSH/oh-my-zsh.sh

### U S E R  C O N F I G ###

### ALIASES ###
# list directory in human readable (-h), listed (-l) way. Show all files (-a).
# -F: display an indicator for special list entries (folder, links, etc...)
alias ll='ls -Fhla | less -R'
alias l='ls -lhatr'

# git aliases
alias gits='git status -s'
# setup ROOT-PATH for python
alias SetupPyROOT='
export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$LD_LIBRARY_PATH&&
export PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH'

### e5-specific ###
alias me5='sshfs lhcb: ~/mount/e5 && cd ~/mount/e5'
alias mbam='sshfs bam: ~/mount/e5 && cd ~/mount/e5'

# root
alias iwantroot='cd $(brew --prefix root) && source libexec/thisroot.sh && cd -'

# rapidminer
alias rapidminer='java -jar -Xmx6G ~/Applications/rapidminer/lib/rapidminer.jar'

# cool extract function
function extract()
{
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar xvjf $1 ;;
            *.tar.gz)   tar xvzf $1 ;;
            *.tar)      tar xvf $1  ;;
            *.zip)      unzip $1    ;;
            *)          echo "'$1' cannot be extracted via extract()";;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}
