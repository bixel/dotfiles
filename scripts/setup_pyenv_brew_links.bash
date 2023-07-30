#! /usr/bin/env bash

PYTHON_VERSION="${1:?Python version to link}"

LINK_TARGET_DIR=$HOME/.brew_python_links/python@${PYTHON_VERSION}

mkdir -p $LINK_TARGET_DIR
lndir $(brew --prefix "python@$PYTHON_VERSION") $LINK_TARGET_DIR

for f in python wheel pip pydoc; do
    ln -sf "$LINK_TARGET_DIR/bin/${f}${PYTHON_VERSION}" "$LINK_TARGET_DIR/bin/$f";
    ln -sf "$LINK_TARGET_DIR/bin/${f}${PYTHON_VERSION}" "$LINK_TARGET_DIR/bin/${f}3";
done
ln -sf "$LINK_TARGET_DIR/bin/python${PYTHON_VERSION}-config" "$LINK_TARGET_DIR/bin/python-config"
ln -sf "$LINK_TARGET_DIR/bin/python${PYTHON_VERSION}-config" "$LINK_TARGET_DIR/bin/python3-config"

ln -s $LINK_TARGET_DIR "$(pyenv root)/versions/$PYTHON_VERSION"
pyenv rehash
