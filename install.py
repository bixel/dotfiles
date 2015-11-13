#! /usr/bin/env python

import os

# Configuration
files = [
    'vimrc',
    'vim/UltiSnips',
    'vim/after/ftplugin'
    'nvimrc',
    'nvim',
    'zshrc',
    'zsh_local_example',
    'ctags',
]
backup = False


def link_to_home(filename, target_directory='~', hidden=True):
    """ Links filename (could be directory) into users home at '~'.
        If the file exists, it is backed up first to a file named '*.bak'.
    """
    source = os.path.join(os.path.dirname(os.path.abspath(__file__)), filename)
    target = os.path.expanduser(
        os.path.join(target_directory, ('.' if hidden else '') + filename)
    )
    if os.path.exists(target):
        print('{} exists'.format(target))
        if backup:
            os.rename(target, target + '.bak')
        elif os.path.islink(target):
            'target is link'
            os.unlink(target)
        else:
            os.remove(target)
    # TODO: Check whether target is composed of directories
    # (os.path.commonprefix)
    #
    # elif os.path.isdir(source):
    #     os.mkdir(source)
    os.symlink(source, target)


for f in files:
    link_to_home(f, target_directory='~/test/')
