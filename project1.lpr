{
¬ ¬ ¬ ¬
Project : AD Fly Version 1.0
By    : Lawrence Amer @zux0x3a
Site :  0xsp.com

                    GNU GENERAL PUBLIC LICENSE
                     Version 3, 29 June 2007

Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
Everyone is permitted to copy and distribute verbatim copies
of this license document, but changing it is not allowed.


}


program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils,strutils,CustApp,lDapSend;

type
  // Some Helper Types


  TMyApplication = class(TCustomApplication)
  protected
    procedure DoRun; override;
    procedure help;virtual;
  public
  end;

{ TMyApplication }
function LDAPQuery(cmd:string;attr:string):string;
var
  fldap:tldapsend;
  fad_domain,ausername,apassword,adc,fdc:string;
  i:integer;
  l,outa:Tstringlist;
begin
for i :=1 to paramcount do begin

 if (paramstr(i)='-u') then begin
   ausername:=paramstr(i+1);

end;
 if (paramstr(i)='-p') then begin
  apassword:=paramstr(i+1);
 end;
 if (paramstr(i)='-i') then begin
  fad_domain :=paramstr(i+1);
  end;
 if (paramstr(i)='-d') then begin
  adc := paramstr(i+1);
  end;
 if (paramstr(i)='-c') then begin
  cmd := paramstr(i+1);
  end;


end;
l := Tstringlist.Create;
outa := Tstringlist.Create;

fldap := TLDAPSend.Create;
fldap.TargetHost:=fad_domain;
fdc := stringReplace(adc,'.',',dc=',[rfReplaceAll, rfIgnoreCase]);
fldap.UserName:=ausername;
fldap.Password := apassword;
try
   try
      if fldap.Login then
         if fldap.Bind then
            begin
          writeln('[+] Successfull Login , User '+ausername+' is authenticated  !!'); // msg for successfull login .
           l.Add('distinguishedName');
           l.Add('dnsHostName');
           l.Add('subtree');
          fldap.Search('dc='+fdc,False,cmd,l);
          outa.Add(LDAPResultdump(fldap.SearchResult));
          writeln(outa.text);

            end else
                raise exception.Create('[!] LDAP bind failed..Username/Password maybe incorrect or LDAP is not responding');
   except
         on e:exception do
            writeln(e.Message);
   end;
finally
       fldap.logout;
       l.free;
       outa.free;
       freeandnil(fldap);
end;
end;
procedure listofdc;
var
  c:string;
begin
c:='(&(objectCategory=computer)(userAccountControl:1.2.840.113556.1.4.803:=8192))';
LDAPQuery(c,'');
end;

procedure QueryGroupsMember;
var
  fldap:tldapsend;
  fad_domain,ausername,apassword,adc,fdc,g:string;
  i:integer;
  l,outa:Tstringlist;
  begin
  for i :=1 to paramcount do begin

   if (paramstr(i)='-u') then begin
     ausername:=paramstr(i+1);

  end;
   if (paramstr(i)='-p') then begin
    apassword:=paramstr(i+1);
   end;
   if (paramstr(i)='-i') then begin
    fad_domain :=paramstr(i+1);
    end;
   if (paramstr(i)='-d') then begin
    adc := paramstr(i+1);
    end;
   if (paramstr(i)='-g') then begin
    g := paramstr(i+1);
    end;


  end;
l := Tstringlist.Create;
outa := Tstringlist.Create;

fldap := TLDAPSend.Create;
fldap.TargetHost:=fad_domain;
fdc := stringReplace(adc,'.',',dc=',[rfReplaceAll, rfIgnoreCase]);
fldap.UserName:=ausername;
fldap.Password := apassword;
try
   try
      if fldap.Login then
         if fldap.Bind then
            begin

            writeln(' ====================================== ');

          writeln('[+] Successfull Login , User '+ausername+' is authenticated  !!');
          writeln('[+] you are Querying List of members of '+g+' on '+fdc);
          l.Add('member');
          l.add('memberUid');
          l.add('uniqueMembers');
          fldap.Search('dc='+fdc,False,'(&(objectclass=*)(cn='+g+'))', l);
          outa.Add(LDAPResultdump(fldap.SearchResult));

            writeln(outa.text);

            end else
                raise exception.Create('[!] LDAP bind failed..Username/Password maybe incorrect or LDAP is not responding');
   except
         on e:exception do
            writeln(e.Message);
   end;
finally
       fldap.logout;
       l.free;
       outa.free;
       freeandnil(fldap);
end;

  end;

procedure authentication;
var
    fldap:tldapsend;
    fad_domain,ausername,apassword,adc,fdc,tuser:string;
    l,outa : Tstringlist;
    i:integer;
begin
  for i :=1 to paramcount do begin

   if (paramstr(i)='-u') then begin
     ausername:=paramstr(i+1);

  end;
   if (paramstr(i)='-p') then begin
    apassword:=paramstr(i+1);
   end;
   if (paramstr(i)='-i') then begin
    fad_domain :=paramstr(i+1);
    end;
   if (paramstr(i)='-d') then begin
    adc := paramstr(i+1);
    end;
   if (paramstr(i)='-t') then begin
    tuser := paramstr(i+1);
    end;


  end;
l := Tstringlist.Create;
outa := Tstringlist.Create;

fldap := TLDAPSend.Create;
fldap.TargetHost:=fad_domain;
fdc := stringReplace(adc,'.',',dc=',[rfReplaceAll, rfIgnoreCase]);
fldap.UserName:=ausername;
fldap.Password := apassword;
try
   try
      if fldap.Login then
         if fldap.Bind then
            begin

            writeln(' ====================================== ');

            writeln('[+] Successfull Login , User '+ausername+' is authenticated  !!');
            writeln('[+] you are Querying '+tuser+' on '+fdc);
            l.Add('memberof');
            fldap.Search('dc='+fdc+'',False,'(&(objectclass=user)(sAMAccountName='+tuser+'))', l);
            outa.Add(LDAPResultdump(fldap.SearchResult));
            writeln(outa.text);

            end else
                raise exception.Create('[!] LDAP bind failed..Username/Password maybe incorrect or LDAP is not responding');
   except
         on e:exception do
            writeln(e.Message);
   end;
finally
       fldap.logout;
       l.free;
       outa.free;
       freeandnil(fldap);
end;
end;


procedure TMyApplication.help;
var
msg:string;
begin
writeln(' ');
writeln('-u ','--User Name to Authenticate with..');
writeln('-p ','--Password of user .');
writeln('-i ','--LDAP Target Host Address.');
writeln('-d ','--Active Directory name to use example :0xsp.com');
writeln('-t ','--Name of targeted user to check for.');
writeln('-g ','--List members names of selected group .');
writeln('-c ','--List All Domain Controllers  .');


end;

procedure TMyApplication.DoRun;
var
  author,msg: String;
  i:integer;
begin

msg:= '____ <==> ____ '#10 +
      '\___\(**)/___/ '#10 +
      '\___ |  |___/   '#10 +
      '     $  $       '#10 +
      '     |__|      '#10 +
      '     *  *      '   ;


author:='[+] AD Fly v1.0 '#10 +
        '[+] by Lawrence Amer (@zux0x3a, https://0xsp.com) ' ;
writeln(msg);
writeln(author);

for i :=1 to paramcount do begin

 if (paramstr(i)='-t') then begin
authentication;

 end;
 if (paramstr(i)='-g') then begin
 QueryGroupsMember;
 end;
 if (paramstr(i)='-h') then begin
  help;
 end;
 if (paramstr(i)='-c') then begin
 listofdc;
 end;

  end;

 terminate;
end;

var
  Application: TMyApplication;

{$R *.res}

begin
  Application:=TMyApplication.Create(nil);
  Application.Title:='ADC';
  Application.Run;
  Application.Free;
end.

