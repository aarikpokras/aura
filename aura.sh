#!/bin/bash

if [ -z "$1" ]; then
  echo Please pass a package.
elif [[ "$1" = "-R" ]]; then
  grep $2 ~/.aura/pkglog
  case $? in
    0)
      sudo pacman -R $2
      ;;
    *)
      echo Package not in AUR package log, proceeding...
      sleep 3
      sudo pacman -R $2
      ;;
  esac
else
  git clone https://aur.archlinux.org/$1.git
  if [ -f "$1/PKGBUILD" ]; then
    echo Cloned. Installing...
    cd $1
    makepkg -si
    echo $1 >> ~/.aura/pkglog
  else
    printf "\e[1;31mError: \e[0mpackage not in AUR repos\n"
    rm -rf $1
  fi
fi
