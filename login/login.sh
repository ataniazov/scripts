#!/bin/bash
#if [ "$1" == "--help" ] || [ "$1" == "" ]; then
#	echo "help screen is not ready yet"
#	echo "you help yourself:)"
#	exit
#fi

#ConfLocation=$1

#if [ -r login.conf ]; then
	echo "Reading login config...."
	#. $ConfLocation
	NetworkTestURL=https://api.ipify.org
	LoginURL=https://192.168.20.1:1003/login?
	KeepAliveURL=https://192.168.20.1:1003/keepalive?
	UserName=100000000
	Password=100000000

	while [ : ]
	do
		echo "Checking internet connection...."
		ip=$(wget --no-check-certificate $NetworkTestURL -q -t 1 -T 3 -O -)
		#ip=$(wget --no-check-certificate $NetworkTestURL -q -t 1 -T 3 -O - | grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)")
		#ip=$(grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" /home/delta/scripts/login/test.html)

		if [[ ! $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
		#if [ -z "$ip" ]; then
			echo "Connection by URL failed...."
			content=$(wget --no-check-certificate $KeepAliveURL -q -t 1 -T 3 -O -)

			if [ -z "$content" ]; then
				#echo "Connection failed...."
				content=$(wget --no-check-certificate $LoginURL -q -t 1 -T 3 -O -)

				echo "Trying to login...."
				if [ ! -z "$content" ]; then
					magic=$(echo $content | sed -n 's/.*name="magic"\s\+value="\([^"]\+\).*/\1/p')
					content=$(wget --post-data="4Tredir=''&magic=$magic&username=$UserName&password=$Password" --no-check-certificate $LoginURL -q -t 1 -T 3 -O -)
				fi
			else
				echo "You are already Logged in."
				echo "Check your DNS settings."
				
			fi

			echo "Restarting VPN...."
			/home/user/scripts/login/ssh-kill.sh
			echo "Login successful. Have fun."

		else
			echo "Everything seems to be working fine."
			echo "Your IP address is: $ip"
		fi
		sleep 1m
	done
	echo "Bye Bye...."
#else
#	echo "FATAL ERROR: Config file not found."
#fi
echo "Script termination...."
