@echo off

:: Encoding UTF-8
chcp 65001 >nul

set CURRENT_VERSION=0.2

title Power Management Menu

:: ________________ Check Update _______________
:: URL depot version
set "URL=https://raw.githubusercontent.com/Gwigzz/power-manager-shortcuts/main/version.txt"

set "DEPOT_VERSION="

echo Checking online version app...

for /f "delims=" %%i in ('powershell -command "try { (Invoke-WebRequest -Uri %URL% -UseBasicParsing).Content } catch { exit 1 }"') do (
    set DEPOT_VERSION=%%i
)
timeout /t 1 >nul
cls

:: Check request
if "%DEPOT_VERSION%"=="" (
    echo Error to get online version: Please check your connection...
)

:: Comparing version
if %DEPOT_VERSION% equ %CURRENT_VERSION% (
    echo Checking version ok...
    timeout /t 1 >nul
    cls
) else (
    echo New version available! [%DEPOT_VERSION%]
    echo.
    echo Please refer to: https://github.com/Gwigzz/power-manager-shortcuts/blob/main/power-management-menu.bat
    echo.
)
:: _____________________________________________

echo.
echo                                    ============================================
echo                                                Power Management Menu
echo                                    ============================================
echo                                                     Version %CURRENT_VERSION%
echo.
echo        [1] Power Options
echo        [2] Advanced Settings
echo        [3] Exit
echo.
echo ------------------------------------------
echo.

:loop
set /p choix="Choice : "
:: Get currrent time
set currentTime=%time:~0,5%
echo ------------------------------------------


if "%choix%"=="1" (
    echo.
    powershell -command "Write-Host '[%currentTime%] Opening Power Options...' -ForegroundColor Green"
    echo.
    control.exe /name Microsoft.PowerOptions
    goto loop
) else if "%choix%"=="2" (
    echo.
    powershell -command "Write-Host '[%currentTime%] Opening Advanced Settings...' -ForegroundColor Green"
    echo.
    control.exe powercfg.cpl,,1
    goto loop
) else if "%choix%"=="3" (
    echo.
    echo Exit...
    echo.
    timeout /t 2 >nul
    exit
) else (
    powershell -command "Write-Host '[%currentTime%] Invalid Choice. Enter : [1, 2 or 3]' -ForegroundColor Red"
    echo.
    goto loop
)