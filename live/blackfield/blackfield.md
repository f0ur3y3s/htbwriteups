
nmap -sCV -A -T4 10.10.10.192 > nmap.txt

Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-25 11:15 EDT
Nmap scan report for BLACKFIELD.local (10.10.10.192)
Host is up (0.19s latency).
Not shown: 993 filtered ports
PORT     STATE SERVICE       VERSION
53/tcp   open  domain?
| fingerprint-strings: 
|   DNSVersionBindReqTCP: 
|     version
|_    bind
88/tcp   open  kerberos-sec  Microsoft Windows Kerberos (server time: 2020-06-25 22:20:40Z)
135/tcp  open  msrpc         Microsoft Windows RPC
389/tcp  open  ldap          Microsoft Windows Active Directory LDAP (Domain: BLACKFIELD.local0., Site: Default-First-Site-Name)
445/tcp  open  microsoft-ds?
593/tcp  open  ncacn_http    Microsoft Windows RPC over HTTP 1.0
3268/tcp open  ldap          Microsoft Windows Active Directory LDAP (Domain: BLACKFIELD.local0., Site: Default-First-Site-Name)
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port53-TCP:V=7.80%I=7%D=6/25%Time=5EF4BFBA%P=x86_64-pc-linux-gnu%r(DNSV
SF:ersionBindReqTCP,20,"\0\x1e\0\x06\x81\x04\0\x01\0\0\0\0\0\0\x07version\
SF:x04bind\0\0\x10\0\x03");
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
OS fingerprint not ideal because: Missing a closed TCP port so results incomplete
No OS matches for host
Network Distance: 2 hops
Service Info: Host: DC01; OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
|_clock-skew: 7h04m33s
| smb2-security-mode: 
|   2.02: 
|_    Message signing enabled and required
| smb2-time: 
|   date: 2020-06-25T22:23:13
|_  start_date: N/A

TRACEROUTE (using port 135/tcp)
HOP RTT       ADDRESS
1   183.59 ms 10.10.14.1
2   185.78 ms BLACKFIELD.local (10.10.10.192)

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 230.82 seconds



root@kali:~/Downloads/boxes/blackfield# smbclient -L ////10.10.10.192//forensic
Enter WORKGROUP\root's password: 

        Sharename       Type      Comment
        ---------       ----      -------
        ADMIN$          Disk      Remote Admin
        C$              Disk      Default share
        forensic        Disk      Forensic / Audit share.
        IPC$            IPC       Remote IPC
        NETLOGON        Disk      Logon server share 
        profiles$       Disk      
        SYSVOL          Disk      Logon server share


why is ldap open on two ports?
port 53 open is potentially bad

network is 'hopping'
enum4linux had no results

says that audit2020 is possible user


hydra -L usernames.txt -P passwords.txt 192.168.2.66 smb -V -f

rpcclient -U "" -N 10.10.10.192 allows anonymous login

root@kali:~/Downloads/tools/CrackMapExec# crackmapexec smb 10.10.10.192
SMB         10.10.10.192    445    DC01             [*] Windows 10.0 Build 17763 (name:DC01) (domain:BLACKFIELD.local) (signing:True) (SMBv1:False)

root@kali:~/Downloads/tools/CrackMapExec# crackmapexec winrm 10.10.10.192
WINRM       10.10.10.192    5985   DC01             [*] http://10.10.10.192:5985/wsman

root@kali:~/Downloads/tools/CrackMapExec# crackmapexec smb 10.10.10.192 -u anonymous -p  ""
SMB         10.10.10.192    445    DC01             [*] Windows 10.0 Build 17763 (name:DC01) (domain:BLACKFIELD.local) (signing:True) (SMBv1:False)
SMB         10.10.10.192    445    DC01             [+] BLACKFIELD.local\anonymous: 
