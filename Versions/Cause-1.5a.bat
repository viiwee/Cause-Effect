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
set Ver=1.5a
set BaseLocF=.loc
set BaseLoc=H:\HHSTeachers\-member-\Period 4\
Set aPerm=0
set CurColor=F0
set KickFile=Config\.cfg
set KickUser=0
set Cfg=Config\pref.cfg
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
findstr /i "$room" %txt% > "C:\users\%username%\temp\rooms.txt"
for /f %%x in (C:\users\%username%\temp\rooms.txt) do (
  set "R!RoomCounter!=%%x"
  set /a RoomCounter+=1
)
:RoomSearch1
Echo What name room do you want to join?
Echo (Default room=1)
findstr /i "$room" %txt% > "C:\users\%username%\temp\rooms.txt"
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
if "%RF%"=="1" goto yes
if "%perms%"=="Admin" (
Echo New Room Created. What is the description? {Only a few words pelase}
set RD=
set /p RD=
Echo %Room%:$Room %RD% >> %txt%
goto Yes
)
if "%perms%"=="Mod" (
Echo New Room Created. What is the description? {Only a few words pelase}
set RD=
set /p RD=
Echo %Room%:$Room %RD% >> %txt%
goto Yes
)
cls
Echo This room does not exist!
Echo Please join an existing room, or ask a Mod/Admin to create one for you.
pause
cls
goto RoomTop
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
FOR /F "tokens=1-2 delims=:" %%I IN ("%time%") DO (
      set ITime=%%I:%%J
)
echo %User%:$%Room%(%ITime%): %input% >> %txt%
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
:ACom
If %Perms%== User (
:UCom
Echo Clear=Clear Document
Echo RC= Change rooms
Echo Users= Look at the list of all users
Echo Per=Personalize the program
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
Echo Wrong input.
pause
goto UCom )
If %Perms%== Mod (
:MCom
Echo Clear=Clear Document
Echo Lookup= Look up Ban status, User ID, and username of a user.
Echo Users= Look at the list of all users
Echo RC= Change rooms.
Echo Perms=Permissions Menu
Echo Per=Personalize the program
Echo E=Exit
Set input=
Set /p input=
call :Uppercase input
if %input%== RC goto RoomTop
If %input%== CLEAR goto Clear
If %input%== LOOKUP goto Lookup
if %input%== USERS goto AllUsers
If %input%== E goto Top
If %input%== CMD goto CMD
If %input%== PERMS goto PermsM
If %Input%== PER goto Personalization
Echo Wrong input.
pause
goto MCom )
If %Perms%== Admin (
Echo Clear=Clear Document
Echo Add=Add a User to the list.
Echo Rem=Remove a User from the list.
Echo Lookup= Look up Ban status, User ID, and username of a user.
Echo Users= Look at the list of all users
Echo Trans= Go to trans testing (Useless unless developer)
Echo Normal= Go into normal mode.
Echo RC= Change rooms.
Echo V=Set New Version(Developer Only)
Echo DV=Set New Display Version (Developer Only)
Echo Rank=Change rank of a specified user.
Echo Perms=Permissions Menu
Echo Per=Personalize the program
Echo Kick= Kick a specified User.
Echo E=Exit
Set input=
Set /p input=
call :Uppercase input
if %input%== RC goto RoomTop
If %input%== ADD goto AddUser
If %input%== REM goto RemUser
If %input%== CLEAR goto Clear
If %input%== LOOKUP goto Lookup
If %input%== TEST goto Testing
If %input%== NORMAL goto Normal
if %input%== USERS goto AllUsers
If %input%== E goto Top
If %input%== CMD goto CMD
If %input%== TRANS goto TransTest
If %input%== V goto NewVer
If %input%== DV goto DNewVer
If %input%== RANK goto RankChange
If %input%== PERMS goto PermsM
If %Input%== PER goto Personalization
If %Input%== KICK goto KickUser
Echo Wrong input.
pause
goto ACom )
Echo Permissions messud up.
Pause
Goto Yes
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
Echo Sorry, the user you want to kick is a Higher rank than you. You may NOT kick them.
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
icacls %IDFile% /remove:d %UID%
icacls %Txt2% /remove:d %UID%
icacls %Txt1% /remove:d %UID%
icacls Updates\* /remove:d %UID%
Icacls %KickFile% /grant %UID%:(R,W)
Icacls Updates\* /grant %UID%:(R)
Icacls %IDFile% /Grant %UID%:(R)
Icacls %Txt1% /grant %UID%:(R,W)
Icacls %cfg% /grant %UID%:(R,W)
goto AddAllSearch

:AddAllRF2
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
goto AddAllSearch

:AddAllRF3
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
goto AddAllSearch

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
cacls "%Loc%%Ban%.txt" /E /g @sacs.k12.in.us:F
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
findstr /i /v "$%Room%" %txt% > "C:\users\%username%\temp\roomC.txt"
type "C:\users\%username%\temp\roomC.txt" > %txt%
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
set temp=%~dp0
set NewVar=%var%
if exist "%temp%temp.txt" goto NoUpdate
copy "Updates\Cause-%NewVar%%FT%" "%temp%Cause-%newvar%%FT%"
ping localhost -n 1 >nul
echo start "" "%temp%Cause-%NewVar%%FT%">"%temp%temp.bat"
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
goto RoomCont
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
goto:eof