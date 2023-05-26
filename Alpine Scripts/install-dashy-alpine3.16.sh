#!/bin/sh

#Stop the script if there is an error.
set -o errexit

#Setting up some fun colors
RED='\033[0;31m'
NC='\033[0m' # No Color

#Initial system update
apk update && apk upgrade
echo -e "${RED}System Updated...${NC}"
echo -e "${RED}Installing Required Files Now...${NC}"
apk add git net-tools curl wget
echo -e "${RED}Required tools installed...${NC}"
echo -e "${RED}Running system update...${NC}"
apk update && apk upgrade
echo -e "${RED}System update complete...${NC}"
echo -e "${RED}Installing NodeJS...${NC}"
apk add --update nodejs=16.20.0-r0
echo -e "${RED}NodeJS Installed...${NC}"
echo -e "${RED}Installing Yarn...${NC}"
apk add yarn
echo -e "${RED}Yarn installed...${NC}"
echo -e "${RED}Checking required versions...${NC}"
echo -e "Yarn Version:"
yarn --version 
echo -e "Required: 1.22.19"
echo -e "NodeJS Version:"
node -v
echo -e "Required: 16.20.0"
echo -e "${RED}If all the versions match then Dashy is ready to be installed...${NC}"
sleep 4
echo -e "${RED}Creating Dashy User and User Group...${NC}"
addgroup -S dashy && adduser -S dashy -G dashy
echo -e "${RED}Dashy user has been created...${NC}"
echo -e "${RED}Change directory...${NC}"
cd /home/dashy/
echo -e "Directory has been changed...${NC}"
echo -e "${RED}Cloneing Dashy...${NC}"
git clone https://github.com/Lissy93/dashy.git
cd /home/dashy/dashy/
echo -e "${RED}Dashy Cloned...${NC}"
yarn # Install dependencies
#Yarn will run out of memory when trying to build. This next command will allow 
#NodeJS to build with a max size of 1000mb of memory. It will fail without it. 
export NODE_OPTIONS=--max-old-space-size=1000
#build Dashy 
yarn build
#Let's make Dashy run on system startup
#Create simple launch script for Dashy
cat <<EOF > /home/dashy/start.sh
#!/bin/sh 
cd /home/dashy/dashy/
yarn start #start the app
EOF
#Set up Dashy to run at system boot
chmod +x /home/dashy/start.sh

#Create the service script for boot
cat <<EOF > /etc/init.d/dashy
#!/sbin/openrc-run

description="Running Dashy on system start"
supervisor=supervise-daemon
USER=dashy

name="Dashy"
command="/home/dashy/start.sh"
command_background="yes"
command_user="${USER}"
pidfile="/var/run/dashy.pid"

depend() {
        need net
}
EOF
#Allow to run
chmod +x /etc/init.d/dashy

#Enable the local service 
rc-update add dashy boot

echo -e "${RED}If you see this message everything worked!${NC}"
echo -e "${RED}Reboot container and launch${NC}"
ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
echo -e "on port 4000"
rc-service dashy start
exit 1
