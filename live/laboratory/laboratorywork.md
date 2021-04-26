 10.10.10.216 

quick nmap 

four3y3s@43y3s:~$ nmap  10.10.10.216 
Starting Nmap 7.91 ( https://nmap.org ) at 2020-12-24 16:40 EST
Nmap scan report for 10.10.10.216
Host is up (0.14s latency).
Not shown: 997 filtered ports
PORT    STATE SERVICE
22/tcp  open  ssh
80/tcp  open  http
443/tcp open  https

map scan report for laboratory.htb (10.10.10.216)                                                                                                                                                                                         
Host is up (0.13s latency).                                                                                                                                                                                                                
Not shown: 997 filtered ports                                                                                                                                                                                                              
PORT    STATE SERVICE VERSION                                                                                                                                                                                                              
22/tcp  open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.1 (Ubuntu Linux; protocol 2.0)                                                                                                                                                         
| ssh-hostkey:                                                                                                                                                                                                                             
|   3072 25:ba:64:8f:79:9d:5d:95:97:2c:1b:b2:5e:9b:55:0d (RSA)
|   256 28:00:89:05:55:f9:a2:ea:3c:7d:70:ea:4d:ea:60:0f (ECDSA)
|_  256 77:20:ff:e9:46:c0:68:92:1a:0b:21:29:d1:53:aa:87 (ED25519)
80/tcp  open  http    Apache httpd 2.4.41
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: Apache/2.4.41 (Ubuntu)
|_http-title: Did not follow redirect to https://laboratory.htb/
443/tcp open  ssl/ssl Apache httpd (SSL-only mode)
| http-methods: 
|_  Supported Methods: HEAD GET POST OPTIONS
|_http-server-header: Apache/2.4.41 (Ubuntu)
|_http-title: The Laboratory
| ssl-cert: Subject: commonName=laboratory.htb
| Subject Alternative Name: DNS:git.laboratory.htb
| Issuer: commonName=laboratory.htb
| Public Key type: rsa
| Public Key bits: 4096
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2020-07-05T10:39:28
| Not valid after:  2024-03-03T10:39:28
| MD5:   2873 91a5 5022 f323 4b95 df98 b61a eb6c
|_SHA-1: 0875 3a7e eef6 8f50 0349 510d 9fbf abc3 c70a a1ca
| tls-alpn: 
|_  http/1.1
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel



https://gtfobins.github.io/


Apache/2.4.41 (Ubuntu) Server at laboratory.htb Port 443

CEO Dexter
Dee Dee Uncertain
Anonymous

had to change /etc/hosts from 10.10.10.216  laboratory.htb to 10.10.10.216 git.laboratory.htb


https://git.laboratory.htb/users/sign_in