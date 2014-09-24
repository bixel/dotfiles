# activate colors
export CLICOLOR=1

### ALIASES ###
# list directory in human readable (-h), listed (-l) way. Show all files (-a).
# -F: display an indicator for special list entries (folder, links, etc...)
# pipe it to less for scrolling
alias ll='ls -Fhla | less -R'

# change into current semester
alias sem='cd ~/Documents/Studium/.currentSemester'
# connect to pihalbe@uberspace shell
alias uber='ssh pihalbe@octans.uberspace.de'
# run python3
alias py='python3.3'
alias ipy='ipython3-3.3'
# python2
alias py2='python2.7'
alias ipy2='ipython-2.7'
# use consolemode MacVim
alias vim='mvim -v'

### e5-specific ###
alias me5='sshfs lhcb: ~/mount/e5 && cd ~/mount/e5'

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
    source /opt/ROOT/5.34.18/bin/thisroot.sh
else
    if [ -f "/opt/local/bin/root" ]; then
        source /opt/local/bin/thisroot.sh
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

