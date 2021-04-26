 10.10.10.220

200~Nmap scan report for 10.10.10.220
Host is up, received conn-refused (0.11s latency).
Scanned at 2020-12-29 19:13:11 UTC for 0s

PORT     STATE SERVICE  REASON
22/tcp   open  ssh      syn-ack
5080/tcp open  onscreen syn-ackNot shown: 998 closed ports                                                                                                                                                                                                                
PORT     STATE SERVICE VERSION                                                                                                                                                                                                             
22/tcp   open  ssh     OpenSSH 8.2p1 Ubuntu 4 (Ubuntu Linux; protocol 2.0)                                                                                                                                                                 
| ssh-hostkey:                                                                                                                                                                                                                             
|   3072 48:ad:d5:b8:3a:9f:bc:be:f7:e8:20:1e:f6:bf:de:ae (RSA)                                                                                                                                                                             
|   256 b7:89:6c:0b:20:ed:49:b2:c1:86:7c:29:92:74:1c:1f (ECDSA)                                                                                                                                                                            
|_  256 18:cd:9d:08:a6:21:a8:b8:b6:f7:9f:8d:40:51:54:fb (ED25519)                                                                                                                                                                          
5080/tcp open  http    nginx                                                                                                                                                                                                               
|_http-favicon: Unknown favicon MD5: F7E3D97F404E71D302B3239EEF48D5F2                                                                                                                                                                      
| http-methods:                                                                                                                                                                                                                            
|_  Supported Methods: GET HEAD POST OPTIONS                                                                                                                                                                                               
| http-robots.txt: 53 disallowed entries (15 shown)                                                                                                                                                                                        
| / /autocomplete/users /search /api /admin /profile                                                                                                                                                                                       
| /dashboard /projects/new /groups/new /groups/*/edit /users /help                                                                                                                                                                         
|_/s/ /snippets/new /snippets/*/edit                                                                                                                                                                                                       
??? from here until ???END lines may have been inserted/deleted
| http-title: Sign in \xC2\xB7 GitLab                                                                                                                                                                                                      
|_Requested resource was http://ready.htb:5080/users/sign_in                                                                                                                                                                               
|_http-trane-info: Problem with XML parsing of /evox/about                                                                                                                     
 

