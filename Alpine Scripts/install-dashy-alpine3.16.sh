#!/bin/sh

#Stop the script if there is an error.
set -o errexit

#Initial system update
apk update && apk upgrade
echo System Updated
sleep 2
echo Installing Required Files Now
apk add git net-tools curl wget
echo Required tools installed!
sleep 2
echo Running system update!
sleep 2
apk update && apk upgrade
echo System update complete!
sleep 2
echo Installing NodeJS
sleep 2 
apk add --update nodejs=16.20.0-r0
echo NodeJS Installed!
sleep 2
echo Installing Yarn
sleep 2
apk add yarn
echo Yarn installed!
sleep 2 
echo checking required versions
echo Yarn Version:
yarn --version 
echo Required: 1.22.19
echo NodeJS Version:
node -v
echo Required: 16.20.0
echo If all the versions match then Dashy is ready to be installed!
sleep 4
echo Cloneing Dashy:
git clone https://github.com/Lissy93/dashy.git
cd /root/dashy/
echo Dashy Cloned!
sleep 2
yarn # Install dependencies
#Yarn will run out of memory when trying to build. This next command will allow 
#NodeJS to build with a max size of 1000mb of memory. It will fail without it. 
export NODE_OPTIONS=--max-old-space-size=1000
#build Dashy 
yarn build

#Let's make Dashy run on system startup
#Create simple launch script for Dashy
cat <<EOF > /root/start.sh
#!/bin/sh 
cd /root/dashy/
yarn start #start the app
EOF
#Allow the to run
chmod +x /root/start.sh

#Create the service script for boot
cat <<EOF > /etc/init.d/dashy
#!/sbin/openrc-run

description="Running Dashy on system start"

name="Dashy"
command="/root/start.sh"
command_background="yes"
pidfile="/var/run/dashy.pid"

depend() {
        need net
}
EOF
#Allow to run
chmod +x /etc/init.d/dashy

#Enable the local service 
rc-update add dashy
rc-update add dashy boot

echo If you see this message everything worked!
echo Reboot container and launch
ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
echo on port 4000
rc-service dashy start
exit 1