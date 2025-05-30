@echo off
echo Creating Windows Installer for Pac-Man Game...

REM Check if jpackage is available (Java 14+)
jpackage --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: jpackage not found. You need Java 14 or later to create native installers.
    echo Current method will create a JAR file instead.
    pause
    exit /b 1
)

REM Create Windows installer
jpackage ^
    --input . ^
    --name "PacMan Game" ^
    --main-jar PacMan.jar ^
    --main-class App ^
    --type msi ^
    --app-version 1.0 ^
    --vendor "Your Name" ^
    --description "Classic Pac-Man Game" ^
    --win-dir-chooser ^
    --win-menu ^
    --win-shortcut

if %errorlevel% equ 0 (
    echo.
    echo SUCCESS: Windows installer created!
    echo Look for PacMan Game-1.0.msi in the current directory
) else (
    echo.
    echo ERROR: Failed to create installer
)

pause
