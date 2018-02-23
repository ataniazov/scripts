#!/bin/bash

#Pwned Passwords

#Pwned Passwords are half a billion real world passwords previously exposed in data breaches. This exposure makes them unsuitable for ongoing use as they're at much greater risk of being used to take over other accounts. They're searchable online below as well as being downloadable for use in other online system. Read more about how HIBP protects the privacy of searched passwords.

if [ "$1" == "--help" ] || [ "$1" == "" ]; then
	echo "Checks if your Password was Pwned"
	echo
	echo "usage : haveibeenpwned.sh [PASSWORD]"
	exit
fi

PASS=$1
HASH=`echo -n "$PASS" | sha1sum`
RESPONSE=$(curl -s "https://api.pwnedpasswords.com/range/`echo -n $HASH | cut -c -5`" | grep -i `echo -n "$HASH" | cut -c 6-`)

echo $RESPONSE

if [ "$RESPONSE" == "" ]; then
	echo "Good news — no pwnage found!
	This password wasn't found in any of the Pwned Passwords loaded into Have I been pwned. That doesn't necessarily mean it's a good password, merely that it's not indexed on this site."
else
	TIMES=${RESPONSE#*:}

	NUMBER=2
	echo "Oh no - pwned! This password has been seen ${NUMBER} times before"
	echo "This password has previously appeared in a data breach and should never be used. If you've ever used it anywhere before, change it immediately!"
fi
