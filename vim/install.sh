#!/usr/bin/env bash

set -e

info () {
  printf "\r  [ \033[00;34mvim\033[0m ] $1\n"
}

VIM_HOME=$HOME/.vim

# make sure it exists
mkdir -p $VIM_HOME

dst=$VIM_HOME/colors
src=$DOTFILES/vim/colors
skip=

# does the destination already exist?
if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
then
    info 'removing existing colors link'
    rm -rf "$dst"
fi

info "linking the src to dst"
ln -s "$src" "$dst"
