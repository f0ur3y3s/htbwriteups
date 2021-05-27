# Love

## Easy | 10.10.10.239

### nmap

```
Nmap scan report for 10.10.10.239
Host is up (0.18s latency).
Not shown: 993 closed ports
PORT     STATE SERVICE      VERSION
80/tcp   open  http         Apache httpd 2.4.46 ((Win64) OpenSSL/1.1.1j PHP/7.3.27)
| http-cookie-flags: 
|   /: 
|     PHPSESSID: 
|_      httponly flag not set
|_http-server-header: Apache/2.4.46 (Win64) OpenSSL/1.1.1j PHP/7.3.27
|_http-title: Voting System using PHP
135/tcp  open  msrpc        Microsoft Windows RPC
139/tcp  open  netbios-ssn  Microsoft Windows netbios-ssn
443/tcp  open  ssl/http     Apache httpd 2.4.46 (OpenSSL/1.1.1j PHP/7.3.27)
|_http-server-header: Apache/2.4.46 (Win64) OpenSSL/1.1.1j PHP/7.3.27
|_http-title: 403 Forbidden
| ssl-cert: Subject: commonName=staging.love.htb/organizationName=ValentineCorp/stateOrProvinceName=m/countryName=in
| Not valid before: 2021-01-18T14:00:16
|_Not valid after:  2022-01-18T14:00:16
|_ssl-date: TLS randomness does not represent time
| tls-alpn: 
|_  http/1.1
445/tcp  open  microsoft-ds Windows 10 Pro 19042 microsoft-ds (workgroup: WORKGROUP)
3306/tcp open  mysql?
| fingerprint-strings: 
|   LDAPBindReq, LDAPSearchReq, NCP, NULL, NotesRPC, RTSPRequest, afp, giop, oracle-tns: 
|_    Host '10.10.14.86' is not allowed to connect to this MariaDB server
5000/tcp open  http         Apache httpd 2.4.46 (OpenSSL/1.1.1j PHP/7.3.27)
|_http-server-header: Apache/2.4.46 (Win64) OpenSSL/1.1.1j PHP/7.3.27
|_http-title: 403 Forbidden
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port3306-TCP:V=7.91%I=7%D=5/25%Time=60AD4D3D%P=x86_64-pc-linux-gnu%r(NU
SF:LL,4A,"F\0\0\x01\xffj\x04Host\x20'10\.10\.14\.86'\x20is\x20not\x20allow
SF:ed\x20to\x20connect\x20to\x20this\x20MariaDB\x20server")%r(RTSPRequest,
SF:4A,"F\0\0\x01\xffj\x04Host\x20'10\.10\.14\.86'\x20is\x20not\x20allowed\
SF:x20to\x20connect\x20to\x20this\x20MariaDB\x20server")%r(LDAPSearchReq,4
SF:A,"F\0\0\x01\xffj\x04Host\x20'10\.10\.14\.86'\x20is\x20not\x20allowed\x
SF:20to\x20connect\x20to\x20this\x20MariaDB\x20server")%r(LDAPBindReq,4A,"
SF:F\0\0\x01\xffj\x04Host\x20'10\.10\.14\.86'\x20is\x20not\x20allowed\x20t
SF:o\x20connect\x20to\x20this\x20MariaDB\x20server")%r(NCP,4A,"F\0\0\x01\x
SF:ffj\x04Host\x20'10\.10\.14\.86'\x20is\x20not\x20allowed\x20to\x20connec
SF:t\x20to\x20this\x20MariaDB\x20server")%r(NotesRPC,4A,"F\0\0\x01\xffj\x0
SF:4Host\x20'10\.10\.14\.86'\x20is\x20not\x20allowed\x20to\x20connect\x20t
SF:o\x20this\x20MariaDB\x20server")%r(oracle-tns,4A,"F\0\0\x01\xffj\x04Hos
SF:t\x20'10\.10\.14\.86'\x20is\x20not\x20allowed\x20to\x20connect\x20to\x2
SF:0this\x20MariaDB\x20server")%r(afp,4A,"F\0\0\x01\xffj\x04Host\x20'10\.1
SF:0\.14\.86'\x20is\x20not\x20allowed\x20to\x20connect\x20to\x20this\x20Ma
SF:riaDB\x20server")%r(giop,4A,"F\0\0\x01\xffj\x04Host\x20'10\.10\.14\.86'
SF:\x20is\x20not\x20allowed\x20to\x20connect\x20to\x20this\x20MariaDB\x20s
SF:erver");
Service Info: Hosts: www.example.com, LOVE, www.love.htb; OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
|_clock-skew: mean: 2h53m15s, deviation: 4h02m33s, median: 33m12s
| smb-os-discovery: 
|   OS: Windows 10 Pro 19042 (Windows 10 Pro 6.3)
|   OS CPE: cpe:/o:microsoft:windows_10::-
|   Computer name: Love
|   NetBIOS computer name: LOVE\x00
|   Workgroup: WORKGROUP\x00
|_  System time: 2021-05-25T12:50:53-07:00
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
| smb2-security-mode: 
|   2.02: 
|_    Message signing enabled but not required
| smb2-time: 
|   date: 2021-05-25T19:50:52
|_  start_date: N/A

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 90.70 seconds

```

```
┌──(f0ur3y3s㉿f0ur3y3skali)-[~]
└─$ nmap 10.10.10.239     
Starting Nmap 7.91 ( https://nmap.org ) at 2021-05-25 15:17 EDT
Stats: 0:00:17 elapsed; 0 hosts completed (1 up), 1 undergoing Connect Scan
Connect Scan Timing: About 54.73% done; ETC: 15:18 (0:00:08 remaining)
Nmap scan report for 10.10.10.239
Host is up (0.18s latency).
Not shown: 993 closed ports
PORT     STATE SERVICE
80/tcp   open  http
135/tcp  open  msrpc
139/tcp  open  netbios-ssn
443/tcp  open  https
445/tcp  open  microsoft-ds
3306/tcp open  mysql
5000/tcp open  upnp

Nmap done: 1 IP address (1 host up) scanned in 36.64 seconds

```