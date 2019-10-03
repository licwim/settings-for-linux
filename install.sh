#!/bin/bash
PKGS="openssh-server net-tools"
CMDS="gcc vim git"
DIR="$HOME/settings-for-linux"
GITPATH="https://github.com/licwim/settings-for-linux.git"
SSH="/etc/ssh"


#	Colors

RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
BOLD=$(printf '\033[1m')
RESET=$(printf '\033[m')

install_pkg()
{
	printf "\n$GREEN	INSTALLING $@ $RESET"
	sudo apt install $@ -y
}

check_sudo()
{
	if command -v sudo > /dev/null
	then
		sudo -l | grep "Matching Defaults" > /dev/null ||
		{
			echo "Please, add the user to sudoers."
			exit
		}
	else
		echo "Please, install 'sudo'."
		exit
	fi
}

check_pkg()
{
	dpkg --get-selections | grep -v "deinstall" | grep $@ > /dev/null || install_pkg $@
	printf "$RED $@ INSTALLED $RESET\n\n"
	echo "----------------------------------------------------------------"
}


check_cmd()
{
	command -v $@ > /dev/null || install_pkg $@
	printf "$RED $@ INSTALLED $RESET\n\n"
	echo "----------------------------------------------------------------"
}

check_sudo
sudo apt update

for pkg in $PKGS
do
echo "----------------------------------------------------------------"
echo "$YELLOW CHECKING $pkg $RESET"
check_pkg $pkg
done

for cmd in $CMDS
do
echo "----------------------------------------------------------------"
echo "$YELLOW CHECKING $cmd $RESET"
check_cmd $cmd
done

git config --global user.name "licwim"
git config --global user.email licwimm@gmail.com

ls -la $HOME | grep "settings-for-linux" > /dev/null || git clone "$GITPATH" $DIR

TIME=$(echo "$(date +%d%m%y)_$(date +%H%M%S)")

if ls -la $HOME | grep .vimrc > /dev/null
then
	cp $HOME/.vimrc $DIR/backup/vimrc_original_$TIME
fi
cp $DIR/source/.vimrc $HOME/.vimrc

sudo cp $SSH/sshd_config $DIR/backup/sshd_config_original_$TIME
sudo cp $DIR/source/sshd_config $SSH/sshd_config
sudo service sshd restart

#	Optional packages

OHMYZSH="https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"

sudo apt-get install zsh -y
sh -c "$(wget -O- $OHMYZSH)"