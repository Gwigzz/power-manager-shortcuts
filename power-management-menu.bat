@echo off

:: Encoding UTF-8
chcp 65001 >nul

set CURRENT_VERSION=0.3

title Power Management Menu

:: ________________ Check Update _______________
:: URL depot version
set "URL=https://raw.githubusercontent.com/Gwigzz/power-manager-shortcuts/main/version.txt"

:: URL for updating
set "URL_DEPOT=https://github.com/Gwigzz/power-manager-shortcuts/blob/main/power-management-menu.bat"

set "DEPOT_VERSION="

call :msg "Checking online version app..." DarkCyan

:: Request online version
for /f "delims=" %%i in ('powershell -command "try { (Invoke-WebRequest -Uri %URL% -UseBasicParsing).Content } catch { exit 1 }"') do (
    set DEPOT_VERSION=%%i
)
timeout /t 1 >nul
cls

:: Check request
if "%DEPOT_VERSION%"=="" (
    call :msgBg "Errors checking online version" Red
    echo.
    call :msg "Please refer to: %URL_DEPOT%" Blue
    timeout /t 1 >nul
    goto endCheckingVersion
)

:: Comparing version
if %DEPOT_VERSION% equ %CURRENT_VERSION% (
    call :msg "Checking version success." Green
    timeout /t 1 >nul
    cls
) else (
    call :msg "Your version             : %CURRENT_VERSION%" Cyan
    call :msg "New version available    : %DEPOT_VERSION%" Cyan
    echo.
    call :msg "Please refer to: %URL_DEPOT%" Blue
    echo.
)
:endCheckingVersion
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
set /p choix="Choice: "
:: Get currrent time
set currentTime=%time:~0,5%
echo ------------------------------------------


if "%choix%"=="1" (
    echo.
    call :msg "Opening Power Options..." Green
    echo.
    control.exe /name Microsoft.PowerOptions
    goto loop
) else if "%choix%"=="2" (
    echo.
    call :msg "Opening Advanced Settings..." Green
    echo.
    control.exe powercfg.cpl,,1
    goto loop
) else if "%choix%"=="3" (
    echo.
    call :msgBg "Exit..." DarkCyan
    echo.
    timeout /t 2 >nul
    exit
) else (
    call :msgBg "Invalid Choice. Enter : [1, 2 or 3]" Red
    echo.
    goto loop
)



:: Display message color
:: [Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow,
:: Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White]
:msg
setlocal
    set "message=%~1"
    set "color=%~2"
        if "%color%"=="" set "color=White"
    powershell -command "Write-Host '%message%' -ForegroundColor %color%"
endlocal
goto :eof


:: Display message with bg color
:msgBg
setlocal
    set "message=%~1"
    set "bgColor=%~2"
        powershell write-host -back %bgColor% "%message%"
endlocal
goto :eof
