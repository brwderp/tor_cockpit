#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "You must be root to run this."
   exit 1
fi
echo "Do you want add new user for start tor server(recommended):"
echo "[0] No"
echo "[1] Yes"
read doing

if [[ $doing -eq "1" ]]; then 
	echo "Enter username for new user: "
	read username
	adduser $username
fi

if [[ $doing -eq "0" ]]; then 
	echo "Enter directory for tor server[~/hidden_service]: "
	read directory
	if [[ $directory -eq "" ]]; then
		directory=~/hidden_service
	fi
	mkdir $directory
	chmod +x $directory
	username=$USER
fi

apt-get update
apt-get install tor cockpit -y
systemctl disable cockpit.socket
systemctl start cockpit.socket
systemctl disable tor
systemctl stop tor

if [[ $doing -eq "0" ]]; then
	echo "HiddenServiceDir $directory" >> /etc/tor/torrc
else
	echo "HiddenServiceDir /home/$username/hidden_service" >> /etc/tor/torrc
	mkdir /home/$username/hidden_service
	chown $username /home/$username/hidden_service
	chmod 700 /home/$username/hidden_service
fi
echo "HiddenServicePort 9090 127.0.0.1:9090" >> /etc/tor/torrc

exit 0
