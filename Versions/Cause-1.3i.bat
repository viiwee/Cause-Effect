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
set Ver=1.3i
set BaseLocF=.loc
set BaseLoc=H:\HHSTeachers\-member-\Period 4\
Set aPerm=0
set CurColor=F0
set KickFile=Config\.cfg
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
Echo Username found in registry with nickname: %User%
Goto Yes
:VerSearchDone
set NewVar=%var%
set VerSearch=0
If "%Ver%"=="%NewVar%" Goto Top1
goto UpdateDownload
:IDCheckSearchAlt
set %IDCheckSearchAlt%=0
goto Top1
:Yes
cls
:Yes2
set VerSearch=0
color %CurColor%
Echo Hello %User%
Echo %input%
if "%IDCheckSearchAlt%"== "1" goto IDCheckSearchAlt
:Top
set input=
set /p input=
set I=
set KickID=
Goto KickCheck
:KickTop
If "%input%"== "/" goto Com
echo %User%: %time%: %input% >> %txt%
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
Echo Lookup= Look up Ban status, User ID, and username of a user.
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
if %input%== RC goto RC
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
Echo Rank=Change rank of a specified user.
Echo Perms=Permissions Menu
Echo Per=Personalize the program
Echo Kick= Kick a specified User.
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
If %input%== CMD goto CMD
If %input%== TRANS goto TransTest
If %input%== V goto NewVer
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
Set ColorSearch=%User%
for /f %%x in (%IDFile%) do (
  set "L!IDCheckCounter!=%%x"
  set /a IDCheckCounter+=1
)
goto ColorSearch
:ColorSearch
cls
Set /a IDCheckNum=%IDCheckNum%+1
Set /a IDCheckSearchIDCheckNum=%IDCheckSearchIDCheckNum%+1
Set IDCheckLine=!L%IDCheckNum%!
Set ColorU=
Set IDCheckLine >Nul
if "%IDCheckLine%"=="a=A" set /a IDCheckTimeOut=%IDCheckTimeOut%+1
:ColorAlgorithm
FOR /F "tokens=1-4 delims==," %%I IN ("%IDCheckLine%") DO (
      set I=%%I
	  Set J=%%J
	  Set K=%%K
	  Set L=%%L
)
Set ColorU=%J%
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
call :Uppercase ColorU
if "%ColorSearch%"=="%ColorU%" Goto ColorFound
if "%IDCheckNum%"=="%TimeOutNum%" goto ColorCant
goto ColorSearch
:ColorCant
Echo Can't find user...
Echo Exit?
Echo E=Exit
Echo R=Retry
set input=
set /p input=
call :Uppercase input
if %input%== E goto Yes
if %input%== R goto ColorChange
Echo Wrong input!
Echo Going to main menu.
Goto Yes
:ColorFound
findstr /i /v "%User%" %IDFile% > "C:\users\%username%\desktop\temp.txt"
type "C:\users\%username%\desktop\temp.txt" > %IDFile%
del "C:\users\%username%\desktop\temp.txt"
echo %ColorID%=%ColorUL%,Perm=%Perms%,Color=%ColorN% >>%IDFile%
sort /r %IDFile%>"C:\users\%username%\desktop\temp.txt"
type "C:\users\%username%\desktop\temp.txt" > %IDFile%
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
If %Input%== ADDALL goto AddAllsearch
goto PermsM
:AddAllsearch
Set Last=%I%
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
	  Set L=%%L
)
Set AddAllID=%I%
echo Trans:%I%
call :Detrans I
Echo DeTrans:%I%
Icacls %IDFile% /grant %I%:(R)
Icacls %txt% /grant %I%:(R,W)
Icacls %BaseLocF% /grant %I%:(R)
if "%IDCheckNum%"=="%TimeOutNum%" goto AddAllDone
If "%Last%"=="%I%" goto AddAllDone
if "%L%"=="Admin" (
echo admin
Icacls %Txt2% /grant %I%:(R,W)
Icacls %IDfile% /grant %I%:(R,W)
pause
)
goto AddAllSearch
:AddAllPr
icacls %txt2% /grant %I%:(R,W)
:AddAllPrN
goto AddAllNext
:AddAllDef
if defined RankU goto AddAllNext
goto AddAllAlgorithm
:AddAllVarDef
if defined RankU goto AddAllNext
goto AddAllAlgorithm
:AddAllNext
call :Uppercase AddAllSearch
Set RankUL=%RankU%
call :Uppercase RankU
if "%AddAllSearch%"=="%RankU%" Goto AddAllFound
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
Echo Username found!
Echo What would you like their rank to be?
Echo 1=User
Echo 2=Mod
Echo 3=Admin
set RankR=
set /p RankR=Enter Rank #: 
if %RankR%== 1 set RankR=User
if %RankR%== 2 set RankR=Mod
if %RankR%== 3 set RankR=Admin
findstr /i /v "%RankU%" %IDFile% > "C:\users\%username%\desktop\temp.txt"
type "C:\users\%username%\desktop\temp.txt" > %IDFile%
del "C:\users\%username%\desktop\temp.txt"
echo %RankID%=%RankUL%,Perm=%RankR% >>%IDFile%
sort /r %IDFile%>"C:\users\%username%\desktop\temp.txt"
type "C:\users\%username%\desktop\temp.txt" > %IDFile%
del "C:\users\%username%\desktop\temp.txt"
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
Icacls "Updates\Cause-%input%.bat" /grant ALLHHSSTUDENTS:(R)
set U="tcw""uhb""put""put""kso""iuk""yup""put"
call :Detrans U
Icacls "Updates\Cause-%input%.bat" /grant %U%:(F)
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
Icacls Updates\* /grant %UID%:(R)
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
Icacls Updates\* /grant %UID%:(R)
Icacls %IDFile% /grant %UID%:(R)
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
if "%PermI%"=="1" (
echo User level User selected.
set PermUI=User
goto AddUserPerms
)
if "%PermI%"=="2" (
Echo User level Mod selected.
set PermUI=Mod
goto AddUserPerms
)
if "%PermI%"=="3" (
echo User level Admin selected.
set PermUI=Admin
goto AddUserPerms
)
Echo Wrong input!
Goto AddName
:AddUserPerms
call :Trans1 UID
echo %UID%=%UIDN%,Perm=%PermUI%>>%IDFile%
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
   FOR /F "tokens=1-6 delims==," %%I in ("%RemUserLine%") do (
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
call :DeTrans UID
Icacls %IDFile% /remove %UID%
Icacls %Txt2% /remove %UID%
Icacls %Txt1% /remove %UID%
Icacls Updates\* /remove %UID%
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
type nul > "%txt%"
goto Top
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