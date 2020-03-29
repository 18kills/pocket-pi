#!bin/bash
sudo apt-get update
#install ssmtp and mailutils
sudo apt-get install ssmtp mailutils --yes
sudo apt-get update --fix-missing
sudo apt-get install ssmtp mailutils --yes
#install network manager
sudo apt-get install network-manager --yes
#install create_ap
git clone https://github.com/oblique/create_ap.git
cd create_ap
sudo make install
#Make pocketPi executable
chmod +x pocketPi.sh

#Setup ssmtp to send mail through a gmail account
email="user@anything.com"
emailPass="password"
#User inputs email account
echo "If you are using a gmail account make sure that less secure app access is on"
echo "Input Example: user@gmail.com"
read -p "Enter your full email address: " email
read -p "Enter your password to your email: " emailPass


emailProvider=${email#*@}
emailProvider=${emailProvider%.*}

