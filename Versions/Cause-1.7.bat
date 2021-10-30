@echo off
:TopTop
setlocal enabledelayedexpansion
Color F0
Title 
set temp=%~dp0
del "%temp%temp.bat"
cls
Set FT=.bat
Set Txt1=.wmv
set Txt=%Txt1%
Set Txt2=.png
Set IDFile=.mp4
set Ver=1.7
set BaseLocF=.loc
set BaseLoc=H:\HHSTeachers\JSALWAY\Period 4\
Set aPerm=0
set CurColor=F0
set KickFile=Config\.cfg
set KickUser=0
set Cfg=Config\pref.cfg
set HS=config\hs.txt
set MSWait=10
set LTime=0
set LCMS=0
set SLCMS=0
set temp=C:\users\%username%\temp
choice /c t0 /t 1 /d 0 >nul
if %errorlevel%== 1 goto Testmode1
if %errorlevel%== 2 goto Non-Test
Echo MAJOR ERROR IN PROGRAM. REPORT IMMEDIATELY.
Pause
exit
:Non-Test
cd /d "%BaseLoc%"
set BaseLocN=1
for /f %%x in (.loc) do (
  set BaseLoc_!BaseLocN!=%%x
  set /a BaseLocN+=1
)
call :SpaceFix BaseLoc_1
CD /d "%BaseLoc_1%"
If not exist "H:\" goto NoInternet
goto VersionSearch
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
Title Testing Mode
if not exist Testing 5\ md Testing 5
CD "Testing 5\"
goto VersionSearch
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
)
if %I%==DVer set DVer=%J%
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
if defined M set Dev=1
if not defined M set Dev=0
echo %Dev%
Set User=%J%
Set Perms=%L%
Goto ConfigTop
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
if "%ConfigLast%"=="%ConfigLineU%" goto RoomChange
goto ConfigSearch
:ConfigFound
color %K%
goto RoomChange
:VerSearchDone
set NewVar=%var%
set VerSearch=0
If "%Ver%"=="%NewVar%" Goto Top1
goto UpdateDownload
:IDCheckSearchAlt
set %IDCheckSearchAlt%=0
goto Top1
:RoomChange
:RoomTop
Set RoomTimeOut=1
Set RoomNum=
Set RoomSearchRoomNum=
set RoomCounter=1
Set TimeOutNum=2
findstr /i "$room" %txt% > "%temp%\rooms.txt"
for /f %%x in (%temp%\rooms.txt) do (
  set "R!RoomCounter!=%%x"
  set /a RoomCounter+=1
)
del /q "%temp%\rooms.txt"
:RoomSearch1
cls
set RoomLast=
set RoomLineU=
Echo What name room do you want to join?
Echo (Default room=1)
findstr /i "$room" %txt% > "%temp%\rooms.txt"
Echo.
Echo ########
sort "%temp%\rooms.txt"
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
if "%RF%"=="1" goto yes
if "%perms%"=="Admin" goto RoomPassSet
if "%perms%"=="Mod" goto RoomPassSet
cls
Echo This room does not exist!
Echo Please join an existing room, or ask a Mod/Admin to create one for you.
ping localhost -n 4 >nul
cls
goto RoomTop
:RoomPassSet
Echo What is the description? Only a few words pelase.
set RD=
set /p RD=
Echo Would you like to set a password? {Y/N}
choice /c yn
if not %errorlevel%==1 (
Echo %Room%:$Room %RD% >> %txt%
echo Okay, no password set. Room created!
pause
goto Yes 
)
cls
Echo What would you like the password to be?
set RP=
set /p RP=Enter Password: 
Echo %Room%:$Room %RD% >> %txt%
Echo %Room%:%RP%:$RP >> %txt%
Echo Okay! Password Created!
pause
goto Yes
:Yes
set RF=0
cls
:Yes2
set VerSearch=0
Echo Hello %User%
Echo %input%
if "%IDCheckSearchAlt%"== "1" goto IDCheckSearchAlt
:Top
set input=
set /p input=
set I=
set KickID=
if "%input%"=="" (
Echo Blank text. Returning.
pause
cls
goto Yes2
)
Goto KickCheck
:KickTop
If "%input%"== "/" goto Com
FOR /F "tokens=1-3 delims=:" %%I IN ("%time%") DO (
      set ITime=%%I:%%J
	  set Hour=%%I
	  set Min=%%J
	  set Sec=%%K
)
set /a hr=%Hour%*3600
Set /a CMS=%Min%*60+%sec%+%hr%
cls
Set /a LTime=%CMS%-%LCMS%
set /a SLCMS=%SLCMS%+%LTime%
Set LCMS=%CMS%
if %SLCMS% GEQ 5 goto MSReset
set /a MSent=%MSent%+1
if %MSent% GEQ 3 goto SPTimeout
set ITime=%ITime: =%
set CurSF=%input%
echo %User%:$%Room%(%ITime%): %input% >> %txt%
cls
goto Yes2
:SPTimeout
set MSWaitC=%MSWait%
:MSWait
cls
Echo Yo dawg, Cool down those fingers.
if %MSWaitC% GEQ 2 Echo Please wait %MSWaitC% seconds
if %MSWaitC%==1 Echo Please wait %MSWaitC% second
set /a MSWaitC=%MSWaitC%-1
ping localhost -n 2 >nul
if %MSWaitC%==0 goto MSResetNoSend
goto MSWait
:MSReset
set SLCMS=0
set MSent=0
set LTime=0
set ITime=%ITime: =%
echo %User%:$%Room%(%ITime%): %input% >> %txt%
:MSResetCont
cls
goto Yes2
:MSResetNoSend
set SLCMS=0
set MSent=0
set LTime=0
cls
goto Yes2
:KickCheck
Set IDCheckTimeOut=1
Set IDCheckNum=
Set IDCheckSearchIDCheckNum=
set IDCheckCounter=1
Set TimeOutNum=3
Set L1= 
Set L2= 
Set KickSearch=%User%
for /f %%x in (%KickFile%) do (
  set "L!IDCheckCounter!=%%x"
  set /a IDCheckCounter+=1
)
goto KickSearch
:KickSearch
cls
Set /a IDCheckNum=%IDCheckNum%+1
Set /a IDCheckSearchIDCheckNum=%IDCheckSearchIDCheckNum%+1
Set IDCheckLine=!L%IDCheckNum%!
Set IDCheckLine >Nul
if "%IDCheckLine%"=="a=A" set /a IDCheckTimeOut=%IDCheckTimeOut%+1
:KickAlgorithm
FOR /F "tokens=1-4 delims==," %%I IN ("%IDCheckLine%") DO (
      set I=%%I
	  Set J=%%J
)
Set KickU=%J%
Set KickID=%I%
goto KickNext
:KickDef
if defined KickU goto KickNext
goto KickAlgorithm
:KickVarDef
if defined KickU goto KickNext
goto KickAlgorithm
:KickNext
call :Uppercase KickSearch
Set KickUL=%KickU%
call :Uppercase KickID
if "%KickSearch%"=="%KickID%" Goto KickFound
if "%IDCheckNum%"=="%TimeOutNum%" goto KickCant
goto KickSearch
:KickCant
goto KickTop
:KickFound
Echo You have been kicked from chat!
set KickTimer=20
:KickTimer
if %KickTimer%== 0 (
type nul > "%KickFile%"
goto KickTop )
set /a KickTimer= %KickTimer%-1
If %KickTimer%== 1 (
type nul > "%KickFile%"
Echo Please wait %KickTimer% second....
goto KickTimer2)
Echo Please wait %KickTimer% seconds...
:KickTimer2
ping localhost -n 2 >nul
cls
goto KickTimer
:Com
If %Perms%== Admin goto ACom
If %Perms%== User goto UCom
if %Perms%== Mod goto MCom
Echo Permissions error.
pause
Goto UCom
If %Perms%== User (
:UCom
Echo Clear=Clear Document
Echo RC= Change rooms
Echo Users= Look at the list of all users
Echo Per=Personalize the program
Echo K=Play the Knife Game
Echo E=Exit
Set input=
Set /p input=
call :Uppercase input
If %input%== CLEAR goto Clear
If %input%== LOOKUP goto Lookup
if %input%== USERS goto AllUsers
If %input%== E goto Yes
If %input%== CMD goto CMD
If %input%== RC goto RoomTop
if %input%== PER goto Personalization
if %input%== K goto KnifeGame
Echo Wrong input.
pause
goto UCom )
If %Perms%== Mod (
:MCom
Echo R=Room Options.
Echo Broad=Broadcast a message to all rooms.
Echo Clear=Clear Document
Echo Lookup= Look up User ID, and username of a user.
Echo Users= Look at the list of all users
Echo RC= Change rooms.
Echo Perms=Permissions Menu
Echo Per=Personalize the program
Echo K= Play the Knife Game
Echo E=Exit
Set input=
Set /p input=
call :Uppercase input
if %input%== BROAD goto Broadcast
if %input%== RC goto RoomTop
If %input%== CLEAR goto Clear
If %input%== LOOKUP goto Lookup
if %input%== USERS goto AllUsers
If %input%== E goto Yes
If %input%== CMD goto CMD
If %input%== PERMS goto PermsM
If %Input%== PER goto Personalization
if %input%== K goto KnifeGame
Echo Wrong input.
pause
goto MCom )
If %Perms%== Admin (
:ACom
Echo Back=Backup the system.
Echo R=Room Options
Echo Broad=Broadcast options
Echo Clear=Clear the room.
Echo Add=Add a User to the list.
Echo Rem=Remove a User from the list.
Echo Lookup= Look up User ID, and username of a user.
Echo Users= Look at the list of all users
Echo Rank=Change rank of a specified user.
Echo Perms=Permissions Menu
Echo Dev=Developer Commands, Devs only Please
Echo Per=Personalize the program
Echo Kick= Kick a specified User.
Echo K= Play the Knife Game
Echo E=Exit
set input=
set /p input=
call :Uppercase input
if %input%== DEV goto DevCom
if %input%== BACK goto Backup
if %input%== R goto RoomEdit
if %input%== BROAD goto BroadOpts
If %input%== ADD goto AddUser
If %input%== REM goto RemUser
If %input%== CLEAR goto Clear
If %input%== LOOKUP goto Lookup
if %input%== USERS goto AllUsers
If %input%== E goto Yes
If %input%== CMD goto CMD
If %input%== RANK goto RankChange
If %input%== PERMS goto PermsM
If %Input%== PER goto Personalization
If %Input%== KICK goto KickUser
if %input%== K goto KnifeGame
Echo Wrong input.
pause
goto ACom )
Echo Permissions messed up. Contact an Administrator
Pause
Goto Yes
:BroadOpts
cls
Echo B=Send a broadcast.
Echo C=Clear all broadcasts
Echo E=Exit
set input=
set /p input=
call :Uppercase Input
if %input%== B goto Broadcast
if %input%== C goto BClear
if %input%== E goto Yes
echo Wrong Input!
pause
goto BroadOpts
:BClear
findstr /i /v "$BROADCAST" %txt% > "%temp%\roomC.txt"
type "%temp%\roomC.txt" > %txt%
del /q "%temp%\roomC.txt"
goto Yes
:DevCom
cls
Echo Normal= Go into normal mode.
Echo V=Set New Version
Echo DV=Set New Display Version
Echo Trans= Go to trans testing [Useless unless developer]
Echo E=Exit
set input=
set /p input=
call :uppercase input
If %input%== E goto Yes
If %input%== NORMAL goto Normal
If %input%== V goto NewVer
If %input%== DV goto DNewVer
If %input%== TEST goto Testing
If %input%== TRANS goto TransTest
Echo Wrong Input
pause
goto DevCom
:RoomEdit
cls
echo RM=Remove the current room.
Echo PW=Change/Remove password of the current room.
Echo CA=Clear all rooms.
Echo RC=Change rooms.
Echo E=Exit
set input=
set /p input=
call :uppercase input
If %input%== E goto Yes
if %input%== RM goto RemRoom
if %input%== PW goto PWC
if %input%== CA goto ClearAll
if %input%== RC goto RoomTop
Echo Wrong Input
pause
goto RoomEdit
:Backup
cls
Echo Creating Backup. May take a few seconds.
FOR /F "tokens=1-3 delims=:." %%I IN ("%time%") DO (
      Set I=%%I
	  set J=%%J
	  set K=%%K
)
FOR /F "tokens=1-4 delims=/ " %%I IN ("%date%") DO (
	  set Day=%%I
	  set NDay=%%J
	  set Month=%%K
	  set Yr=%%L
)
set BackupBase=%BaseLoc_1%
set BackupBase=%Backupbase:"=%
md "%~dp0\Backups\%Day%.%Month%.%NDay%.%Yr%@%I%.%J%.%K%\"
set BDir=%~dp0\Backups\%Day%.%Month%.%NDay%.%Yr%@%I%.%J%.%K%\
xcopy "%BackupBase%*" "%BDir%" /e /c /i /q
Echo Backup Complete!
ping localhost -n 2 >nul
goto yes
:RemRoom
Echo Are you sure?
choice /c YN
if not %errorlevel%== 1 goto Yes
findstr /i "$" %txt% > "%temp%\roomR.txt"
findstr /i /v "$%room%" "%temp%\roomR.txt" > "%temp%\roomr1.txt"
findstr /i /v "%room%:" "%temp%\roomr1.txt" >> "%temp%\roomr2.txt"
type "%temp%\roomr2.txt" > %txt%
del /q "%temp%\RoomR.txt"
del /q "%temp%\Roomr1.txt"
del /q "%temp%\Roomr2.txt"
goto RoomTop
:PWC
Echo What would you like to change the password to?
Echo Hit enter if you want to remove the password.
set NewPW=
set /p NewPW=
if "%NewPW%"=="" goto PWRem
findstr /i "$RP" %txt% > "%temp%\roomPWC.txt"
findstr /i /v "%room%:" "%temp%\roomPWC.txt" > "%temp%\roomPWCt.txt"
findstr /i /v "$RP" %txt% > "%temp%\roomPWCR.txt"
type "%temp%\roomPWCt.txt" > %txt%
Echo %room%:%NewPW%:$RP >> %txt%
type "%temp%\roomPWCR.txt" >> %txt%
del /q "%temp%\roomPWCt.txt"
del /q "%temp%\roomPWCr.txt"
del /q "%temp%\roomPWC.txt"
Echo Done.
pause
goto RoomTop
:PWRem
findstr /i "$RP" %txt% > "%temp%\roomPWC.txt"
findstr /i /v "%room%:" "%temp%\roomPWC.txt" > "%temp%\roomPWCt.txt"
findstr /i /v "$RP" %txt% > "%temp%\roomPWCR.txt"
type "%temp%\roomPWCt.txt" > %txt%
type "%temp%\roomPWCR.txt" >> %txt%
del /q "%temp%\roomPWCt.txt"
del /q "%temp%\roomPWCr.txt"
del /q "%temp%\roomPWC.txt"
echo Done.
pause
goto yes
:Broadcast
cls
Echo What would you like to broadcast to all channels?
set broad=
set /p broad=Enter Broadcast Here: 
FOR /F "tokens=1-3 delims=:" %%I IN ("%time%") DO (
      set ITime=%%I:%%J
	  set Min=%%J
	  set Sec=%%K
)
echo $BROADCAST(%ITime%): %broad% >> %txt%
echo $BROADCAST(%ITime%): %broad%
echo Broadcast has been sent. Returning...
ping localhost -n 4 >nul
goto Yes2
:KickUser
Set KickUser=1
goto Lookup
:KickUser2
Set KickUser=0
If %FinderL%== Admin (
If %Perms%== Mod Goto CantKick
If %Perms%== User goto CantKick )
If %FinderL%== Mod (
If %Perms%== User Goto CantKick )
If %Perms%== User Goto CantKick
Echo %FinderSearch%=Kick >>%KickFile%
Echo User will be kicked.
Type %KickFile%
pause
Goto Yes
:CantKick
Echo Sorry, the user you want to kick is a Higher rank than you. 
Echo You may NOT kick them.
pause
goto Yes

:Personalization
Echo Here are your choices.
Echo 1=Change your color
Echo E=Exit
set Input=
set /p Input=
call :Uppercase Input
If %input%== E goto Yes
If %input%== 1 goto ColorChange
Echo Wrong choice!
pause
cls
goto Personalization
:ColorChange
Echo Usage: (Background color)(Text Color)
Echo    0 = Black       8 = Gray
Echo    1 = Blue        9 = Light Blue
Echo    2 = Green       A = Light Green
Echo    3 = Aqua        B = Light Aqua
Echo    4 = Red         C = Light Red
Echo    5 = Purple      D = Light Purple
Echo    6 = Yellow      E = Light Yellow
Echo    7 = White       F = Bright White
Echo Example: 9E Would produce light yellow text on a light blue background.
Set input=
set /p ColorN=Enter Color Code: 
Set IDCheckTimeOut=1
Set IDCheckNum=
Set IDCheckSearchIDCheckNum=
set IDCheckCounter=1
Set TimeOutNum=100
set Username1=%user%
Set ColorSearch=%Username1%
for /f %%x in (%cfg%) do (
  set "C!IDCheckCounter!=%%x"
  set /a IDCheckCounter+=1
)
goto ColorSearch
:ColorSearch
cls
Set /a IDCheckNum=%IDCheckNum%+1
Set /a IDCheckSearchIDCheckNum=%IDCheckSearchIDCheckNum%+1
Set IDCheckLine=!C%IDCheckNum%!
Set ColorU=
Set IDCheckLine >Nul
if "%IDCheckLine%"=="a=A" set /a IDCheckTimeOut=%IDCheckTimeOut%+1
:ColorAlgorithm
FOR /F "tokens=1-4 delims==," %%I IN ("%IDCheckLine%") DO (
      set I=%%I
	  Set J=%%J
	  Set K=%%K
)
Set ColorU=%K%
Set ColorID=%I%
goto ColorNext
:ColorDef
if defined ColorU goto ColorNext
goto ColorAlgorithm
:ColorVarDef
if defined ColorU goto ColorNext
goto ColorAlgorithm
:ColorNext
call :Uppercase ColorSearch
Set ColorUL=%ColorU%
call :Uppercase ColorID
if "%Last%"=="%ColorID%" goto ColorFound
set Last=%ColorID%
if "%ColorSearch%"=="%ColorID%" Goto ColorFound
if "%IDCheckNum%"=="%TimeOutNum%" goto ColorCant
goto ColorSearch
:ColorFound
findstr /i /v "%User%" %cfg% > "C:\users\%username%\desktop\temp.txt"
type "C:\users\%username%\desktop\temp.txt" > %cfg%
del "C:\users\%username%\desktop\temp.txt"
echo %User%,Color=%ColorN% >>%cfg%
sort /r %cfg%>"C:\users\%username%\desktop\temp.txt"
type "C:\users\%username%\desktop\temp.txt" > %cfg%
del "C:\users\%username%\desktop\temp.txt"
Color %ColorN%
Set CurColor=%ColorN%
Echo User Color changed!
pause
Goto Yes
:PermsM
cls
Echo AddAll=Re-add all users in the permissions file to the program.
set input=
set /p input=
call :Uppercase Input
If %Input%== ADDALL goto AddAllStart
goto PermsM
:AddAllStart
set IDCheckNum=0
Set IDCheckCounter=1
for /f %%x in (%IDFile%) do (
  set "L!IDCheckCounter!=%%x"
  set /a IDCheckCounter+=1
)
:AddAllsearch
cls
Set TimeOutNum=100
Set /a IDCheckNum=%IDCheckNum%+1
Set /a IDCheckSearchIDCheckNum=%IDCheckSearchIDCheckNum%+1
Set IDCheckLine=!L%IDCheckNum%!
Set RankU=
Set IDCheckLine >Nul
if "%IDCheckLine%"=="a=A" set /a IDCheckTimeOut=%IDCheckTimeOut%+1
:AddAllAlgorithm
FOR /F "tokens=1-4 delims==," %%I IN ("%IDCheckLine%") DO (
      set I=%%I
	  set J=%%J
	  Set L=%%L
)
call :Detrans I
set UID=%I%
echo I:%I%
echo J:%J%
echo L:%L%
if "%Last%"=="%I%" goto AddAllDone
Set Last=%I%
if "%L%"=="User" goto AddAllRF1
if "%L%"=="Mod" goto AddAllRF2
if "%L%"=="Admin" goto AddAllRF3
Echo Non-User
goto AddAllSearch
:AddAllDef
if defined RankU goto AddAllNext
goto AddAllAlgorithm
:AddAllVarDef
if defined RankU goto AddAllNext
goto AddAllAlgorithm
:AddAllRF1
icacls %IDFile% /remove:g %UID%
icacls %Txt1% /remove:g %UID%
icacls Updates\* /remove:g %UID%
icacls %HS% /remove:g %UID%
icacls %IDFile% /remove:d %UID%
icacls %Txt2% /remove:d %UID%
icacls %Txt1% /remove:d %UID%
icacls Updates\* /remove:d %UID%
icacls %HS% /remove:d %UID%
Icacls %KickFile% /grant %UID%:(R,W)
Icacls Updates\* /grant %UID%:(R)
Icacls %IDFile% /Grant %UID%:(R)
Icacls %Txt1% /grant %UID%:(R,W)
Icacls %cfg% /grant %UID%:(R,W)
icacls %HS% /grant %UID%:(R,W)
goto AddAllSearch

:AddAllRF2
icacls %IDFile% /remove:g %UID%
icacls %Txt2% /remove:g %UID%
icacls %Txt1% /remove:g %UID%
icacls Updates\* /remove:g %UID%
icacls %HS% /remove:g %UID%
icacls %IDFile% /remove:d %UID%
icacls %Txt2% /remove:d %UID%
icacls %Txt1% /remove:d %UID%
icacls Updates\* /remove:d %UID%
icacls %HS% /remove:d %UID%
Icacls Updates\* /grant %UID%:(R)
Icacls %IDFile% /Grant %UID%:(R)
Icacls %Txt2% /Grant %UID%:(R,W)
Icacls %Txt1% /grant %UID%:(R,W)
Icacls %KickFile% /grant %UID%:(R,W)
Icacls %cfg% /grant %UID%:(R,W)
icacls %HS% /grant %UID%:(R,W)
goto AddAllSearch

:AddAllRF3
if %Dev%== 1 goto AddAllRF3Dev
:AddAllRF3Cont
Icacls Updates\* /grant %UID%:(R,WDAC)
Icacls %IDFile% /Grant %UID%:(F,WDAC)
Icacls %Txt2% /Grant %UID%:(F,WDAC)
Icacls %Txt1% /grant %UID%:(F,WDAC)
Icacls %KickFile% /grant %UID%:(F,WDAC)
Icacls %cfg% /grant %UID%:(F,WDAC)
icacls %HS% /grant %UID%:(F,WDAC)
goto AddAllSearch
:AddAllRF3Dev
icacls %IDFile% /remove:g %UID%
icacls %Txt2% /remove:g %UID%
icacls %Txt1% /remove:g %UID%
icacls Updates\* /remove:g %UID%
icacls %HS% /remove:g %UID%
icacls %IDFile% /remove:d %UID%
icacls %Txt2% /remove:d %UID%
icacls %Txt1% /remove:d %UID%
icacls Updates\* /remove:d %UID%
Icacls %IDFile% /remove:d %UID%
Icacls %Txt2% /remove:d %UID%
Icacls %Txt1% /remove:d %UID%
icacls %HS% /remove:d %UID%
goto AddAllRF3Cont
:AddAllDone
Echo Finished adding users.
pause
goto Yes
:RankChange
Echo Who are you changing rank of?
set RankN=
set /p RankN=Enter Username: 
Set IDCheckTimeOut=1
Set IDCheckNum=
Set IDCheckSearchIDCheckNum=
set IDCheckCounter=1
Set TimeOutNum=100
Set RankSearch=%RankN%
for /f %%x in (%IDFile%) do (
  set "L!IDCheckCounter!=%%x"
  set /a IDCheckCounter+=1
)
goto RankSearch
:RankSearch
cls
Set /a IDCheckNum=%IDCheckNum%+1
Set /a IDCheckSearchIDCheckNum=%IDCheckSearchIDCheckNum%+1
Set IDCheckLine=!L%IDCheckNum%!
Set RankU=
Set IDCheckLine >Nul
if "%IDCheckLine%"=="a=A" set /a IDCheckTimeOut=%IDCheckTimeOut%+1
:RankAlgorithm
FOR /F "tokens=1-4 delims==," %%I IN ("%IDCheckLine%") DO (
      set I=%%I
	  Set J=%%J
	  Set K=%%K
	  Set L=%%L
)
Set RankU=%J%
Set RankID=%I%
goto RankNext
:RankDef
if defined RankU goto RankNext
goto RankAlgorithm
:RankVarDef
if defined RankU goto RankNext
goto RankAlgorithm
:RankNext
call :Uppercase RankSearch
Set RankUL=%RankU%
call :Uppercase RankU
if "%RankSearch%"=="%RankU%" Goto RankFound
if "%IDCheckNum%"=="%TimeOutNum%" goto RankCant
goto RankSearch
:RankCant
Echo Can't find user...
Echo Exit?
Echo E=Exit
Echo R=Retry
set input=
set /p input=
call :Uppercase input
if %input%== E goto Yes
if %input%== R goto RankChange
Echo Wrong input!
Echo Going to main menu.
Goto Yes
:RankFound
call :DeTrans RankID
Echo Username found!
Echo What would you like their rank to be?
Echo 1=User
Echo 2=Mod
Echo 3=Admin
set RankR=
set /p RankR=Enter Rank #: 
set UID=%RankID%
echo 1
pause
if "%RankR%"=="1" goto RankRF1
if "%RankR%"=="2" goto RankRF2
if "%RankR%"=="3" goto RankRF3
echo Wrong input
pause
goto RankFound

:RankRF1
icacls %IDFile% /remove:g %UID%
icacls %Txt1% /remove:g %UID%
icacls Updates\* /remove:g %UID%
icacls %IDFile% /remove:d %UID%
icacls %Txt2% /remove:d %UID%
icacls %Txt1% /remove:d %UID%
icacls Updates\* /remove:d %UID%
Icacls %KickFile% /grant %UID%:(R,W)
Icacls Updates\* /grant %UID%:(R)
Icacls %IDFile% /Grant %UID%:(R)
Icacls %Txt1% /grant %UID%:(R,W)
Icacls %cfg% /grant %UID%:(R,W)
icacls %HS% /remove:g %UID%
icacls %HS% /remove:d %UID%
icacls %HS% /grant %UID%:(R,W)
set RankR=User 
Goto RankRNext

:RankRF2
icacls %IDFile% /remove:g %UID%
icacls %Txt2% /remove:g %UID%
icacls %Txt1% /remove:g %UID%
icacls Updates\* /remove:g %UID%
icacls %IDFile% /remove:d %UID%
icacls %Txt2% /remove:d %UID%
icacls %Txt1% /remove:d %UID%
icacls Updates\* /remove:d %UID%
Icacls Updates\* /grant %UID%:(R)
Icacls %IDFile% /Grant %UID%:(R)
Icacls %Txt2% /Grant %UID%:(R,W)
Icacls %Txt1% /grant %UID%:(R,W)
Icacls %KickFile% /grant %UID%:(R,W)
Icacls %cfg% /grant %UID%:(R,W)
icacls %HS% /remove:g %UID%
icacls %HS% /remove:d %UID%
icacls %HS% /grant %UID%:(R,W)
set RankR=Mod 
Goto RankRNext

:RankRF3
icacls %IDFile% /remove:g %UID%
icacls %Txt2% /remove:g %UID%
icacls %Txt1% /remove:g %UID%
icacls Updates\* /remove:g %UID%
icacls %IDFile% /remove:d %UID%
icacls %Txt2% /remove:d %UID%
icacls %Txt1% /remove:d %UID%
icacls Updates\* /remove:d %UID%
Icacls %IDFile% /remove:d %UID%
Icacls %Txt2% /remove:d %UID%
Icacls %Txt1% /remove:d %UID%
Icacls Updates\* /grant %UID%:(R,WDAC)
Icacls %IDFile% /Grant %UID%:(F,WDAC)
Icacls %Txt2% /Grant %UID%:(F,WDAC)
Icacls %Txt1% /grant %UID%:(F,WDAC)
Icacls %KickFile% /grant %UID%:(F,WDAC)
Icacls %cfg% /grant %UID%:(F,WDAC)
icacls %HS% /remove:g %UID%
icacls %HS% /remove:d %UID%
icacls %HS% /grant %UID%:(WDAC)
set RankR=Admin 
Goto RankRNext

:RankRNext
call :Trans1 RankID
findstr /i /v "%RankU%" %IDFile% > "C:\users\%username%\desktop\temp.txt"
type "C:\users\%username%\desktop\temp.txt" > %IDFile%
del "C:\users\%username%\desktop\temp.txt"
echo %RankID%=%RankUL%,Perm=%RankR% >>%IDFile%
sort /r %IDFile%>"C:\users\%username%\desktop\temp.txt"
type "C:\users\%username%\desktop\temp.txt" > %IDFile%
del "C:\users\%username%\desktop\temp.txt"
cls
Echo User rank changed!
pause
Goto Yes
:NewVer
Echo Current version: %Ver%
Echo What is the new version?
set input=
set /p input=
findstr /i /v "%NewVar%" %IDFile% > "C:\users\%username%\desktop\temp.txt"
type "C:\users\%username%\desktop\temp.txt" > %IDFile%
del "C:\users\%username%\desktop\temp.txt"
echo Ver=%input% >>%IDFile%
sort /r %IDFile%>"C:\users\%username%\desktop\temp.txt"
type "C:\users\%username%\desktop\temp.txt" > %IDFile%
del "C:\users\%username%\desktop\temp.txt"
type %IDFile%
set U="tcw""uhb""put""put""kso""iuk""yup""put"
call :Detrans U
Icacls "Updates\Cause-%input%.bat" /grant %U%:(F)
Echo Addding all permissions.
pause
goto AddAllStart
:DNewVer
Echo Current version: %DVer%
Echo What is the new version?
set input=
set /p input=
findstr /i /v "%Dver%" %IDFile% > "C:\users\%username%\desktop\temp.txt"
type "C:\users\%username%\desktop\temp.txt" > %IDFile%
del "C:\users\%username%\desktop\temp.txt"
echo DVer=%input% >>%IDFile%
sort /r %IDFile%>"C:\users\%username%\desktop\temp.txt"
type "C:\users\%username%\desktop\temp.txt" > %IDFile%
del "C:\users\%username%\desktop\temp.txt"
type %IDFile%
set U="tcw""uhb""put""put""kso""iuk""yup""put"
call :Detrans U
Icacls "Updates\Display-%input%.bat" /grant %U%:(F)
Echo Addding all permissions.
pause
goto AddAllStart
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
Icacls %Txt2% /Grant %UID%:(R,W)
Icacls %Txt1% /grant %UID%:(R,W)
Goto IsUserInID
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
Icacls Updates\* /grant %UID%:(R)
Icacls %Txt1% /grant %UID%:(R,W)
goto IsUserInID
:AddDone
Echo User added!
pause
goto Yes
:AddName
Echo What do you want their nickname to be?
set UIDN=
set /p UIDN=
Echo What do you want their permissions to be?
Echo 1=User
Echo 2=Mod
Echo 3=Admin
set PermI=
set /p PermI=
set PermUI=
if %PermI%==1 goto AddUserUser
if %PermI%==3 goto AddUserAdmin
if %PermI%==2 goto AddUserMod
Echo Wrong input!
pause
goto AddName
:AddUserUser
icacls %IDFile% /remove:g %UID%
icacls %Txt1% /remove:g %UID%
icacls Updates\* /remove:g %UID%
icacls %IDFile% /remove:d %UID%
icacls %Txt2% /remove:d %UID%
icacls %Txt1% /remove:d %UID%
icacls Updates\* /remove:d %UID%
Icacls %KickFile% /grant %UID%:(R,W)
Icacls Updates\* /grant %UID%:(R)
Icacls %IDFile% /Grant %UID%:(R)
Icacls %Txt1% /grant %UID%:(R,W)
Icacls %cfg% /grant %UID%:(R,W)
icacls %HS% /remove:g %UID%
icacls %HS% /remove:d %UID%
icacls %HS% /grant %UID%:(R,W)
cls
echo User level User selected.
set PermUI=User
goto AddUserPerms
:AddUserMod
icacls %IDFile% /remove:g %UID%
icacls %Txt2% /remove:g %UID%
icacls %Txt1% /remove:g %UID%
icacls Updates\* /remove:g %UID%
icacls %IDFile% /remove:d %UID%
icacls %Txt2% /remove:d %UID%
icacls %Txt1% /remove:d %UID%
icacls Updates\* /remove:d %UID%
Icacls Updates\* /grant %UID%:(R)
Icacls %IDFile% /Grant %UID%:(R)
Icacls %Txt2% /Grant %UID%:(R,W)
Icacls %Txt1% /grant %UID%:(R,W)
Icacls %KickFile% /grant %UID%:(R,W)
Icacls %cfg% /grant %UID%:(R,W)
icacls %HS% /remove:g %UID%
icacls %HS% /remove:d %UID%
icacls %HS% /grant %UID%:(R,W)
cls
Echo User level Mod selected.
set PermUI=Mod
goto AddUserPerms

:AddUserAdmin
icacls %IDFile% /remove:g %UID%
icacls %Txt2% /remove:g %UID%
icacls %Txt1% /remove:g %UID%
icacls Updates\* /remove:g %UID%
icacls %IDFile% /remove:d %UID%
icacls %Txt2% /remove:d %UID%
icacls %Txt1% /remove:d %UID%
icacls Updates\* /remove:d %UID%
Icacls %IDFile% /remove:d %UID%
Icacls %Txt2% /remove:d %UID%
Icacls %Txt1% /remove:d %UID%
Icacls Updates\* /grant %UID%:(R,WDAC)
Icacls %IDFile% /Grant %UID%:(F,WDAC)
Icacls %Txt2% /Grant %UID%:(F,WDAC)
Icacls %Txt1% /grant %UID%:(F,WDAC)
Icacls %KickFile% /grant %UID%:(F,WDAC)
Icacls %cfg% /grant %UID%:(F,WDAC)
icacls %HS% /remove:g %UID%
icacls %HS% /remove:d %UID%
icacls %HS% /grant %UID%:(F,WDAC)
cls
echo User level Admin selected.
set PermUI=Admin
goto AddUserPerms
:AddUserPerms
call :Trans1 UID
echo %UID%=%UIDN%,Perm=%PermUI%>>%IDFile%
sort "%IDFile%"
goto AddDone
:RemUser
Echo Who would you like to remove.
Set RemUserSearch=
Set /p RemUserSearch=
Set RemUserSearch >Nul
call :Uppercase RemUserSearch
:RemUserSet
for /f %%x in (%IDFile%) do (
  set "L!IDCheckCounter!=%%x"
  set /a IDCheckCounter+=1
)
:RemUserSearch1
set IDCheckNum=0
:RemUserSearch
cls
Set /a IDCheckNum=%IDCheckNum%+1
Set /a IDCheckSearchIDCheckNum=%IDCheckSearchIDCheckNum%+1
Set IDCheckLine=!L%IDCheckNum%!
Set IDCheckLineU=
Set IDCheckLine >Nul
if "%IDCheckLine%"=="a=A" set /a IDCheckTimeOut=%IDCheckTimeOut%+1
:RemUserAlgorithm
FOR /F "tokens=1-4 delims==," %%I IN ("%IDCheckLine%") DO (
      set I=%%I
	  Set J=%%J
	  Set K=%%K
	  Set L=%%L
)
Set IDCheckLineU=%I%
Set RemUserU=%J%
Set RemUserK=%K%
Set RemUserL=%L%
if defined IDCheckLineU goto IDCheckLineDef >Nul
if defined Var goto VarDef >Nul
goto RemUserNext
:IDCheckLineDef
if defined Var goto RemUserNext
goto RemUserAlgorithm
:VarDef
if defined IDCheckLineU goto RemUserNext
goto RemUserAlgorithm
:RemUserNext
call :Uppercase RemUserSearch
call :Uppercase RemUserU
if "%RemUserSearch%"=="%RemUserU%" Goto RemUserFound
if %IDCheckSearchIDCheckNum%== %TimeOutNum% goto IDCheckCant
goto RemUserSearch
:RemUserFound
call :DeTrans IDCheckLineU
Echo %RemUserSearch%'s UID is %IDCheckLineU%
Echo %RemUserSearch% is a %RemUserL%
Echo Are you sure you want to remove this user?(Y/N)
set input=
set /p input=
set UID=%IDCheckLineU%
call :uppercase input
call :DeTrans UID
if %input%== Y (
icacls %IDFile% /remove:g %UID%
icacls %Txt2% /remove:g %UID%
icacls %Txt1% /remove:g %UID%
icacls Updates\* /remove:g %UID%
icacls %IDFile% /remove:d %UID%
icacls %Txt2% /remove:d %UID%
icacls %Txt1% /remove:d %UID%
icacls Updates\* /remove:d %UID%
icacls %HS% /remove:g %UID%
icacls %HS% /remove:d %UID%
call :Trans1 UID
cls
Echo User removed: %UID%: %RemUserU%: %RemUserL%
findstr /i /v "%RemUserU%" %IDFile% > "C:\users\%username%\desktop\temp.txt"
type "C:\users\%username%\desktop\temp.txt" > %IDFile%
del "C:\users\%username%\desktop\temp.txt"
Echo Finished!
)
if %input%== N (
echo Returning home.
ping localhost -n 2 >nul
)
pause
goto Yes
:Normal
If not exist H:\ goto NoInternetNorm
CD "H:\HHSTeachers\#REMOVED#RPURSLEY\PERIOD 5\"
Echo Switched to Normal mode.
goto top
:NoInternetNorm
Echo Make sure you are connected to sacs internet
Echo Also make sure that your H drive is connected.
Echo Going back to testing mode
CD "Testing 5\"
goto Top
:Testing
set Loc=Testing\
Echo Entering Testing mode.
if not exist Testing\ md Testing
goto Top

:IDCant
cls
Echo Cannot Find the user, maybe the capitols are wrong?
pause
Goto Com
:Clear
findstr /i /v "$%Room%" %txt% > "%temp%\roomC.txt"
type "%temp%\roomC.txt" > %txt%
del /q "%temp%\roomC.txt"
goto yes
:ClearAll
findstr /i "$Room" %txt% > "%temp%\roomC.txt"
type "%temp%\roomC.txt" > %txt%
del /q "%temp%\roomC.txt"
goto yes
:CMD
set input=
set /p input=
%input%
goto CMD
:Lookup
:FinderTop
Echo What are you looking for?
Set FinderSearch=
Set /p FinderSearch=
Set FinderSearch >Nul
call :Uppercase FinderSearch
:FinderSearch1
set IDCheckNum=0
:FinderSearch
cls
Set /a IDCheckNum=%IDCheckNum%+1
Set /a IDCheckSearchIDCheckNum=%IDCheckSearchIDCheckNum%+1
Set IDCheckLine=!L%IDCheckNum%!
Set IDCheckLineU=
Set IDCheckLine >Nul
if "%IDCheckLine%"=="a=A" set /a IDCheckTimeOut=%IDCheckTimeOut%+1
:FinderAlgorithm
FOR /F "tokens=1-4 delims==," %%I IN ("%IDCheckLine%") DO (
      set I=%%I
	  Set J=%%J
	  Set K=%%K
	  Set L=%%L
)
Set IDCheckLineU=%I%
Set FinderU=%J%
Set FinderK=%K%
Set FinderL=%L%
if defined IDCheckLineU goto IDCheckLineDef >Nul
if defined Var goto VarDef >Nul
goto FinderNext
:IDCheckLineDef
if defined Var goto FinderNext
goto FinderAlgorithm
:VarDef
if defined IDCheckLineU goto FinderNext
goto FinderAlgorithm
:FinderNext
call :Uppercase FinderSearch
call :Uppercase FinderU
if "%FinderSearch%"=="%FinderU%" Goto FinderFound
if %IDCheckSearchIDCheckNum%== %TimeOutNum% goto IDCheckCant
goto FinderSearch
:FinderFound
call :DeTrans IDCheckLineU
Echo %FinderSearch%'s UID is %IDCheckLineU%
Echo %FinderSearch% is a %FinderL%
if %KickUser%== 1 goto KickUser2
pause
goto Yes
:UpdateDownload
set tempd=%~dp0
set NewVar=%var%
if exist "%tempd%temp.txt" goto NoUpdate
copy "Updates\Cause-%NewVar%%FT%" "%tempd%Cause-%newvar%%FT%"
ping localhost -n 1 >nul
echo start "" "%tempd%Cause-%NewVar%%FT%">"%tempd%temp.bat"
echo ping localhost -n 1 >nul
echo del temp.bat >>"%tempd%temp.bat"
echo exit >>"%tempd%temp.bat"
start "" "%tempd%temp.bat"
del "%~f0"
exit
:NoUpdate
del "%tempd%temp.txt"
start "" "%~f0"
exit
goto Top1
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
set RoomPLast=
set RoomPLineU=
Set RoomPNum=
set RoomPCounter=1
Set TimeOutNum=2
findstr /i "$RP" %txt% > "%temp%\RoomPs.txt"
for /f %%x in (%temp%\RoomPs.txt) do (
  set "RP!RoomPCounter!=%%x"
  set /a RoomPCounter+=1
)
del /q "%temp%\RoomPs.txt"
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
if "%RoomPLast%"=="%RoomPLineU%" goto Yes
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
goto Yes
:RoomPStop
Echo You have entered the wrong password too many times.
set /a RoomAS= %RoomPStop%/2
echo Waiting %RoomAS% seconds.
if not defined RoomPStop set RoomPStop=10
ping localhost -n %RoomPStop% >nul
set /a RoomPStop=%RoomPStop%*2
cls
goto RoomPTry
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
:FixLet
set %~1=!%1:<=,!
set %~1=!%1:>=.!
goto:eof
:SpaceFix
set %~1=!%1:_= !
goto:
:SW
rem These are the words to be blocked. Sorry for typing them in the first place.
set SC=0
set S1=Damn
set S2=damn
set S3=Shit
set S4=shit
set S5=Fuck
set S5=fuck
:SW2
set /a SC=%SC%+1
set CSC=!S%SC%!
echo %CSC%
pause
if not defined CSC goto:eof
set %~1=!%1:%CSC%=***!
rem set CSC=t
rem for /f "delims=" %%A in ('"echo test|findstr /i "r""') do (
rem set line=%%A
rem )
rem echo line:%line%
rem pause
goto SW2
rem goto:eof
:KnifeGame
Echo Welcome to the knife game!!!
Echo 1= Play
Echo 2= Read High Scores
Echo 3= Go back
set input=
set /p input=
if %input%==1 goto KnifeGameReset
if %input%==2 goto KnifeGameHighScoreReader
if %input%==3 goto Yes
Echo Wrong input!
pause
cls goto KnifeGame
:KnifeGameReset
cls
set /a KnifeGameKnifeGamescore = 0
set /a KnifeGameHealth = 5
set KnifeGamePlayer=O
set /a KnifeGamePlayerpos=8
set border=#
set /a KnifeGameAmt=8
set KnifeGameBomb=@
set KnifeGameBomb1=
set KnifeGameBomb2=
set KnifeGameBomb3=
set KnifeGameBomb4=
set KnifeGameBomb5=
set KnifeGameBomb6=
set KnifeGameBomb7=
set KnifeGameBomb8=
set KnifeGameBomb0=
set KnifeGameBombRun2=false
set KnifeGameEn=%border%
set KnifeGamesa=%border%
set KnifeGamesb=%border%
set KnifeGamesc=%border%
set KnifeGamesd=%border%
set KnifeGamese=%border%
set KnifeGamesf=%border%
set KnifeGamesg=%border%
set KnifeGameea=%border%
set KnifeGameeb=%border%
set KnifeGameec=%border%
set KnifeGameed=%border%
set KnifeGameee=%border%
set KnifeGameef=%border%
set KnifeGameeg=%border%
set KnifeGamea1= 
set KnifeGamea2= 
set KnifeGamea3= 
set KnifeGamea4= 
set KnifeGamea5= 
set KnifeGamea6= 
set KnifeGamea7= 
set KnifeGamea8= 
set KnifeGamea9= 
set KnifeGamea10= 
set KnifeGamea11= 
set KnifeGamea12= 
set KnifeGamea13= 
set KnifeGamea14=
set KnifeGamea15= 
set KnifeGameb1= 
set KnifeGameb2= 
set KnifeGameb3= 
set KnifeGameb4= 
set KnifeGameb5= 
set KnifeGameb6= 
set KnifeGameb7= 
set KnifeGameb8= 
set KnifeGameb9= 
set KnifeGameb10=
set KnifeGameb11= 
set KnifeGameb12= 
set KnifeGameb13= 
set KnifeGameb14=
set KnifeGameb15=  
set KnifeGamec1= 
set KnifeGamec2= 
set KnifeGamec3= 
set KnifeGamec4= 
set KnifeGamec5= 
set KnifeGamec6= 
set KnifeGamec7= 
set KnifeGamec8= 
set KnifeGamec9= 
set KnifeGamec10= 
set KnifeGamec11= 
set KnifeGamec12= 
set KnifeGamec13= 
set KnifeGamec14=
set KnifeGamec15= 
set KnifeGamed1= 
set KnifeGamed2= 
set KnifeGamed3= 
set KnifeGamed4= 
set KnifeGamed5= 
set KnifeGamed6= 
set KnifeGamed7= 
set KnifeGamed8= 
set KnifeGamed9= 
set KnifeGamed10= 
set KnifeGamed11= 
set KnifeGamed12= 
set KnifeGamed13= 
set KnifeGamed14=
set KnifeGamed15= 
set KnifeGamee1= 
set KnifeGamee2= 
set KnifeGamee3= 
set KnifeGamee4= 
set KnifeGamee5= 
set KnifeGamee6= 
set KnifeGamee7= 
set KnifeGamee8= 
set KnifeGamee9= 
set KnifeGamee10= 
set KnifeGamee11= 
set KnifeGamee12= 
set KnifeGamee13= 
set KnifeGamee14=
set KnifeGamee15= 
set KnifeGamef1= 
set KnifeGamef2= 
set KnifeGamef3= 
set KnifeGamef4= 
set KnifeGamef5= 
set KnifeGamef6= 
set KnifeGamef7= 
set KnifeGamef8= 
set KnifeGamef9= 
set KnifeGamef10= 
set KnifeGamef11= 
set KnifeGamef12= 
set KnifeGamef13= 
set KnifeGamef14=
set KnifeGamef15= 
set KnifeGameg1= 
set KnifeGameg2= 
set KnifeGameg3= 
set KnifeGameg4= 
set KnifeGameg5= 
set KnifeGameg6= 
set KnifeGameg7= 
set KnifeGameg8= 
set KnifeGameg9= 
set KnifeGameg10= 
set KnifeGameg11= 
set KnifeGameg12= 
set KnifeGameg13= 
set KnifeGameg14=
set KnifeGameg15= 
:KnifeGameStart
cls
if %KnifeGamePlayerpos%== 1 set KnifeGamePlayerpos1=%KnifeGamePlayer%            
if %KnifeGamePlayerpos%== 2 set KnifeGamePlayerpos1= %KnifeGamePlayer%           
if %KnifeGamePlayerpos%== 3 set KnifeGamePlayerpos1=  %KnifeGamePlayer%          
if %KnifeGamePlayerpos%== 4 set KnifeGamePlayerpos1=   %KnifeGamePlayer%         
if %KnifeGamePlayerpos%== 5 set KnifeGamePlayerpos1=    %KnifeGamePlayer%        
if %KnifeGamePlayerpos%== 6 set KnifeGamePlayerpos1=     %KnifeGamePlayer%       
if %KnifeGamePlayerpos%== 7 set KnifeGamePlayerpos1=      %KnifeGamePlayer%      
if %KnifeGamePlayerpos%== 8 set KnifeGamePlayerpos1=       %KnifeGamePlayer%     
if %KnifeGamePlayerpos%== 9 set KnifeGamePlayerpos1=        %KnifeGamePlayer%    
if %KnifeGamePlayerpos%== 10 set KnifeGamePlayerpos1=         %KnifeGamePlayer%   
if %KnifeGamePlayerpos%== 11 set KnifeGamePlayerpos1=          %KnifeGamePlayer%  
if %KnifeGamePlayerpos%== 12 set KnifeGamePlayerpos1=           %KnifeGamePlayer% 
if %KnifeGamePlayerpos%== 13 set KnifeGamePlayerpos1=            %KnifeGamePlayer%
if %KnifeGamePlayerpos%== 15 set KnifeGamePlayerpos1=              %KnifeGamePlayer%
echo %KnifeGameEn%%KnifeGameEn%%KnifeGameEn%%KnifeGameEn%%KnifeGameEn%%KnifeGameEn%%KnifeGameEn%%KnifeGameEn%%KnifeGameEn%%KnifeGameEn%%KnifeGameEn%%KnifeGameEn%%KnifeGameEn%%KnifeGameEn%%KnifeGameEn%
echo %KnifeGamesa%%KnifeGamea1%%KnifeGamea2%%KnifeGamea3%%KnifeGamea4%%KnifeGamea5%%KnifeGamea6%%KnifeGamea7%%KnifeGamea8%%KnifeGamea9%%KnifeGamea10%%KnifeGamea11%%KnifeGamea12%%KnifeGamea13%%KnifeGamea14%%KnifeGameea%
echo %KnifeGamesb%%KnifeGameb1%%KnifeGameb2%%KnifeGameb3%%KnifeGameb4%%KnifeGameb5%%KnifeGameb6%%KnifeGameb7%%KnifeGameb8%%KnifeGameb9%%KnifeGameb10%%KnifeGameb11%%KnifeGameb12%%KnifeGameb13%%KnifeGameb14%%KnifeGameeb%
echo %KnifeGamesc%%KnifeGamec1%%KnifeGamec2%%KnifeGamec3%%KnifeGamec4%%KnifeGamec5%%KnifeGamec6%%KnifeGamec7%%KnifeGamec8%%KnifeGamec9%%KnifeGamec10%%KnifeGamec11%%KnifeGamec12%%KnifeGamec13%%KnifeGamec14%%KnifeGameec%
echo %KnifeGamesd%%KnifeGamed1%%KnifeGamed2%%KnifeGamed3%%KnifeGamed4%%KnifeGamed5%%KnifeGamed6%%KnifeGamed7%%KnifeGamed8%%KnifeGamed9%%KnifeGamed10%%KnifeGamed11%%KnifeGamed12%%KnifeGamed13%%KnifeGamed14%%KnifeGameed%
echo %KnifeGamese%%KnifeGamee1%%KnifeGamee2%%KnifeGamee3%%KnifeGamee4%%KnifeGamee5%%KnifeGamee6%%KnifeGamee7%%KnifeGamee8%%KnifeGamee9%%KnifeGamee10%%KnifeGamee11%%KnifeGamee12%%KnifeGamee13%%KnifeGamee14%%KnifeGameee%
echo %KnifeGamesf%%KnifeGamef1%%KnifeGamef2%%KnifeGamef3%%KnifeGamef4%%KnifeGamef5%%KnifeGamef6%%KnifeGamef7%%KnifeGamef8%%KnifeGamef9%%KnifeGamef10%%KnifeGamef11%%KnifeGamef12%%KnifeGamef13%%KnifeGamef14%%KnifeGameef%
echo %KnifeGameeg%%KnifeGameg1%%KnifeGameg2%%KnifeGameg3%%KnifeGameg4%%KnifeGameg5%%KnifeGameg6%%KnifeGameg7%%KnifeGameg8%%KnifeGameg9%%KnifeGameg10%%KnifeGameg11%%KnifeGameg12%%KnifeGameg13%%KnifeGameg14%%KnifeGameeg%
echo %KnifeGamese%%KnifeGamePlayerpos1%%KnifeGameee%
if %KnifeGameHealth%== 5 echo $$$$$
if %KnifeGameHealth%== 4 echo $$$$
if %KnifeGameHealth%== 3 echo $$$
if %KnifeGameHealth%== 2 echo $$
if %KnifeGameHealth%== 1 echo $
Echo Score: %KnifeGameKnifeGameScore%
if %KnifeGameAmt%==8 goto KnifeGameBomb8
if %KnifeGameAmt%==7 goto KnifeGameBomb7
if %KnifeGameAmt%==6 goto KnifeGameBomb6
if %KnifeGameAmt%==5 goto KnifeGameBomb5
if %KnifeGameAmt%==4 goto KnifeGameBomb4
if %KnifeGameAmt%==3 goto KnifeGameBomb3
if %KnifeGameAmt%==2 goto KnifeGameBomb2
if %KnifeGameAmt%==1 goto KnifeGameBomb1
if %KnifeGameAmt%==0 goto KnifeGameBomb0
:KnifeGameBomb8
set KnifeGameg1= 
set KnifeGameg2= 
set KnifeGameg3= 
set KnifeGameg4= 
set KnifeGameg5= 
set KnifeGameg6= 
set KnifeGameg7= 
set KnifeGameg8= 
set KnifeGameg9= 
set KnifeGameg10= 
set KnifeGameg11= 
set KnifeGameg12= 
set KnifeGameg13= 

if %KnifeGameBombRun2%== true set KnifeGamef8= 
if %KnifeGameBombRun2%== true set KnifeGamef13= 
if %KnifeGameBombRun2%== true set KnifeGamed8= 
if %KnifeGameBombRun2%== true set KnifeGamed3= 
if %KnifeGameBombRun2%== true set KnifeGameb12= 
if %KnifeGameBombRun2%== true set KnifeGameb5= 
if %KnifeGameBombRun2%== true set KnifeGameg8=%KnifeGameBomb%
if %KnifeGameBombRun2%== true set KnifeGameg13=%KnifeGameBomb%
if %KnifeGameBombRun2%== true set KnifeGamee8=%KnifeGameBomb%
if %KnifeGameBombRun2%== true set KnifeGamee3=%KnifeGameBomb%
if %KnifeGameBombRun2%== true set KnifeGamec12=%KnifeGameBomb%
if %KnifeGameBombRun2%== true set KnifeGamec5=%KnifeGameBomb%
set KnifeGamea4=%KnifeGameBomb%
set KnifeGamea10=%KnifeGameBomb%
set /a KnifeGameAmt=%KnifeGameAmt%-1
goto KnifeGameChoice
:KnifeGameBomb7
if %KnifeGameBombRun2%== true if %KnifeGamePlayerpos%== 8 goto KnifeGameOver
if %KnifeGameBombRun2%== true if %KnifeGamePlayerpos%== 13 goto KnifeGameOver
set KnifeGameg1= 
set KnifeGameg2= 
set KnifeGameg3= 
set KnifeGameg4= 
set KnifeGameg5= 
set KnifeGameg6= 
set KnifeGameg7= 
set KnifeGameg8= 
set KnifeGameg9= 
set KnifeGameg10= 
set KnifeGameg11= 
set KnifeGameg12= 
set KnifeGameg13= 
if %KnifeGameBombRun2%== true set KnifeGameg8= 
if %KnifeGameBombRun2%== true set KnifeGameg13= 
if %KnifeGameBombRun2%== true set KnifeGamee8= 
if %KnifeGameBombRun2%== true set KnifeGamee3= 
if %KnifeGameBombRun2%== true set KnifeGamec12= 
if %KnifeGameBombRun2%== true set KnifeGamec5= 
if %KnifeGameBombRun2%== true set KnifeGamef8=%KnifeGameBomb%
if %KnifeGameBombRun2%== true set KnifeGamef3=%KnifeGameBomb%
if %KnifeGameBombRun2%== true set KnifeGamed12=%KnifeGameBomb%
if %KnifeGameBombRun2%== true set KnifeGamed5=%KnifeGameBomb%
set KnifeGamea4= 
set KnifeGamea10= 
set KnifeGamea1=%KnifeGameBomb%
set KnifeGameb4=%KnifeGameBomb%
set KnifeGameb10=%KnifeGameBomb%
set /a KnifeGameAmt=%KnifeGameAmt%-1
goto KnifeGameChoice
:KnifeGameBomb6
set KnifeGamea1= 
set KnifeGameg1= 
set KnifeGameg2= 
set KnifeGameg3= 
set KnifeGameg4= 
set KnifeGameg5= 
set KnifeGameg6= 
set KnifeGameg7= 
set KnifeGameg8= 
set KnifeGameg9= 
set KnifeGameg10= 
set KnifeGameg11= 
set KnifeGameg12= 
set KnifeGameg13= 
if %KnifeGameBombRun2%== true set KnifeGamef8= 
if %KnifeGameBombRun2%== true set KnifeGamef3= 
if %KnifeGameBombRun2%== true set KnifeGamed12= 
if %KnifeGameBombRun2%== true set KnifeGamed5= 
if %KnifeGameBombRun2%== true set KnifeGameg8=%KnifeGameBomb%
if %KnifeGameBombRun2%== true set KnifeGameg3=%KnifeGameBomb%
if %KnifeGameBombRun2%== true set KnifeGamee12=%KnifeGameBomb%
if %KnifeGameBombRun2%== true set KnifeGamee5=%KnifeGameBomb%

set KnifeGameb4= 
set KnifeGameb10= 
set KnifeGameb1=%KnifeGameBomb%
set KnifeGamec4=%KnifeGameBomb%
set KnifeGamec10=%KnifeGameBomb%
set KnifeGamea8=%KnifeGameBomb%
set KnifeGamea13=%KnifeGameBomb%
set /a KnifeGameAmt=%KnifeGameAmt%-1
goto KnifeGameChoice
:KnifeGameBomb5
if %KnifeGameBombRun2%== true if %KnifeGamePlayerpos%== 8 goto KnifeGameOver
if %KnifeGameBombRun2%== true if %KnifeGamePlayerpos%== 3 goto KnifeGameOver
set KnifeGameb1= 
set KnifeGameg1= 
set KnifeGameg2= 
set KnifeGameg3= 
set KnifeGameg4= 
set KnifeGameg5= 
set KnifeGameg6= 
set KnifeGameg7= 
set KnifeGameg8= 
set KnifeGameg9= 
set KnifeGameg10= 
set KnifeGameg11= 
set KnifeGameg12= 
set KnifeGameg13= 
if %KnifeGameBombRun2%== true set KnifeGamee12= 
if %KnifeGameBombRun2%== true set KnifeGamee5= 

set KnifeGamec4= 
set KnifeGamec10= 
set KnifeGamea8= 
set KnifeGamea13= 
set KnifeGamec1 = %KnifeGameBomb%
set KnifeGamed4=%KnifeGameBomb%
set KnifeGamed10=%KnifeGameBomb%
set KnifeGameb8=%KnifeGameBomb%
set KnifeGameb13=%KnifeGameBomb%
set /a KnifeGameAmt=%KnifeGameAmt%-1
goto KnifeGameChoice
:KnifeGameBomb4
if %KnifeGameBombRun2%== true set KnifeGamef12=%KnifeGameBomb%
if %KnifeGameBombRun2%== true set KnifeGamef5=%KnifeGameBomb%
set KnifeGamec1= 
set KnifeGameg1= 
set KnifeGameg2= 
set KnifeGameg3= 
set KnifeGameg4= 
set KnifeGameg5= 
set KnifeGameg6= 
set KnifeGameg7= 
set KnifeGameg8= 
set KnifeGameg9= 
set KnifeGameg10= 
set KnifeGameg11= 
set KnifeGameg12= 
set KnifeGameg13= 
if %KnifeGameBombRun2%== true set KnifeGameg12=%KnifeGameBomb%
if %KnifeGameBombRun2%== true set KnifeGameg5=%KnifeGameBomb%

set KnifeGamed4= 
set KnifeGamed10= 
set KnifeGameb8= 
set KnifeGameb13= 
set KnifeGamea2=%KnifeGameBomb%
set KnifeGamed1=%KnifeGameBomb%
set KnifeGamee4=%KnifeGameBomb%
set KnifeGamee10=%KnifeGameBomb%
set KnifeGamec8=%KnifeGameBomb%
set KnifeGamec13=%KnifeGameBomb%
set KnifeGamea8=%KnifeGameBomb%
set KnifeGamea3=%KnifeGameBomb%
set /a KnifeGameAmt=%KnifeGameAmt%-1
goto KnifeGameChoice
:KnifeGameBomb3
if %KnifeGameBombRun2%== true if %KnifeGamePlayerpos%== 12 goto KnifeGameOver
if %KnifeGameBombRun2%== true if %KnifeGamePlayerpos%== 5 goto KnifeGameOver
set KnifeGamea2= 
set KnifeGamed1= 
set KnifeGameg1= 
set KnifeGameg2= 
set KnifeGameg3= 
set KnifeGameg4= 
set KnifeGameg5= 
set KnifeGameg6= 
set KnifeGameg7= 
set KnifeGameg8= 
set KnifeGameg9= 
set KnifeGameg10= 
set KnifeGameg11= 
set KnifeGameg12= 
set KnifeGameg13= 
set KnifeGamef1= 
set KnifeGamef2= 
set KnifeGamef3= 
set KnifeGamef4= 
set KnifeGamef5= 
set KnifeGamef6= 
set KnifeGamef7= 
set KnifeGamef8= 
set KnifeGamef9= 
set KnifeGamef10= 
set KnifeGamef11= 
set KnifeGamef12= 
set KnifeGamef13= 
set KnifeGamef13= 
set KnifeGamef15= 
if %KnifeGameBombRun2%== true set KnifeGameg12= 
if %KnifeGameBombRun2%== true set KnifeGameg5= 
set KnifeGamee4= 
set KnifeGamee10= 
set KnifeGamec8= 
set KnifeGamec13= 
set KnifeGamea8= 
set KnifeGamea3= 
set KnifeGameb2=%KnifeGameBomb%
set KnifeGamee1=%KnifeGameBomb%
set KnifeGamef4=%KnifeGameBomb%
set KnifeGamef10=%KnifeGameBomb%
set KnifeGamed8=%KnifeGameBomb%
set KnifeGamed13=%KnifeGameBomb%
set KnifeGameb8=%KnifeGameBomb%
set KnifeGameb3=%KnifeGameBomb%
set /a KnifeGameAmt=%KnifeGameAmt%-1
goto KnifeGameChoice
:KnifeGameBomb2
set KnifeGameb2= 
set KnifeGamee1= 
set KnifeGameg1= 
set KnifeGameg2= 
set KnifeGameg3= 
set KnifeGameg4= 
set KnifeGameg5= 
set KnifeGameg6= 
set KnifeGameg7= 
set KnifeGameg8= 
set KnifeGameg9= 
set KnifeGameg10= 
set KnifeGameg11= 
set KnifeGameg12= 
set KnifeGameg13= 
set KnifeGamef4= 
set KnifeGamef10= 
set KnifeGamed8= 
set KnifeGamed13= 
set KnifeGameb8= 
set KnifeGameb3= 
set KnifeGamec2=%KnifeGameBomb%
set KnifeGamef1=%KnifeGameBomb%
set KnifeGameg4=%KnifeGameBomb%
set KnifeGameg10=%KnifeGameBomb%

set KnifeGamee8=%KnifeGameBomb%
set KnifeGamee13=%KnifeGameBomb%
set KnifeGamec8=%KnifeGameBomb%
set KnifeGamec3=%KnifeGameBomb%
set KnifeGamea12=%KnifeGameBomb%
set KnifeGamea5=%KnifeGameBomb%
set /a KnifeGameAmt=%KnifeGameAmt%-1
goto KnifeGameChoice
:KnifeGameBomb1
if %KnifeGamePlayerpos%== 4 goto KnifeGameOver
if %KnifeGamePlayerpos%== 10 goto KnifeGameOver
set KnifeGamec2= 
set KnifeGamef1= 
set KnifeGameg1= 
set KnifeGameg2= 
set KnifeGameg3= 
set KnifeGameg4= 
set KnifeGameg5= 
set KnifeGameg6= 
set KnifeGameg7= 
set KnifeGameg8= 
set KnifeGameg9= 
set KnifeGameg10= 
set KnifeGameg11= 
set KnifeGameg12= 
set KnifeGameg13= 
set KnifeGamee8= 
set KnifeGamee13= 
set KnifeGamec8= 
set KnifeGamec3= 
set KnifeGamea12= 
set KnifeGamea5= 
set KnifeGamed2=%KnifeGameBomb%
set KnifeGameg1=%KnifeGameBomb%
set KnifeGamef8=%KnifeGameBomb%
set KnifeGamef13=%KnifeGameBomb%
set KnifeGamed8=%KnifeGameBomb%
set KnifeGamed3=%KnifeGameBomb%
set KnifeGameb12=%KnifeGameBomb%
set KnifeGameb5=%KnifeGameBomb%
set KnifeGameBombRun2= true
set /a KnifeGameAmt=8
goto KnifeGameChoice
:KnifeGameChoice
choice /c AD0 /t 1 /d 0 >nul
if %errorlevel%== 1 goto left
if %errorlevel%== 2 goto right
if %errorlevel%== 3 goto KnifeGameStart
:left
set /a KnifeGameKnifeGamescore= %KnifeGameKnifeGamescore% + 1
if %KnifeGamePlayerpos%== 1 goto KnifeGameStart
set /a KnifeGamePlayerpos= %KnifeGamePlayerpos% - 1
goto KnifeGameStart
:right
set /a KnifeGameKnifeGamescore= %KnifeGameKnifeGamescore% + 1
if %KnifeGamePlayerpos%== 13 goto KnifeGameStart
set /a KnifeGamePlayerpos= %KnifeGamePlayerpos% + 1
goto KnifeGameStart
:KnifeGameOver
if %KnifeGameAmt%==1 set KnifeGameAmt= 8
if %KnifeGameAmt% gtr 1 set /a KnifeGameAmt=%KnifeGameAmt%-1
set /a KnifeGameHealth=%KnifeGameHealth%-1
if %KnifeGameHealth% gtr 0 goto KnifeGameStart
Echo game over.....
Echo you were hit by the knives and lost all 5 hearts.. :O
Echo.
Echo.
ping localhost -n 2 >nul
Echo your Score was %KnifeGameKnifeGamescore%!!!
Echo Would you like to keep this Score???
Echo (Y/N)
set input=
set /p input=
if %input%== y goto KnifeGameHighScoreWriter
if %input%== n goto KnifeGame
if %input%== Y goto KnifeGameHighScoreWriter
if %input%== N goto KnifeGame
Echo WRONG INPUT!!!!
pause
cls
goto KnifeGameOver
:KnifeGameHighScoreWriter
Echo Ok whats your Name?
set /p input=
Echo Writing Highscore...
if exist "%HS%" goto KnifeGameWrite
echo Name = Score >"%HS%"
:KnifeGameWrite
echo %en%%input% = %KnifeGameKnifeGameScore%%en% >>"%HS%"
Echo Done!!!
:KnifeGameHighScoreReader
if not exist "%HS%" goto KnifeGameNoHighScore
Echo Here are the current High Scores.
echo.
echo.
echo #################
Type "%HS%"
echo #################
echo.
echo.
pause
Goto KnifeGame
:KnifeGameNoHighScores
echo There are no current high scores!
echo Returning to the Knife Game menu!
pause
ping localhost -n 2 >nul
goto KnifeGame
