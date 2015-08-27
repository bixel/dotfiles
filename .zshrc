### O H - M Y - Z S H  C O N F I G ###

## Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

export ZSH_CUSTOM=~/.zsh_custom

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bixel"

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

# vi-mode ❤️ :O
# not so useful in daily life...
# bindkey -v
# bindkey '^?' backward-delete-char
# bindkey '^w' backward-kill-word
# bindkey '^r' history-incremental-search-backward
