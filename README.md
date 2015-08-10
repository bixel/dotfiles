## my conf files

I am just symlinking all the neccessary dotfiles to this repo.

The file `.zsh_local`, referenced in `.zshrc` defines the username (for displaying in OH-MY-ZSH, for example).
An example for the local configurations is given in `.zsh_local_example`.

There are some other tweaks for OSX, I do not want to miss:

  - Enabling key-repeat via `defaults write -g ApplePressAndHoldEnabled -bool false`
  - Setting key-repeat rate via `defaults write NSGlobalDomain KeyRepeat -int 1`

The changes take effect after a logout.
