#!/bin/bash

# Author: BlackSheep4 - Cybersecurity Analist

# Description: Setup of ShellXPloit.

# Banner:

source src/banner.sh

# Global Variables:
trap ctrl_c INT
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'


function ctrl_c(){
	echo "Exiting..."
}

function setup(){
	echo -e "${RED}Welcome to ShellXploit (Out-LAN).${NC} Your setup will start in some seconds... Be patient! \n"
	sleep 2.5
}

function checkInstall(){

# SSH Installation
	echo -e "\n ${YELLOW}[+] Checking that SSH is installed...${NC}"
	which ssh | command > /dev/null 2>&1
	installed="$?"
	if [ $installed -eq 0 ]; then
		echo -e "\n ${GREEN}[+] SSH found in:${NC} " | tr -d '\n' && which ssh
	else
		echo -e "\n ${RED}[!] SSH was not found! Installing it...${NC}"
		apt-get install openssh-server
	fi

# Metasploit Installation
	echo -e "\n ${YELLOW}[+] Checking that Metasploit is installed...${NC}"
	which msfconsole | command > /dev/null 2>&1
	installed="$?"
	if [ $installed -eq 0 ]; then
		echo -e "\n ${GREEN}[+] Metasploit found in: ${NC}" | tr -d '\n' && which msfconsole
	else
		echo -e "\n ${RED}[!] Metasploit was not found! Installing it...${NC}"
		apt-get install https://github.com/rapid7/metasploit-framework.git
	fi
}


function configAttack(){

# SSH Keygen
	echo -e "\n ${YELLOW}[+] Generating SSH Key...${NC}"
	find ~/.ssh/id_rsa > /dev/null 2>&1
	installed="$?"
	if [ $installed -eq 0 ]; then
		echo -e "${GREEN} [!] Seems that you have a SSH Key. Using default SSH Key...${NC}"
	else
		echo -e "${GREEN}[+] SSH Key was not found. Generating...${NC}"
		echo -ne "\n" | ssh-keygen
	fi

#SSH Port Forwarding
	echo -e "${GREEN} [+] Tunnelizing connections!${NC}"
	ssh -R 80:localhost:80 localhost.run
}

setup
checkInstall
configAttack