@echo off
setlocal enabledelayedexpansion
Color F0
Title 
Set FT=.bat
Set Txt1=.wmv
set Txt=%Txt1%
Set Txt2=.png
Set IDFile=.mp4
set Ver=1.1
choice /c t0 /t 1 /d 0 >nul
if %errorlevel%== 1 goto Testmode1
if %errorlevel%== 2 goto Non-Test
Echo MAJOR ERROR IN PROGRAM. REPORT IMMEDIATELY.
Pause
exit
:Non-Test
CD /d "H:\HHSTeachers\#REMOVED#RPURSLEY\PERIOD 6\New folder\New folder\New folder\"
If not exist "H:\" goto NoInternet
goto Top1
:NoInternet
cls
Echo Make sure you are connected to the Sacs internet.
Echo Exiting in 4 seconds.
choice /c t0 /t 4 /d 0 >nul
if %errorlevel%== 1 goto Testmode1
if %errorlevel%== 2 exit
exit
:Testmode1
Echo Entering Testing mode.
if not exist Testing 5\ md Testing 5
CD "Testing 5\"
goto Top1
:VersionSearch
set Username1=Ver
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
set Username1=%username%
call :Trans1 Username1
Set IDCheckSearch=%Username1%
goto IDCheckSearch

:IDCheckSearch
cls
Set /a IDCheckNum=%IDCheckNum%+1
Set /a IDCheckSearchIDCheckNum=%IDCheckSearchIDCheckNum%+1
Set IDCheckLine=!L%IDCheckNum%!
Set IDCheckLine >Nul
if "%IDCheckLine%"=="a=A" set /a IDCheckTimeOut=%IDCheckTimeOut%+1
:IDCheckAlgorithm
   for /F "tokens=1*delims==" %%a in ("%IDCheckLine%") do (
      set %%a
      set Var=%%b
      set IDCheckLine=%%a
   )
if defined IDCheckLine goto IDCheckLineDef >Nul
if defined Var goto VarDef >Nul
goto IDCheckNext
:IDCheckLineDef
if defined Var goto IDCheckNext
goto IDCheckAlgorithm
:VarDef
if defined IDCheckLine goto IDCheckNext
goto IDCheckAlgorithm
:IDCheckNext
call :Uppercase IDCheckSearch
call :Uppercase IDCheckLine
if "%IDCheckSearch%"=="%IDCheckLine%" Goto IDCheckFound
if %IDCheckSearchIDCheckNum%== %TimeOutNum% goto IDCheckCant
goto IDCheckSearch
:IDCheckFound
if "%VerSearch%"=="1" goto VerSearchDone
Set User=%var%
Echo Username found in registry with nickname: %User%
goto VersionSearch
:VerSearchDone
set NewVar=%var%
If "%Ver%"=="%NewVar%" Goto yes
cls
Echo New update found, Downloading.
goto UpdateDownload
:IDCheckSearchAlt
pause
set %IDCheckSearchAlt%=0
goto Top1
:Yes
set VerSearch=0
cls
Echo Hello %User%
if "%IDCheckSearchAlt%"== "1" goto IDCheckSearchAlt
:Top
set input=
set /p input=
If "%input%"== "/" goto Com
echo %User%: %time%: %input% >> %txt%
goto top
:Com
Echo Clear=Clear Document
Echo Add=Add a User to the list.
Echo Rem=Remove a User form the list.
Echo Lookup= Look up Ban status, User ID, and username of a user.
Echo Users= Look at the list of all users
Echo Test= Go into testing mode.
Echo Trans= Go to trans testing (Useless unless developer)
Echo Normal= Go into normal mode.
Echo RC= Change rooms.
Echo N=Change name
Echo V=Set New Version(Developer Only)
Echo E=Exit
Set input=
Set /p input=
call :Uppercase input
if %input%== RC goto RC
If %input%== ADD goto AddUser
If %input%== REM goto RemUser
If %input%== CLEAR goto Clear
If %input%== LOOKUP goto Lookup
If %input%== TEST goto Testing
If %input%== NORMAL goto Normal
if %input%== USERS goto AllUsers
If %input%== E goto Top
if %input%== N goto NameChange
If %input%== CMD goto CMD
If %input%== TRANS goto TransTest
If %input%== V goto NewVer
Echo Wrong input.
pause
goto Com
:NewVer
Echo Current version: %NewVer%
Echo What is the new version?
set input=
set /p input=
findstr /i /v "%NewVar%" %IDFile% > "C:\users\%username%\desktop\temp.txt"
type "C:\users\%username%\desktop\temp.txt" > %IDFile%
del "C:\users\%username%\desktop\temp.txt"
type Ver=%input% >>%IDFile%
pause
goto Yes
:TransTest
set input=
set /p input=
set input2=%input%
if "%input%"=="Back" goto Yes
call :Trans1 input
Echo Trans: %input%
call :DeTrans input
echo DeTrans: %input%
if not "%input%"=="%input2%" Echo NOPE.
if "%input%"=="%input2%" echo YUP.
goto TransTest
:NameChange
echo New name?
set input=
set /p input=
set User=%input%
echo Done
pause
goto yes
:AllUsers
Echo User list
type .mp4
Echo Cacls lists:
Echo IDs:
Icacls .mp4
Echo Norm:
Icacls .wmv
Echo Prog:
Icacls .png
pause
goto Yes
:RC
Echo 1=Norm
Echo 2=Program
set input=
set /p input=
call :Uppercase input
if %input%== 1 set txt=%Txt1%
if %input%== 2 set txt=%Txt2%
Echo Room switched!
goto Yes
:AddUser
Echo Type the ID of the user you want to add.
Set UID=
set /p UID=
:AddUser2
Echo Normal or Programming room?(N,P)
set input=
set /p input=
call :Uppercase input
if %input%== N goto AddUserN
if %input%== P goto AddUserP
cls
Echo Wrong input
goto AddUser2
:AddUserP
Icacls %IDFile% /Grant %UID%:(R)
Icacls %Txt2% /Grant %UID%:(R,W)
Icacls %Txt1% /grant %UID%:(R,W)
:IsUserInID
Echo is user already in IDFile? (Y,N)
set input=
set /p input=
call :Uppercase Input
if %input%== Y goto AddDone
if %input%== N goto AddName
Echo wrong input
goto IsUserInID
goto AddName
:AddUserN
Icacls %IDFile% /grant %UID%:(R)
Icacls %Txt1% /grant %UID%:(R,W)
goto AddName
:AddDone
Echo User added!
pause
goto Yes
:AddName
Echo What do you want their nickname to be?
set UIDN=
set /p UIDN=
call :Trans1 UID
echo %UID%=%UIDN%>>%IDFile%
sort "%IDFile%"
goto AddDone
:RemUser
Echo What user would you like to remove?
Set RemUser=
Set /p RemUser=
:RemUserStart
Set RemUserTimeOut=1
Set RemUserNum=
Set RemUserSearchRemUserNum=
set RemUserCounter=1
Set TimeOutNum=100
for /f %%x in (%IDFile%) do (
  set "L!RemUserCounter!=%%x"
  set /a RemUserCounter+=1
)
:RemUserNext
Set RemUserSearch=%RemUser%
call :Uppercase RemUserSearch
:RemUserSearch
cls
Set /a RemUserNum=%RemUserNum%+1
Set /a RemUserSearchRemUserNum=%RemUserSearchRemUserNum%+1
Set RemUserLine=!L%RemUserNum%!
Set RemUserLine >Nul
if "%RemUserLine%"=="a=A" set /a RemUserTimeOut=%RemUserTimeOut%+1
:RemUserAlgorithm
   for /F "tokens=1*delims==" %%a in ("%RemUserLine%") do (
      set %%a
      set RemUserVar=%%b
      set RemUserLine=%%a
   )
if defined RemUserLine goto RemUserLineDef >Nul
if defined RemUserVar goto RemUserVarDef >Nul
goto RemUserNext
:RemUserLineDef
if defined RemUserVar goto RemUserNext
goto RemUserAlgorithm
:RemUserVarDef
if defined RemUserLine goto RemUserNext
goto RemUserAlgorithm
:RemUserNext
call :Uppercase RemUserSearch
call :Uppercase RemUserVar
if "%RemUserSearch%"=="%RemUserVar%" Goto RemUserFound
if %RemUserSearchRemUserNum%== %TimeOutNum% goto RemUserCant
goto RemUserSearch
:RemUserCant
Echo Cant find the user specified.
goto yes
:RemUserFound
set UID=%RemUserLine%
Icacls %IDFile% /deny %UID%:(R)
Icacls %Txt2% /deny %UID%:(R,W)
Icacls %Txt1% /deny %UID%:(R,W)
Echo User removed: %remuservar%
findstr /i /v "%RemUserVar%" %IDFile% > "C:\users\%username%\desktop\temp.txt"
type "C:\users\%username%\desktop\temp.txt" > %IDFile%
del "C:\users\%username%\desktop\temp.txt"
pause
goto yes
:Normal
If not exist H:\ goto NoInternetNorm
CD "H:\HHSTeachers\#REMOVED#RPURSLEY\PERIOD 5\"
Echo Switched to Normal mode.
goto top
:NoInternetNorm
Echo Make sure you are connected to sacs internet, and that your H drive is connected.
Echo Going back to testing mode
CD "Testing 5\"
goto Top
:Testing
set Loc=Testing\
Echo Entering Testing mode.
if not exist Testing\ md Testing
goto Top
:Ban
setlocal enabledelayedexpansion
Echo Who would you like to ban(Username)?
cacls "%Loc%%Txt1%"
Set ban=
Set /p ban=
Echo For what reason is this?
set Reason=
set /p Reason=
Set Reason >Nul
call :Uppercase Reason
goto IDFind
:BanContinue
echo %Ban%=%Reason%>>"%Loc%%BanFile%"
cacls "%Loc%%Ban%.txt" /E /g 73001490@sacs.k12.in.us:F
cacls "%Loc%%Ban%.txt" /E /g %Ban%@sacs.k12.in.us:R
Echo Banned %Ban% 
Echo For the reason of: %Reason%
pause
cls
goto Com
:IDFind
Set IDTimeOut=1
Set IDNum=
Set IDSearchIDNum=
set IDCounter=1
Set TimeOutNum=30
for /f %%x in (%Loc%%IDFile%) do (
  set "L!IDCounter!=%%x"
  set /a IDCounter+=1
)
:IDNext
cls
Set IDSearch=%Ban%
call : IDSearch
:IDSearch
cls
Set /a IDNum=%IDNum%+1
Set /a IDSearchIDNum=%IDSearchIDNum%+1
Set FinderLine=!L%IDNum%!
Set FinderLine >Nul
call :Uppercase FinderLine
if "%FinderLine%"=="a=A" set /a IDTimeOut=%IDTimeOut%+1
if %IDTimeOut% GEQ 21 goto IDCant
:IDAlgorithm
   for /F "tokens=1*delims==" %%a in ("%FinderLine%") do (
      set %%a
      set Var=%%b
      set FinderLine=%%a
   )
if defined FinderLine goto FinderLineDef >Nul
if defined Var goto VarDef >Nul
goto IDNext
:FinderLineDef
if defined Var goto IDNext
goto IDAlgorithm
:VarDef
if defined FinderLine goto IDNext
goto IDAlgorithm
:IDNext
call :Uppercase IDSearch
if "%IDSearch%"=="%FinderLine%" Goto IDFound
if %IDSearchIDNum%== %TimeOutNum% goto IDCant
goto IDSearch
:IDFound
cls
Echo Found user ID: %IDSearch%
Echo Line: %IDNum%
Echo %FinderLine%'s I.D. is: %Var%
pause
Goto BanContinue
:IDCant
cls
Echo Cannot Find the user, maybe the capitols are wrong?
pause
Goto Com
:UnBan
Echo Who would you like to unban.
set UnBan=
set /p UnBan=
Del "H:\WMSTeachers\#REMOVED#fflinstone\RED\PERIOD 4\%UnBan%.txt"
Echo Unbanned.
pause
goto Com
:Banned
Echo You are unable to use this program.
Echo Reason:
Type "H:\WMSTeachers\#REMOVED#fflinstone\RED\PERIOD 4\%Username%.txt"
pause
Exit
:Clear
type nul > "%txt%"
goto Top
:CMD
set input=
set /p input=
%input%
goto CMD
:Lookup
setlocal enabledelayedexpansion
:FinderTop
Set FinderTimeOut=1
Set FinderNum=
Set FinderSearchFinderNum=
set FinderCounter=1
Set TimeOutNum=1000
for /f %%x in (%Loc%%BanFile%) do (
  set "L!FinderCounter!=%%x"
  set /a FinderCounter+=1
)
:FinderNext
cls
Echo What are you looking for?
Set FinderSearch=
Set /p FinderSearch=
Set FinderSearch >Nul
call :Uppercase FinderSearch
:FinderSearch
cls
setlocal enabledelayedexpansion
Set /a FinderNum=%FinderNum%+1
Set /a FinderSearchFinderNum=%FinderSearchFinderNum%+1
Set FinderLine=!L%FinderNum%!
Set FinderLine >Nul
call :Uppercase FinderLine
if "%FinderLine%"=="a=A" set /a FinderTimeOut=%FinderTimeOut%+1
if %FinderTimeOut% GEQ 21 goto FinderCant
:FinderAlgorithm
   for /F "tokens=1* delims==" %%a in ("%FinderLine%") do (
      set %%a
      set Var=%%b
      set FinderLine=%%a
   )
if defined FinderLine goto FinderLineDef >Nul
if defined Var goto VarDef >Nul
goto FinderNext
:FinderLineDef
if defined Var goto FinderNext
:VarDef
if defined FinderLine goto FinderNext
goto FinderAlgorithm
:FinderNext
if "%FinderSearch%"== "%FinderLine%" Goto FinderFound
if %FinderSearchFinderNum%== %TimeOutNum% goto FinderCant
goto FinderSearch
:FinderFound
cls
Echo Found the text: %FinderSearch%
Echo Line: %FinderNum%
Echo %FinderLine% is banned for: %Var%
Pause
Goto Com
:FinderCant
cls
Echo Cannot Find the text.
pause
Goto Com
:UpdateDownload
set temp=%~dp0
if exist "%temp%temp.txt" goto NoUpdate
copy "Updates\Cause-%NewVar%%FT%" "%temp%Cause-%newvar%%FT%"
ping localhost -n 1 >nul
echo start "" "%temp%Cause-%NewVar%%FT%">"%temp%temp.bat"
echo ping localhost -n 1 >nul
echo del temp.bat >>"%temp%temp.bat"
echo exit >>"%temp%temp.bat"
echo 1>"%temp%temp.txt"
pause
start "" "%temp%temp.bat"
del "%~f0"
exit
:NoUpdate
del "%temp%temp.txt"
goto Top1
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