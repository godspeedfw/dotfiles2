#!/bin/bash

echo $(pwd)

current_dir=$(pwd)
olddir=~/dotfiles_old             # old dotfiles backup directory
# home_files=$(ls ./dots/home/)
dotfiles=$(ls ./dots/)
echo $dotfiles
mkdir $olddir
# mkdir $olddir/config

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
# for file in $home_files; do
#     echo "Moving any existing dotfiles in home dir from ~ to $olddir/home"
#     mv --verbose ~/.$file ~/dotfiles_old/home
#     echo "Creating symlink to $file in home directory."
#     ln --verbose -s $current_dir/dots/home/$file ~/.$file
#     echo $(pwd)
# done

mv ~/.zshrc $olddir/ 
mv ~/.xinitrc $olddir/ 
mv ~/.xbindkeysrc $olddir/

# for all dotfiles except xorg, zsh
for file in $dotfiles; do
    if [[ $file != "zsh" || $file != "xorg" ]]
    then
      echo "Moving any existing dotfiles from .config dir ~ to $olddir/config"
      mv --verbose ~/.config/$file ~/dotfiles_old/home
      echo "Creating symlink to $file in .config directory."
      ln --verbose -s $current_dir/dots/$file ~/.config/$file
    fi 
done

# for xorg and zsh
for file in $(ls pwd/dotfiles/xorg/); do
  ln --verbose -s $file ~/.$file
done
ln -s $current_dir/dots/zshrc ~/.zshrc

os_name=$(grep '^NAME=' /etc/os-release | grep -o '".*"' | tr -d '"')
if [[ $os_name = "void" ]] ; then
	/bin/bash ./scripts/no_bitmap.sh
fi

# user scripts
if [[ -d $HOME/.local/bin ]]; then
    cp -r ./scripts/* $HOME/.local/bin
else
    mkdir $HOME/.local/bin && cp -r ./bin/* $HOME/.local/bin
fi


# sublime text configuration
if [[ -d $HOME/.config/sublime-text-3/Packages ]]; then
  rm -rf $HOME/.config/sublime-text-3/Packages/User
  ln --verbose -s $current_dir/dots/sublime-text-3/User $HOME/.config/sublime-text-3/Packages/
