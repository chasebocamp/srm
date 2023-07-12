@echo off

:: Check if running as administrator
>nul 2>&1 "%SYSTEMROOT%\system32\icacls.exe" "%SYSTEMROOT%\system32\config\system" || (
    echo Please run this program as administrator.
    pause
    exit /b
)

title System Repair Menu v1.0

:menu
cls
echo ==============================
echo    System Repair Menu
echo ==============================
echo 1. Check and repair system files (SFC)
echo 2. Perform DISM cleanup and restore operations
echo 3. Check and sync system time and date
echo 4. Create a system restore point
echo 5. Exit

set /p choice=Enter your choice (1-5): 

if "%choice%"=="1" (
    echo Performing system file check...
    echo Please wait...
    sfc /scannow
    echo System file check complete.
    pause
    goto menu
)

if "%choice%"=="2" (
    echo Performing DISM cleanup and restore operations...
    echo Please wait...
    dism /online /cleanup-image /startcomponentcleanup
    dism /online /cleanup-image /restorehealth
    echo DISM operations complete.
    pause
    goto menu
)

if "%choice%"=="3" (
    echo Checking and syncing system time and date...
    echo Please wait...
    w32tm /resync
    echo System time and date synchronized.
    pause
    goto menu
)

if "%choice%"=="4" (
    echo Creating a system restore point...
    echo Please wait...
    wmic /namespace:\\root\default path SystemRestore call CreateRestorePoint "System Repair Point", 100, 7
    echo System restore point created.
    pause
    goto menu
)

if "%choice%"=="5" (
    exit
)

echo Invalid choice. Please try again.
pause
goto menu
