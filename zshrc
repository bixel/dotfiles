### O H - M Y - Z S H  C O N F I G ###

## Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

plugins=(git pass brew)

source $ZSH/oh-my-zsh.sh

### U S E R  C O N F I G ###

# Device-specifig setup (ignored by git)
source .zsh-ownrc

### ALIASES ###
# list directory in human readable (-h), listed (-l) way. Show all files (-a).
# -F: display an indicator for special list entries (folder, links, etc...)
alias ll='ls -Fhla | less -R'
alias l='ls -lha'

# backup-aliases for rsync
alias backup-work-pull='rsync --exclude-from=$WORK/devtool-settings/rsync-exclude --numeric-ids --delete -b --backup-dir=$WORK/.rsync-backup -azuhP uber:~/rsync/arbeit/ $WORK'
alias backup-work-push='rsync --exclude-from=$WORK/devtool-settings/rsync-exclude --numeric-ids --delete -b --backup-dir=.rsync-backup -azuhP $WORK/ uber:~/rsync/arbeit'

# git aliases
alias gits='git status -s'
# setup ROOT-PATH for python
alias SetupPyROOT='
export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$LD_LIBRARY_PATH&&
export PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH'

### e5-specific ###
alias me5='sshfs lhcb: ~/mount/e5 && cd ~/mount/e5'

# root
alias iwantroot='cd $(brew --prefix root) && source libexec/thisroot.sh'

### Users PATHs ###
# Uni
export SMD=~/Documents/Studium/2014\ Wintersemester/SMD/
export STUD=~/Documents/Studium/
export SEM=~/Documents/Studium/2014\ Wintersemester/
export FP=~/Documents/Studium/FP14/
export AP=~/Documents/Studium/AP12/
export PEP=~/Documents/Studium/pep-et-al/
export E5=~/Documents/Studium/e5/

# Work
export WORK=~/Documents/Arbeit/
export FH=~/Documents/Arbeit/2014/ItInvFb9/

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
