@echo off
:Top
SetLocal EnableDelayedExpansion
color 8F
Title 
set FT=.bat
set IDCheckNum=0
set CIDCheckNum=0
set Disp=.wmv
set IDFile=.mp4
set Ver=1.1a
set cfg=Config\pref.cfg
cd /d "H:\HHSTeachers\#REMOVED#CPRATER\PERIOD 3\"
set BaseLoc=H:\HHSTeachers\-member-\Period 4\
:LocCheck
cd /d "%BaseLoc%"
set BaseLocN=1
for /f %%x in (.loc) do (
  set BaseLoc_!BaseLocN!=%%x
  set /a BaseLocN+=1
)
call :SpaceFix BaseLoc_1
CD /d "%BaseLoc_1%"
:VerCheck
set VerC=1
for /f %%x in (%IDFile%) do (
  set "L!VerC!=%%x"
  set /a VerC+=1
)
goto VersionSearch
:VersionSearch
set Username1=DVer
set VerSearch=1
Set IDCheckTimeOut=1
Set IDCheckNum=
Set IDCheckSearchIDCheckNum=
set IDCheckCounter=1
Set TimeOutNum=100
Set IDCheckSearch=%Username1%
for /f %%x in (%IDFile%) do (
  set "L!IDCheckCounter!=%%x"
  set /a IDCheckCounter+=1
)
goto IDCheckSearch
:Top1
Set IDCheckTimeOut=1
Set IDCheckNum=
Set IDCheckSearchIDCheckNum=
set IDCheckCounter=1
Set TimeOutNum=100
for /f %%x in (%IDFile%) do (
  set "L!IDCheckCounter!=%%x"
  set /a IDCheckCounter+=1
)
:IDCheckNext
echo IDCheckNext
set Username1=%username%
call :Trans1 Username1
Set IDCheckSearch=%Username1%
goto IDCheckSearch
:IDCheckSearch
cls
Set /a IDCheckNum=%IDCheckNum%+1
Set /a IDCheckSearchIDCheckNum=%IDCheckSearchIDCheckNum%+1
Set IDCheckLine=!L%IDCheckNum%!
Set IDCheckLineU=
Set IDCheckLine >Nul
if "%IDCheckLine%"=="a=A" set /a IDCheckTimeOut=%IDCheckTimeOut%+1
:IDCheckAlgorithm
FOR /F "tokens=1-6 delims==," %%I IN ("%IDCheckLine%") DO (
      set I=%%I
	  Set J=%%J
	  Set K=%%K
	  Set L=%%L
	  Set M=%%M
	  Set N=%%N
)
if %I%==DVer set DVer=%J%
Set CurColor=%N%
set Var=%J%
Set IDCheckLineU=%I%
if defined IDCheckLineU goto IDCheckLineDef >Nul
if defined Var goto VarDef >Nul
goto IDCheckNext
:IDCheckLineDef
if defined Var goto IDCheckNext
goto IDCheckAlgorithm
:VarDef
if defined IDCheckLineU goto IDCheckNext
goto IDCheckAlgorithm
:IDCheckNext
call :Uppercase IDCheckSearch
call :Uppercase IDCheckLineU
if "%IDCheckSearch%"=="%IDCheckLineU%" Goto IDCheckFound
if %IDCheckSearchIDCheckNum%== %TimeOutNum% goto IDCheckCant
goto IDCheckSearch
:IDCheckFound
if "%VerSearch%"=="1" goto VerSearchDone
Set User=%J%
Set Perms=%L%
goto Display1
:VerSearchDone
set NewVar=%var%
set VerSearch=0
If "%Ver%"=="%NewVar%" Goto Top1
goto UpdateDownload
:Display1
:ConfigTop
Set ConfigTimeOut=1
Set ConfigNum=
Set ConfigSearchConfigNum=
set ConfigCounter=1
Set TimeOutNum=2
for /f %%x in (%cfg%) do (
  set "C!ConfigCounter!=%%x"
  set /a ConfigCounter+=1
)
:ConfigNext
set Username1=%User%
Set ConfigSearch=%Username1%
goto ConfigSearch
:ConfigSearch
set ConfigLast=%ConfigLineU%
Set /a ConfigNum=%ConfigNum%+1
Set ConfigLine=!C%ConfigNum%!
Set ConfigLineU=
Set ConfigLine >Nul
if "%ConfigLine%"=="a=A" set /a ConfigTimeOut=%ConfigTimeOut%+1
:ConfigAlgorithm
FOR /F "tokens=1-6 delims==," %%I IN ("%ConfigLine%") DO (
      set I=%%I
	  Set J=%%J
	  Set K=%%K
)
Set ConfigLineU=%I%
goto ConfigNext
:ConfigNext
call :Uppercase ConfigSearch
call :Uppercase ConfigLineU
if "%ConfigSearch%"=="%ConfigLineU%" Goto ConfigFound
if "%ConfigLast%"=="%ConfigLineU%" goto Display
goto ConfigSearch
:ConfigFound
color %K%
choice /c 0tp /t 3 /d 0 >nul
If %errorlevel%== 1 goto Display
If %errorlevel%== 2 set Loc=Testing 5\
if %errorlevel%== 3 goto p
:Display
:Type
cls
type %Disp%
choice /c 123r /t 1 /d 3 >nul
if %errorlevel%== 1 goto d
if %errorlevel%== 2 goto p2
if %errorlevel%== 3 goto Type
if %errorlevel%== 4 goto Top
cls
goto Type
:p
cls
set Disp=.png
choice /c t0 /t 3 /d 0 >nul
if %errorlevel%== 1 CD /d Testing 5\
if %errorlevel%== 2 goto Display
goto Display
:p2
cls
set Disp=.png
goto Display
:d
cls
set Disp=.wmv
goto Display
:UpdateDownload
set temp=%~dp0
set NewVar=%var%
if exist "%temp%temp.txt" goto NoUpdate
copy "Updates\Display-%NewVar%%FT%" "%temp%Display-%newvar%%FT%"
ping localhost -n 1 >nul
echo start "" "%temp%Display-%NewVar%%FT%">"%temp%temp.bat"
echo ping localhost -n 1 >nul
echo del temp.bat >>"%temp%temp.bat"
echo exit >>"%temp%temp.bat"
start "" "%temp%temp.bat"
del "%~f0"
exit
:NoUpdate
del "%temp%temp.txt"
start "" "%~f0"
exit
goto Top1
:Detrans
set %~1=!%1:"-["=a!
set %~1=!%1:"][-"=b!
set %~1=!%1:"[]-"=c!
set %~1=!%1:"\]"=d!
set %~1=!%1:"]\"=e!
set %~1=!%1:"[\"=f!
set %~1=!%1:"\["=g!
set %~1=!%1:"']"=h!
set %~1=!%1:"'["=i!
set %~1=!%1:"'\"=j!
set %~1=!%1:"-"=k!
set %~1=!%1:"["=l!
set %~1=!%1:"]"=m!
set %~1=!%1:";"=n!
set %~1=!%1:"'"=o!
set %~1=!%1:","=p!
set %~1=!%1:"."=q!
set %~1=!%1:"/"=r!
set %~1=!%1:"`"=s!
set %~1=!%1:"#"=t!
set %~1=!%1:"$"=u!
set %~1=!%1:";["=v!
set %~1=!%1:";]"=w!
set %~1=!%1:";\"=x!
set %~1=!%1:"[;"=y!
set %~1=!%1:"];"=z!
set %~1=!%1:"kso"=1!
set %~1=!%1:"rft"=2!
set %~1=!%1:"uhb"=3!
set %~1=!%1:"iuk"=4!
set %~1=!%1:"gxj"=5!
set %~1=!%1:"pke"=6!
set %~1=!%1:"tcw"=7!
set %~1=!%1:"pyn"=8!
set %~1=!%1:"yup"=9!
set %~1=!%1:"put"=0!
set %~1=!%1:"lrn"= !
goto:eof
:Uppercase
set %~1=!%1:a=A!
set %~1=!%1:b=B!
set %~1=!%1:c=C!
set %~1=!%1:d=D!
set %~1=!%1:e=E!
set %~1=!%1:f=F!
set %~1=!%1:g=G!
set %~1=!%1:h=H!
set %~1=!%1:i=I!
set %~1=!%1:j=J!
set %~1=!%1:k=K!
set %~1=!%1:l=L!
set %~1=!%1:m=M!
set %~1=!%1:n=N!
set %~1=!%1:o=O!
set %~1=!%1:p=P!
set %~1=!%1:q=Q!
set %~1=!%1:r=R!
set %~1=!%1:s=S!
set %~1=!%1:t=T!
set %~1=!%1:u=U!
set %~1=!%1:v=V!
set %~1=!%1:w=W!
set %~1=!%1:x=X!
set %~1=!%1:y=Y!
set %~1=!%1:z=Z!
set %~1=!%1: =_!
goto:eof
:Trans1
set %~1=!%1:a="-["!
set %~1=!%1:b="][-"!
set %~1=!%1:c="[]-"!
set %~1=!%1:d="\]"!
set %~1=!%1:e="]\"!
set %~1=!%1:f="[\"!
set %~1=!%1:g="\["!
set %~1=!%1:h="']"!
set %~1=!%1:i="'["!
set %~1=!%1:j="'\"!
set %~1=!%1:k="-"!
set %~1=!%1:l="["!
set %~1=!%1:m="]"!
set %~1=!%1:n=";"!
set %~1=!%1:o="'"!
set %~1=!%1:p=","!
set %~1=!%1:q="."!
set %~1=!%1:r="/"!
set %~1=!%1:s="`"!
set %~1=!%1:t="#"!
set %~1=!%1:u="$"!
set %~1=!%1:v=";["!
set %~1=!%1:w=";]"!
set %~1=!%1:x=";\"!
set %~1=!%1:y="[;"!
set %~1=!%1:z="];"!
set %~1=!%1:1="kso"!
set %~1=!%1:2="rft"!
set %~1=!%1:3="uhb"!
set %~1=!%1:4="iuk"!
set %~1=!%1:5="gxj"!
set %~1=!%1:6="pke"!
set %~1=!%1:7="tcw"!
set %~1=!%1:8="pyn"!
set %~1=!%1:9="yup"!
set %~1=!%1:0="put"!
set %~1=!%1: ="lrn"!
goto:eof
:SpaceFix
set %~1=!%1:_= !
goto:eof
