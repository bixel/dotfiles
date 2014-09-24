### O H - M Y - Z S H  C O N F I G ###

## Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

plugins=(git pass macports)

source $ZSH/oh-my-zsh.sh

### U S E R  C O N F I G ###

# Device-specifig setup (ignored by git)
source .zsh-ownrc

### ALIASES ###
# list directory in human readable (-h), listed (-l) way. Show all files (-a).
# -F: display an indicator for special list entries (folder, links, etc...)
alias ll='ls -Fhla | less -R'
alias l='ls -lha'

# gdb with macports
alias gdb='ggdb'
# git aliases
alias gits='git status -s'
# setup ROOT-PATH for python
alias SetupPyROOT='
export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$LD_LIBRARY_PATH&&
export PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH'

### e5-specific ###
alias me5='sshfs lhcb: ~/mount/e5 && cd ~/mount/e5'

### RasPi-Stuff
#alias dhcpon='sudo /bin/launchctl load -w /System/Library/LaunchDaemons/bootps.plist&&sudo ipconfig set en0 MANUAL 192.168.33.1 255.255.255.0&&echo "DHCP-Server startet for 192.168.33.1"'
#alias dhcpoff='sudo /bin/launchctl unload -w /System/Library/LaunchDaemons/bootps.plist&&sudo ipconfig set en0 DHCP&&echo "DHCP-Server shut down"'
#alias couchdb='ssh pi@192.168.33.2 -N -L 9000:localhost:5984'

### Users PATHs ###
# Uni
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

# let me find ROOT maagic
# (This will perfom some magic to define ROOT paths and stuff)
if [ -d "/opt/ROOT/" ]; then
    cd /opt/ROOT/5.34.18/ && source bin/thisroot.sh && cd ~/.
else
    if [ -f "/opt/local/bin/root" ]; then
       cd /opt/local/ && source bin/thisroot.sh && cd ~/.
    fi
fi

# let me find the postgresql executables
export PATH=/opt/local/lib/postgresql93/bin:$PATH

##
# Your previous /Users/greenapple/.bash_profile file was backed up as /Users/greenapple/.bash_profile.macports-saved_2014-03-07_at_15:37:47
##

# MacPorts Installer addition on 2014-03-07_at_15:37:47: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
