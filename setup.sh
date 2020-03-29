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
