#!bin/bash
sudo apt-get update
sudo apt-get install ssmtp mailutils --yes
sudo apt-get update --fix-missing
sudo apt-get install ssmtp mailutils --yes
chmod +x pocketPi.sh
