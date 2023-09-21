# my conf files
Using [dotbot](https://github.com/anishathalye/dotbot) its awesome.

I'm using a fork (of a fork of a fork) of `instant-markdown-d` which uses KaTeX
for maths (and has the upstream up to date):

    npm install -g git+https://github.com/bixel/instant-markdown-d.git

There are some other tweaks for macOS, I do not want to miss:

Enabling and setting key-repeat and initial key-repeat rates via
```
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10
```
The changes take effect after a logout.
*Warning* If you want to present a slideshow with these settings enabled,
you'll have a nightmate using most presenters.

Remap ESC and CAPSLOCK keys
```
sudo defaults read com.apple.loginwindow || sudo defaults write com.apple.loginwindow LoginHook $PWD/osx_startup_script.sh && sudo ./osx_startup_script.sh
```

## Apple M1 and python quirks
Currently, adding this to the `.zsh_local` for x86 vs arm64 workarounds
```bash
if [ "$(uname -m)" = "x86_64" ]; then
    export X86_SLUG="86"
fi

export PATH="/opt/homebrew$X86_SLUG/bin:/opt/homebrew$X86_SLUG/sbin:$PATH"
export PYENV_ROOT="$HOME/.pyenv$X86_SLUG"
export PATH="$PYENV_ROOT/bin:$HOME/.jenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(jenv init -)"
```
I've added a prompt segment to indicate if I'm currently in a rosetta shell.

## Oddities

To properly activate autocompletion, I need to run
```
rm ~/.zcompdump
compinit
```
Weirdly, this reported "compinit: insecure directories". After a few tries, it
"just worked"...  If this is not the case, [this github issue might
help](https://github.com/zsh-users/zsh-completions/issues/433).

## Power settings on my old-ish MBP
These should be fine, as per `man pmset`
```
sudo pmset -b hibernatemode 25 standbydelaylow 600 standbydelayhigh 1200
```

## Storing secrets and stuff in keychain
Thanks to [some medium article](https://medium.com/@johnjjung/how-to-store-sensitive-environment-variables-on-macos-76bd5ba464f6)
```
security add-generic-password -a "$USER" -s 'name_of_your_key' -w 'passphrase'
```
and
```
security find-generic-password -a "$USER" -s 'name_of_your_key' -w
```

