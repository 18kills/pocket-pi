#!bin/bash
sudo apt-get update
#install ssmtp and mailutils
sudo apt-get install ssmtp mailutils --yes
sudo apt-get update --fix-missing
sudo apt-get install ssmtp mailutils --yes
#install create_ap
git clone https://github.com/oblique/create_ap.git
cd create_ap
sudo make install
#Install hostapd
sudo apt-get install hostapd --yes
#Make pocketPi executable
chmod +x PocketPi

sudo echo "sudo ./home/pi/PocketPi & exit 0" 

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
mailhub=$( cat | grep "$emailProvider" )
#Make the ssmtp config file
sudo echo "root=$email" > /etc/ssmtp/ssmtp.conf
sudo echo "mailhub=$mailhub" >> /etc/ssmtp/ssmtp.conf
sudo echo "hostname=$(hostname)" >> /etc/ssmtp/ssmtp.conf
sudo echo "FromLineOverride=YES" >> /etc/ssmtp/ssmtp.conf
sudo echo "AuthUser=$email" >> /etc/ssmtp/ssmtp.conf
sudo echo "AuthPass=$emailPass" >> /etc/ssmtp/ssmtp.conf
sudo echo "UseSTARTTLS=YES" >> /etc/ssmtp/ssmtp.conf
