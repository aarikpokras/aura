#!/bin/bash
#105

if [ -z "$1" ]; then
  echo Please pass a package.
elif [[ "$1" = "-R" ]]; then
  if [ -z "$2" ]; then
    echo No package specified.
    exit 1
  fi
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
elif [[ "$1" = "-u" ]]; then
  verTU=$(curl https://raw.githubusercontent.com/aarikpokras/aura/master/ver)
  verCR=$(cat `which aura` | head -n2 | tail -n1 | sed 's/#//')
  if [ $verTU -gt $verCR ]; then
    echo Update necessary. Visit the GitHub at https://github.com/aarikpokras/aura to update.
  else
    clear
    printf "\e[1;32mUp to date\e[0m\n"
  fi
else
  git clone https://aur.archlinux.org/$1.git
  if [ -f "$1/PKGBUILD" ]; then
    cd
    echo Cloned. Installing...
    cd $1
    makepkg -si
    touch ~/.aura/pkglog
    echo $1 >> ~/.aura/pkglog
    rm -rf ./$1
  else
    printf "\e[1;31mError: \e[0mpackage not in AUR repos\n"
    rm -rf $1
  fi
fi
