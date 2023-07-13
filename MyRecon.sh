#!/bin/bash

targetdomain=$1

mkdir Data@$targetdomain
touch Data@$targetdomain/IPs.txt
touch Data@$targetdomain/PortScan.txt
touch Data@$targetdomain/DomainScan.txt


nslookup $targetdomain | grep "Address: " | cut -d " " -f 2 >> Data@$targetdomain/IPs.txt

for IP in $(cat Data@$targetdomain/IPs.txt); do
	nmap $IP -A -F -T2 -v >> Data@$targetdomain/PortScan.txt
done

dirb https://$targetdomain /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt -w -z 100 >> Data@$targetdomain/DomainScan.txt
