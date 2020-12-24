# to get root

`ps aux` - inspect processes
inspect cronjobs
try sudo 
look at sudo privileges
look at file privileges

# hackthebox

add to /etc/hosts

run two nmap scans, one fast and one more in depth
```
nmap -sCV -v __.__.__.___
nmap __.__.__.___
```

# tools

```
LinEnum
evil-winrm
enum4linux
kerbrute
impacket
```


# articles

https://github.com/xapax/security/blob/master/bypass_image_upload.md
https://www.securifera.com/blog/2017/01/28/a-less-dirty-cow/ - anacron exploit


# methods

lfi
arbitrary file uploads
open smb share
sql injection
dll hijacking
