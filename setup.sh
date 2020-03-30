#!/bin/bash

email="user@anything.com"
emailPass="password"

#Install needed packages
installPackages(){
  sudo apt-get update
  #install ssmtp and mailutils
  sudo apt-get install ssmtp mailutils --yes
  sudo apt-get update --fix-missing
  sudo apt-get install ssmtp mailutils --yes
  #Install hostapd
  sudo apt-get install hostapd --yes
  #install create_ap
  git clone https://github.com/oblique/create_ap.git
  cd create_ap
  sudo make install
}
#Configure the PocketPi program
pocketPiConf(){
	cd /home/pi/pocket-pi
	#Make pocketPi executable
	chmod +x PocketPi
	#Copy file to /etc
	sudo cp /home/pi/pocket-pi/PocketPi /etc/PocketPi
	#Edit /etc/rc.local to run the PocketPi program on boot
	sudo echo "sudo ./etc/PocketPi $email $emailPass & exit 0" > /etc/rc.local
}
#Setup mailing
MailSetup(){
	cd /home/pi/pocket-pi
	#Setup ssmtp to send mail through a gmail account
	email="user@anything.com"
	emailPass="password"
	#User inputs email account
	echo "If you are using a gmail account make sure that less secure app access is on"
	echo "Input Example: user@gmail.com"
	read -p "Enter your full email address: " email
	read -p "Enter your password to your email: " emailPass
	#Get the mailhub address
	emailProvider=${email#*@}
	emailProvider=${emailProvider%.*}
	emailProvider="${emailProvider//+([[:space:]])/}"
	mailhub=$( cat MailServers | grep "$emailProvider" )
	#Make the ssmtp config file
	sudo echo "root=$email" > /etc/ssmtp/ssmtp.conf
	sudo echo "mailhub=$mailhub" >> /etc/ssmtp/ssmtp.conf
	sudo echo "hostname=$(hostname)" >> /etc/ssmtp/ssmtp.conf
	sudo echo "FromLineOverride=YES" >> /etc/ssmtp/ssmtp.conf
	sudo echo "AuthUser=$email" >> /etc/ssmtp/ssmtp.conf
	sudo echo "AuthPass=$emailPass" >> /etc/ssmtp/ssmtp.conf
	sudo echo "UseSTARTTLS=YES" >> /etc/ssmtp/ssmtp.conf
}
#Call the installPackages function
installPackages
#Call MailSetup function
MailSetup
#Call the pocketPiConf function
pocketPiConf
