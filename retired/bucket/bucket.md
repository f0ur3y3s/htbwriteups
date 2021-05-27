Nmap scan report for 10.10.10.212                                                                                                                                                                                                          
Host is up (0.095s latency).                                                                                                                                                                                                               
Not shown: 998 closed ports                                                                                                                                                                                                                
PORT   STATE SERVICE VERSION                                                                                                                                                                                                               
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4 (Ubuntu Linux; protocol 2.0)                                                                                                                                                                   
| ssh-hostkey:                                                                                                                                                                                                                             
|   3072 48:ad:d5:b8:3a:9f:bc:be:f7:e8:20:1e:f6:bf:de:ae (RSA)
|   256 b7:89:6c:0b:20:ed:49:b2:c1:86:7c:29:92:74:1c:1f (ECDSA)
|_  256 18:cd:9d:08:a6:21:a8:b8:b6:f7:9f:8d:40:51:54:fb (ED25519)
80/tcp open  http    Apache httpd 2.4.41
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: Apache/2.4.41 (Ubuntu)
|_http-title: Did not follow redirect to http://bucket.htb/
Service Info: Host: 127.0.1.1; OS: Linux; CPE: cpe:/o:linux:linux_kernel



Nmap scan report for 10.10.10.212
Host is up (0.094s latency).
Not shown: 998 closed ports
PORT   STATE SERVICE
22/tcp open  ssh
80/tcp open  http


Contact Us on support@bucket.htb
http://s3.bucket.htb/adserver/images/malware.png

http://s3.bucket.htb/adserver


no images, perhaps s3 bucket is down?
