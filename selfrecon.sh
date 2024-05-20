#!/bin/bash

clear

RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
MAGENTA='\033[35m'
CYAN='\033[36m'
RESET='\033[0m'

echo ""
echo -e "${GREEN}[+]Network Status for Listen${BLUE}"
echo ""

netstat -antuln | grep LISTEN

echo ""
ports=($(netstat -antuln | grep LISTEN | awk '{print $4}' | awk -F ':' '{print $NF}' | uniq))

for port in "${ports[@]}"; do
    echo -e "${YELLOW}LISTEN PORT: $port${BLUE}"

done

echo ""


echo -e "${GREEN}[+]Network Status for ESTABLISHE${BLUE}"
echo " "
netstat -antuln | grep ESTABLISHE
echo ""

ports=($(netstat -antuln | grep ESTABLISHED | awk '{print $4}' | awk -F ':' '{print $NF}' | uniq))

for port in "${ports[@]}"; do
	lsof -i:$port

done

echo ""


if ! command -v whois &> /dev/null
then
    echo -e "${RESET}"
    exit 1
fi


echo -e "${RED}[+]Connected Host Information${BLUE}"
echo ""

hosts=($(netstat -antuln | grep ESTABLISHED | awk {'print $5'} | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}\b'))

for host in "${hosts[@]}"; do
	echo $host && whois $host | grep -i orgname
	echo""
done

hosts=($(netstat -antuln | grep ESTABLISHED | grep tcp6 | awk {'print $5'} | uniq))

for host in "${hosts[@]}"; do
	echo $host && whois $host | grep -i orgname
	echo ""
done


