#!/bin/bash

if dpkg --get-selections|grep 'install'|grep 'sudo' 1>/dev/null
then
echo
else
echo "Please, install 'sudo'."
exit
fi

if sudo -l 2| grep "may not run sudo"
then
echo "Please, add the user to sudoers."
exit
fi

sudo apt-get update

if dpkg --get-selections|grep 'install'|grep 'openssh' 1>/dev/null
then
echo
else
sudo apt-get install openssh -y
fi

if dpkg --get-selections|grep 'install'|grep 'net-tools' 1>/dev/null
then
echo
else
suso apt-get install net-tools -y
fi

if dpkg --get-selections|grep 'install'|grep 'vim' 1>/dev/null
then
sudo apt-get upgrade vim -y
else
sudo apt-get install vim -y
fi

sudo apt-get install git -y
echo "syntax on\n" >> ~/.vimrc
echo "set nu\n" >> ~/.vimrc
echo "set mouse=a\n" >> ~/.vimrc
git config --global user.name "licwim"
git config --global user.email licwimm@gmail.com
sudo apt-get install zsh -y
sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"