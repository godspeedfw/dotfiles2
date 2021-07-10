#!/bin/bash
os_name=$(grep '^NAME=' /etc/os-release | grep -o '".*"' | tr -d '"')

install_cmd () {
  if [[ $os_name = "void" ]];  then
    void install $1
  fi
  if [[ $os_name = "Arch Linux" ]];  then
    sudo pacman -S $1
  fi
}

# install zsh and ohmyzsh
install_ohmyzsh () {
  install_cmd "zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

#install x and x related stuff
install_cmd "xorg xbindkeys xsel xdotool"
if [[ $os_name = "void" ]];  then
  install_cmd "xinit"
fi
if [[ $os_name = "Arch Linux" ]];  then
  install_cmd "xorg-xinit"
fi

#install audio related stuff
setup_audio () {
  install_cmd "alsa-utils pulseaudio volctl"
  sudo usermod -a -G audio $USER
}
setup_audio

#install dwm

