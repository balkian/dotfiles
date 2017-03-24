#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

# change to the dotfiles directory
cd `dirname $0`

########## Don't forget the submodules
git submodule init
git submodule update --recursive

olddir=~/dotfiles$(date +%Y-%m-%d_%H:%M:%S) # old dotfiles backup directory
files=$(ls -1 --ignore="not_dots" --ignore="README.md" --ignore="make.sh" --ignore="Docker" $PWD)  # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
for file in $files; do
    stow -v $file
done
