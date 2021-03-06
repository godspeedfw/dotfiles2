#!/bin/bash

echo $(pwd)

current_dir=$(pwd)
olddir=~/dotfiles_old             # old dotfiles backup directory
# home_files=$(ls ./dots/home/)
dotfiles=$(ls ./dots/)
echo $dotfiles
mkdir $olddir
 done

mv ~/.zshrc $olddir/ 
mv ~/.xinitrc $olddir/ 
mv ~/.Xresources $olddir/ 
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


# for xorg stuff and zsh
for file in $(ls $(pwd)/dots/xorg/); do
  if [[ "$file" != "xresources"* ]]  
  then
    ln --verbose -s $current_dir/dots/xorg/$file ~/.$file
  else
    for file in $(ls $(pwd)/dots/xorg/xresources); do     # ask for what xresoures user wants(multiple colorschemes)
      echo "Use $file ?[y/n]"
      read ch
      if [[ "$ch" == "y" ]]; then
        ln --verbose -s $current_dir/dots/xorg/xresources/$file ~/.Xresources
      fi
    done
  fi
done
ln -s $current_dir/dots/zshrc ~/.zshrc


# fix bitmap fonts (FOR VOID LINUX ONLY)
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
fi
