@echo off

@REM UTF-8
chcp 65001 >nul

title Power Management Menu

:menu
@REM cls
echo ============================================
echo   Power Management Menu
echo ============================================
echo.
echo 1. Power Options
echo 2. Advanced Settings
echo 3. Exit
echo.
set /p choix="Enter your choice (1, 2 or 3) : "
cls

if "%choix%"=="1" (
    echo.
    echo Opening Power Options...
    echo.
    control.exe /name Microsoft.PowerOptions
    goto menu
) else if "%choix%"=="2" (
    echo.
    echo Opening Advanced Settings...
    echo.
    control.exe powercfg.cpl,,1
    goto menu
) else if "%choix%"=="3" (
    cls
    echo.
    echo Exit...
    echo.
    timeout /t 2 >nul
    exit
) else (
    color 4
    echo Invalid Choice. Enter : [1, 2 or 3]
    echo.
    timeout /t 2 >nul
    color 07
    cls
    goto menu
)