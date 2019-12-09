#!/usr/bin/expect
spawn sudo cp /etc/resolv.conf.bak /etc/resolv.conf
expect " password for user: "
send "password\r"
interact
