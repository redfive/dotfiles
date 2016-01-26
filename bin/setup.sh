#!/usr/bin/env bash

function error_exit {
  echo "$1" 1>&2
  exit 1
}

# base location of the dotfiles repo
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# create the bash completion directory if it doesn't exist
DEST_DIR=${HOME}/.bash_completion
if [[ ! -d ${DEST_DIR} ]]; then
  mkdir ${DEST_DIR} || error_exit "Failed to makedir ${DEST_DIR}"
fi

# loop over any source completion files, make sure they are installed and sourced
SRC_DIR="${DOTFILES_DIR}/bash/completion"
for f in $(find ${SRC_DIR} -type f); do

  # capture the name of the file to use in destination operation
  filename="$(basename $f)"

  # Does the file exist in the completion directory
  # TODO: check for link or directory here too
  if [[ ! -f ${DEST_DIR}/${filename} ]]; then
    #echo "File absent -- link me!"
    $(ln -s ${f} ${DEST_DIR}/${filename}) || error_exit "Failed to link ${f} to ${DEST_DIR}/${filename}"
  fi

  # check to see if it matches the file in the BCD, if not, update it
  # TODO: maybe use `readlink` here? 
  if ! $(diff ${f} ${DEST_DIR}/${filename} >/dev/null 2>&1); then
    #echo Files are different -- link me!
    $(ln -s ${f} ${DEST_DIR}/${filename}) || error_exit "Failed to link ${f} to ${DEST_DIR}/${filename}"
  fi
done 

# TODO - VIM configuration
# TODO - pathogen
# TODO - bundles like color schemes

# source all the bash completion scripts in the user's completion dir
if [[ -d ${DEST_DIR} ]]; then
  for f in $(find -L ${DEST_DIR} -type f); do
    echo "Sourcing ${f}"
    source ${f} || error_exit "Failed trying to source ${f}"
  done 
fi

