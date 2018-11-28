# my conf files
Using [dotbot](https://github.com/anishathalye/dotbot) its awesome.

I'm using a fork (of a fork of a fork) of `instant-markdown-d` which uses KaTeX
for maths (and has the upstream up to date):

    npm install -g git+https://github.com/bixel/instant-markdown-d.git

There are some other tweaks for OSX, I do not want to miss:

Enabling and setting key-repeat and initial key-repeat rates via
```
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10
```
The changes take effect after a logout.

## Oddities

To properly activate autocompletion, I need to run
```
rm ~/.zcompdump
compinit
```
Weirdly, this reported "compinit: insecure directories". After a few tries, it
"just worked"...  If this is not the case, [this github issue might
help](https://github.com/zsh-users/zsh-completions/issues/433).

## vim cheat sheet

**git**
- navigate history of current file: `:Glog`, `:cc`, `:cn`, every other quickfix
  nav
