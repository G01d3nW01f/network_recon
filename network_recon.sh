#!/bin/bash


echo "[+]Network Status for Listen"
echo " "

netstat -antuln | grep LISTEN

echo ""
ports=($(netstat -antuln | grep LISTEN | awk '{print $4}' | awk -F ':' '{print $NF}' | uniq))

for port in "${ports[@]}"; do
    echo "LISTEN PORT: $port"

done

echo " "


echo "[+]Network Status for ESTABLISHE"
echo " "
netstat -antuln | grep ESTABLISHE
echo ""

ports=($(netstat -antuln | grep ESTABLISHED | awk '{print $4}' | awk -F ':' '{print $NF}' | uniq))

for port in "${ports[@]}"; do
	lsof -i:$port

done

echo ""

echo "[+]Connected Host Information"
echo ""

hosts=($(netstat -antuln | grep ESTABLISHED | awk {'print $5'} | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}\b'))

for host in "${hosts[@]}"; do
	echo $host && whois $host | grep -i orgname
	echo""
done
