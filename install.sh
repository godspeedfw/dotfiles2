#!/bin/bash

echo $(pwd)

current_dir=$(pwd)
olddir=~/dotfiles_old             # old dotfiles backup directory
home_files=$(ls ./dots/home/)
config_files=$(ls ./dots/config/)
echo $config_files
mkdir $olddir
mkdir $olddir/home
mkdir $olddir/config

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $home_files; do
    echo "Moving any existing dotfiles in home dir from ~ to $olddir/home"
    mv --verbose ~/.$file ~/dotfiles_old/home
    echo "Creating symlink to $file in home directory."
    ln --verbose -s $current_dir/dots/home/$file ~/.$file
    echo $(pwd)
done

for file in $config_files; do
    echo "Moving any existing dotfiles from .config dir ~ to $olddir/config"
    mv --verbose ~/.config/$file ~/dotfiles_old/home
    echo "Creating symlink to $file in .config directory."
    ln --verbose -s $current_dir/dots/config/$file ~/.config/$file
done
