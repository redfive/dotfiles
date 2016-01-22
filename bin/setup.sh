#!/usr/bin/env bash

# get the local directory of the script, assume that the bash stuff is in pwd/../bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#echo $DIR

BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
#echo $BASE

# source the bash completion scripts
# create the bash completion directory if it doesn't exist
BASH_COMP_DIR=/home/jgaunt/.bash_completion
if [[ ! -d ${BASH_COMP_DIR} ]]; then
  mkdir ${BASH_COMP_DIR}
  #TODO: error check here
fi

# loop over any source completion files to 
BC="${BASE}/bash/completion"
for f in $(find ${BC} -type f); do
  # check to see if it matches the file in the BCD
  # if it does, skip it
  # if not and a file exists, remove it
  # link the file
  echo $f
done 

if [[ -d ${BASH_COMP_DIR} ]]; then
  for f in $(find ${BASH_COMP_DIR} -type f)
  do
    source $f
  done 
fi

