#!/usr/bin/expect
spawn sudo pkill -f "ssh -i /home/user/.ssh/id_rsa"
expect "password for user: "
send "password\r"
interact
