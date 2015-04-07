#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

# dotfiles directory
dir=`dirname $0`

########## Don't forget the submodules
git submodule init
git submodule update --recursive

olddir=~/dotfiles$(date +%Y-%m-%d_%H:%M:%S) # old dotfiles backup directory
files=$(ls --ignore="not_dots" --ignore="README.md" --ignore="make.sh" --ignore="DevDockerfile" $dir)  # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup: of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir 
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done


