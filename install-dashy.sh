#!/bin/bash

#Let's stop the script if anything errors out. 
set -o errexit

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#READ ME FIRST: This script is intended to be directly run on a ubuntu 20.10 LXC privileged container.
#I have only tested on that but I would imagine you could run this on any Ubuntu machine as long as you 
#edit the directories used to fit your needs.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Let's start by making sure we are up to date
sudo apt update && sudo apt upgrade
#Downloading and installing dependencies for getting packages dependent software - Git, Curl, and net-tools for printing local IP at the end.
sudo apt-get install git curl net-tools
#Now that we have Curl, lets add the corect version of NodeJS
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo bash -
#We need to refresh the apt repositories now
sudo apt-get update
sudo apt-get install -y nodejs
sudo apt-get update && sudo apt-get upgrade -y
#This may look redundant but I promise it needs to be done this way!
#"yarn" is used by a program called cmdtest. If this process is not done like this it will 
#always fail due to cmdtest being installed. If you know a better way please let me know! 
sudo apt-get remove cmdtest
sudo apt-get autoremove
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install yarn
echo
echo
#Print versions of Yarn and NodeJS
echo Yarn Version:
yarn --version 
echo Node Version:
node -v
echo
echo If you did not get a version of both Yarn and NodeJS then something did not work.
echo 
#Time to download Dashy
git clone https://github.com/Lissy93/dashy.git
cd /root/dashy/
yarn # Install dependencies
#Yarn will run out of memory when trying to build. This next command will allow 
#NodeJS to build with a max size of 1000mb of memory. It will fail without it. 
export NODE_OPTIONS=--max-old-space-size=1000
#Build Yarn
yarn build # Build the app

#Let's make Dashy run on system startup
#Create simple launch script for Dashy
cat <<EOF > /root/dashy/start.sh
#!/bin/bash 
cd /root/dashy/
yarn start #start the app
EOF
#Allow the to run
chmod +x /root/dashy/start.sh
#Create the service ID file to launch dashy on container boot
cat <<EOF > /etc/systemd/system/dashy.service
[Unit]
Description=dashy
Before=motd-news.service

[Service]
Type=oneshot
ExecStart=/root/dashy/start.sh
StandardOutput=journal+console

[Install]
WantedBy=multi-user.target
EOF
#Enabled the service for systemctl
sudo systemctl enable dashy
#Script is finished! Fingers crossed this works first try!
echo If you see this message everything worked!
echo Reboot container and launch
ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
echo on port 4000
