#!/bin/bash

if dpkg --get-selections|grep 'install'|grep 'sudo' 1>/dev/null
then
echo
else
echo "Please, install 'sudo'."
exit
fi

if sudo -l | grep "may not run sudo"
then
echo "Please, add the user to sudoers."
exit
fi

sudo apt-get update
sudo apt-get install git -y
sudo apt-get install vim -y
sudo apt-get 