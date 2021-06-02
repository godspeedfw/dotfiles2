#!/bin/bash

echo $(pwd)

current_dir=$(pwd)
olddir=~/dotfiles_old             # old dotfiles backup directory
home_files=$(ls ./dots/home/)
config_files=$(ls ./dots/config/)
mkdir $olddir
mkdir $olddir/home
mkdir $olddir/config

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $home_files; do
    echo "Moving any existing dotfiles in home dir from ~ to $olddir/home"
    mv ~/.$file ~/dotfiles_old/home
    echo "Creating symlink to $file in home directory."
    ln -s $current_dir/dots/home/$file ~/.$file
done

for file in $config_files; do
    echo "Moving any existing dotfiles from .config dir ~ to $olddir/config"
    mv ~/.config/$file ~/dotfiles_old/home
    echo "Creating symlink to $file in .config directory."
    ln -s $current_dir/dots/config/$file ~/.config/$file
done
