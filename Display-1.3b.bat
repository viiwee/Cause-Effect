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
set Ver=1.3b
set cfg=Config\pref.cfg
set BaseLoc=H:\HHSTeachers\JSALWAY\Period 4\
if not exist "C:\users\%username%\temp" md "C:\users\%username%\temp"
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
choice /c 0tp /t 1 /d 0 >nul
If %errorlevel%== 1 goto Display
If %errorlevel%== 2 (
set Loc=Testing 5\
Title Testing Mode
)
if %errorlevel%== 3 goto p
:Display
goto RoomChange
:Type
cls
Echo (To change rooms press R on the keyboard)
findstr /i "$%room%" %Disp%
findstr /i "$Broadcast" %Disp%
choice /c rty /t 2 /d y >nul
if %errorlevel%== 1 goto d
if %errorlevel%== 3 goto Type
if %errorlevel%== 2 goto Top
cls
goto Type
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
:RoomChange
:RoomTop
Set RoomTimeOut=1
Set RoomNum=
Set RoomSearchRoomNum=
set RoomCounter=1
Set TimeOutNum=2
findstr /i "$room" %disp% > "C:\users\%username%\temp\rooms.txt"
for /f %%x in (C:\users\%username%\temp\rooms.txt) do (
  set "R!RoomCounter!=%%x"
  set /a RoomCounter+=1
)
del /q "C:\users\%username%\temp\rooms.txt"
:RoomSearch1
cls
set RoomLast=
set RoomLineU=
Echo What name room do you want to join?
Echo (Default room=1)
findstr /i "$room" %disp% > "C:\users\%username%\temp\rooms.txt"
Echo.
Echo ########
sort "C:\users\%username%\temp\rooms.txt"
Echo ########
echo.
Echo (EX: To join 1:$room Default you would type 1)
set room=
set /p room=Enter Room Name: 
if "%room%"=="" (
Echo Please enter a room name.
pause
cls
goto RoomSearch1
)
set RoomSearch=%Room%
goto RoomSearch
:RoomCont
if "%RF%"=="1" goto Type
cls
Echo This room does not exist!
Echo Please join an existing room. Or create one in Cause, only Mods/Admins can create them.
ping localhost -n 4 >nul
cls
goto RoomTop
:RoomSearch
set RoomLast=%RoomLineU%
Set /a RoomNum=%RoomNum%+1
Set RoomLine=!R%RoomNum%!
Set RoomLineU=
Set RoomLine >Nul
if "%RoomLine%"=="a=A" set /a RoomTimeOut=%RoomTimeOut%+1
:RoomAlgorithm
FOR /F "tokens=1-6 delims=:" %%I IN ("%RoomLine%") DO (
      set I=%%I
)
Set RoomLineU=%I%
goto RoomNext
:RoomNext
call :Uppercase RoomSearch
call :Uppercase RoomLineU
if "%RoomSearch%"=="%RoomLineU%" goto RoomExist
if "%RoomLast%"=="%RoomLineU%" goto RoomCont
goto RoomSearch
:RoomExist
set RF=1
goto RoomPTop
:RoomPTop
set RoomPSearch=%Room%
Set RoomPTimeOut=1
Set RoomPNum=
set RoomPLineU=
set RoomPLast=
set RoomPCounter=1
Set TimeOutNum=2
findstr /i "$RP" %disp% > "C:\users\%username%\temp\RoomPs.txt"
for /f %%x in (C:\users\%username%\temp\RoomPs.txt) do (
  set "RP!RoomPCounter!=%%x"
  set /a RoomPCounter+=1
)
del /q "C:\users\%username%\temp\RoomPs.txt"
:RoomPSearch
set RoomPLast=%RoomPLineU%
Set /a RoomPNum=%RoomPNum%+1
Set RoomPLine=!RP%RoomPNum%!
Set RoomPLineU=
Set RoomPLine >Nul
:RoomPAlgorithm
if not defined RoomPLine set RoomPLine=Empty
FOR /F "tokens=1-6 delims=:" %%I IN ("%RoomPLine%") DO (
      set I=%%I
	  set J=%%J
)
Set RoomPLineU=%I%
goto RoomPNext
:RoomPNext
call :Uppercase RoomPSearch
call :Uppercase RoomPLineU
if "%RoomPSearch%"=="%RoomPLineU%" goto RoomPExist
if "%RoomPLast%"=="%RoomPLineU%" goto Type
goto RoomPSearch
:RoomPExist
set CPTR=3
cls
:RoomPTry
Echo This room has a password. If you do not know it just hit enter.
set CP=
set /p CP=
if "%Cp%"=="" goto RoomChange
call :Uppercase CP
call :Uppercase J
if "%CP%"=="%J%" goto RoomCPass
if %CPTR% GEQ 2 set tries=tries
if %CPTR%== 1 set tries=try
if %CPTR%== 0 set tries=tries
cls
Echo Incorrect password! %CPTR% %tries% left.
if %CPTR%== 0 goto RoomPStop
set /a CPTR=%CPTR%-1
goto RoomPTry
:RoomCPass
cls
Echo Correct password!
Echo Joining...
ping localhost -n 1 >nul
goto Type
:RoomPStop
Echo You have entered the wrong password too many times.
set /a RoomAS= %RoomPStop%/2
echo Waiting %RoomAS% seconds.
if not defined RoomPStop set RoomPStop=10
ping localhost -n %RoomPStop% >nul
set /a RoomPStop=%RoomPStop%*2
cls
goto RoomPTry
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
