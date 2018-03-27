#!/usr/bin/env python2
import sys
import datetime
import requests
import getpass
from BeautifulSoup import BeautifulSoup

#https://auth.kocaeli.edu.tr:1003/keepalive?050605000110a0b7
# 8.8.4.4

def login(no, pwd):
    c = requests.session()

    # get login page
    r1 = c.get('http://8.8.4.4', verify=False)
    soup = BeautifulSoup(r1.text)
    magic = soup.find('input', {'name':'magic'}).get('value')

    values = {
        'magic' : magic,
        'username' : no,
        'password' : pwd,
        '4Tredir' : ""
    }

    # login
    r2 = c.post('https://192.168.20.1:1003/login?', data=values, verify=False)
    soup = BeautifulSoup(r2.text)
    for x in soup.findAll('a'):
        url = x.get('href')
        if url == "":
            continue
        session_id = url[url.rfind('?')+1:]
        keep_alive_url = "https://192.168.20.1:1003/keepalive?%s" % session_id
	logfile = open('/home/delta/scripts/koulog.txt', 'a')
	logfile.write(datetime.datetime.now().ctime() + '\n')
        logfile.write('logout url: ' + url + '\n')
        logfile.write('keepalive url: ' + keep_alive_url + '\n')
	logfile.close();

if __name__ == '__main__':
    login(100000000, "100000000")
