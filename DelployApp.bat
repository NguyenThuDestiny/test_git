@echo off

SET FILEPath="D:\Project"
SET FileName="App.exe"

:main
cls
echo.
echo.	1. Run app
echo.	2. Kill app
echo.	3. Make shortcut

SET /p choice=Please choose the desired action:

if "%choice%" == "1" goto runApp
if "%choice%" == "2" goto killApp
if "%choice%" == "3" goto makeSC

goto main

::------------------------
:runApp
cls
tasklist /NH /FI "IMAGENAME eq %FileName%"	|	find /I %FileName% > nul
if %errorlevel% == 0 (
	echo. App already running
) else (
	start "" "%FILEPath%\%FileName%"
	echo. Run app success
)

goto exit

::--------------------
:killApp
cls
tasklist /NH /FI "IMAGENAME eq %FileName%"	|	find /I %FileName% > nul
if %errorlevel% == 0 (
	taskkill /F /T /IM %FileName%
	echo Kill app success
) else (
	echo. App not runApp
)

goto exit

::----------------------------------
:makeSC
cls
net session > nul 2>&1
if %errorlevel% == 0 (
	echo. Make sc
	mklink %USERPROFILE%\Desktop\app.lnk %FILEPath%\%FileName%
	echo. Make sc success
) else (
	echo Request Admin
	echo SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\getAdminRight.vbs"
	echo UAC.ShellExecute "cmd.exe", "/c %~f0 ", "runas", 1 >> "%TEMP%\getAdminRight.vbs"
	"%TEMP%\getAdminRight.vbs"
	del "%TEMP%\getAdminRight.vbs"
)

::-------------------------------
:exit
exit /B 0
