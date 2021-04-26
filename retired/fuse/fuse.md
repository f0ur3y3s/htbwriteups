nmap -sCV 10.10.10.193 > nmap.txt 

seems to rejecting all my nmaps


`nmap -sC -sV -Pn 10.10.10.193 > nmap.txt`

```

Nmap scan report for 10.10.10.193

PORT     STATE SERVICE      VERSION
88/tcp   open  kerberos-sec Microsoft Windows Kerberos (server time: 2020-06-13 20:23:55Z)
389/tcp  open  ldap         Microsoft Windows Active Directory LDAP (Domain: fabricorp.local, Site: Default-First-Site-Name)
593/tcp  open  ncacn_http   Microsoft Windows RPC over HTTP 1.0
636/tcp  open  tcpwrapped
3268/tcp open  ldap         Microsoft Windows Active Directory LDAP (Domain: fabricorp.local, Site: Default-First-Site-Name)
Service Info: Host: FUSE; OS: Windows; CPE: cpe:/o:microsoft:windows
```

enum4linux does not work

 WinFsp is a set of software components for Windows computers that allows the creation of user mode file systems. In this sense it is similar to FUSE (Filesystem in Userspace), which provides the same functionality on UNIX-like computers. 

metasploit no bueno

nothing on smbclient -L 10.10.10.193

nmap -p 389 --script ldap-search 10.10.10.169   




root@kali:~/Downloads/boxes/fuse# sqlmap -u "http://10.10.10.193"

[17:31:02] [INFO] testing connection to the target URL
got a refresh intent (redirect like response common to login pages) to 'http://fuse.fabricorp.local/papercut/logs/html/index.htm'. Do you want to apply it from now on? [Y/n] 

http://fuse.fabricorp.local/papercut/logs/html/index.htm



nmap -p 88 -Pn --script krb5-enum-users --script-args krb5-enum-users.realm='fuse.fabricorp.local',userdb=/root/Downloads/boxes/fuse/names.txt fuse.fabricorp.local
saw a huge list of users, but not too sure if this is the correct way

added 10.10.10.193 as fuse.fabricorp.local


PaperCut Print Logger - http://www.papercut.com/
Time,User,Pages,Copies,Printer,Document Name,Client,Paper Size,Language,Height,Width,Duplex,Grayscale,Size
2020-05-29 17:50:10,pmerton,1,1,HP-MFT01,"New Starter - bnielson - Notepad",JUMP01,LETTER,PCL6,,,NOT DUPLEX,GRAYSCALE,19kb,
2020-05-29 17:53:55,tlavel,1,1,HP-MFT01,"IT Budget Meeting Minutes - Notepad",LONWK015,LETTER,PCL6,,,NOT DUPLEX,GRAYSCALE,52kb,
2020-05-30 16:37:45,sthompson,1,1,HP-MFT01,"backup_tapes - Notepad",LONWK019,LETTER,PCL6,,,NOT DUPLEX,GRAYSCALE,20kb,
2020-05-30 16:42:19,sthompson,1,1,HP-MFT01,"mega_mountain_tape_request.pdf",LONWK019,LETTER,PCL6,,,NOT DUPLEX,GRAYSCALE,104kb,
2020-05-30 17:07:06,sthompson,1,1,HP-MFT01,"Fabricorp01.docx - Word",LONWK019,LETTER,PCL6,,,NOT DUPLEX,GRAYSCALE,153kb,

PaperCut Print Logger - http://www.papercut.com/
Time,User,Pages,Copies,Printer,Document Name,Client,Paper Size,Language,Height,Width,Duplex,Grayscale,Size
2020-06-10 17:40:21,bhult,1,1,HP-MFT01,"offsite_dr_invocation - Notepad",LAPTOP07,LETTER,PCL6,,,NOT DUPLEX,GRAYSCALE,19kb,
2020-06-10 19:18:17,administrator,1,1,HP-MFT01,"printing_issue_test - Notepad",FUSE,LETTER,PCL6,,,NOT DUPLEX,GRAYSCALE,16kb,



possible users

pmerton
tlavel
sthompson
bhult
administrator


nmap -p 88 --script krb5-enum-users --script-args krb5-enum-users.realm='fuse.fabricorp.local',userdb=/root/Downloads/boxes/fuse/possiblenames.txt fuse.fabricorp.local
