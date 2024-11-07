@echo off

:: Encoding UTF-8
chcp 65001 >nul

set versionApp=0.2

title Power Management Menu

echo.
echo                        ============================================
echo                                    Power Management Menu
echo                        ============================================
echo                                         Version %versionApp%
echo.
echo        [1] Power Options
echo        [2] Advanced Settings
echo        [3] Exit
echo.
echo ------------------------------------------
echo.

:loop
set /p choix="Please, enter your choice : "
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