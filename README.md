# adfly
![](g)
[<img src="https://raw.githubusercontent.com/lawrenceamer/adfly/master/logo.png" height="256" width="256">]()

active directory query tool using  LDAP Protocol , helps red teamer / penetration testers to validate users credentials , retrieve information about AD users , AD groups 

AD fly is Tool uses LDAP Protocol for users authentication access and queries of information ,since AD fly uses LDAP for connectivity,it only requires valid account to authenticate with , it is not required to be part of AD to use AD fly . from attacker machine red teamer is able to reach Active Directory with LDAP and retrieve information needed for operation .
the version number 1.0 comes with following modules .
Query User Group Membership
List Group Members
List All Domain Controllers
```
____ <==> ____ 
\___\(**)/___/ 
\___ |  |___/   
     $  $       
     |__|      
     *  *      
[+] AD Fly 
[+] by @zux0x3a, https://0xsp.com 
 
-u --User Name to Authenticate with..
-p --Password of user .
-i --LDAP Target Host Address.
-d --Active Directory name to use example :0xsp.com
-t --Name of targeted user to check for.
-g --List members names of selected group .
-c -- List All Domain Controllers 
```
