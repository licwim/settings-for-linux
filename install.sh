#!/bin/bash
PKGS="sudo openssh-server net-tools gcc vim git"
DIR="$HOME/settings-for-linux"
GITPATH="https://github.com/licwim/settings-for-linux.git"
SSH="/etc/ssh"
OHMYZSH="https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"

install_pkg()
{
	sudo apt-get install "$@" -y
}

check_sudo()
{
	sudo -l | grep "Matching Defaults" > /dev/null || {
	echo "Please, add the user to sudoers."
	exit
	}
	sudo apt-get update
}

check_pkg()
{
	dpkg --get-selections | grep -v "deinstall" | grep "$@" > /dev/null || {
		if [ $@ = "sudo" ]
		then
		echo "Please, install 'sudo'."
		exit
		else
		install_pkg "$@"
		fi
	}
	if [ $@ = "sudo" ]
	then
		check_sudo
	fi
}

for pkg in $PKGS
do
check_pkg $pkg
done

git config --global user.name "licwim"
git config --global user.email licwimm@gmail.com

git clone "$GITPATH" $DIR

cp $HOME/.vimrc $DIR/backup/vimrc__original
cp $DIR/source/.vimrc $HOME/.vimrc 

sudo cp $SSH/sshd_config $DIR/backup/sshd_config__original
sudo cp $DIR/source/sshd_config $SSH/sshd_config

#sudo apt-get install zsh -y
#sh -c "$(wget -O- $OHMYZSH)"