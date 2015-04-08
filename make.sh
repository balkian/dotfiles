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
files=$(ls --ignore="not_dots" --ignore="README.md" --ignore="make.sh" --ignore="Docker" $PWD)  # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "** Creating $olddir for backup: of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
echo "** Creating symlinks. Any existing dotfiles will be moved to: $olddir"
for file in $files; do
    mv ~/.$file $olddir && echo "Backed up: ~/.$file"
    ln -s $PWD/$file ~/.$file
done

rmdir $olddir 2>/dev/null && echo "Backup dir empty. Removed"
