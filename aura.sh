#!/bin/bash
#120

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
elif [[ "$1" = "--uninstall" ]]; then
  case $EUID in
    0)
      echo Uninstalling...
      ;;
    *)
      echo You must be root to perform this operation.
      exit 1
      ;;
  esac
  sudo rm /usr/share/man/man1/aura.1.gz
  sudo rm /usr/bin/aura
  echo Done!
elif [[ "$1" = "-u" ]]; then
  verTU=$(curl https://raw.githubusercontent.com/aarikpokras/aura/master/ver)
  verCR=$(cat `which aura` | head -n2 | tail -n1 | sed 's/#//')
  if [ $verTU -gt $verCR ]; then
    echo Update necessary. Updating now. Use ^C to cancel.
    sleep 3
    cd
    echo Removing old version...
    sudo rm /usr/share/man/man1/aura.1.gz
    sudo rm /usr/bin/aura
    echo Cloning new version...
    git clone https://github.com/aarikpokras/aura.git
    cd aura
    echo Finalizing...
    sudo make
    make clean
    cd
    echo Done!
  else
    clear
    printf "\e[1;32mUp to date\e[0m\n"
  fi
else
  cd
  git clone https://aur.archlinux.org/$1.git
  if [ -f "$1/PKGBUILD" ]; then
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
