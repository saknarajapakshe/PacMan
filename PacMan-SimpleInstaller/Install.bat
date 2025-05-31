@echo off
title PacMan Game Installer
echo ==========================================
echo           PacMan Game Installer
echo ==========================================
echo.
echo Installing PacMan Game...
echo.

REM Check for Java
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Java not found! Please install Java first.
    echo Download from: https://www.java.com
    pause
    exit /b 1
)

echo Java found - continuing installation...
echo.

REM Create game directory
set "gameDir=%USERPROFILE%\PacManGame"
if not exist "%gameDir%" mkdir "%gameDir%"

echo Copying game files...
copy "PacMan.jar" "%gameDir%\"
copy "RunPacMan.bat" "%gameDir%\"

echo Creating desktop shortcut...
(
echo @echo off
echo cd /d "%gameDir%"
echo start java -jar PacMan.jar
) > "%USERPROFILE%\Desktop\Play PacMan.bat"

echo ==========================================
echo         Installation Complete!
echo ==========================================
echo.
echo Game installed to: %gameDir%
echo Desktop shortcut: Play PacMan.bat
echo.
echo Double-click "Play PacMan.bat" on your desktop to play!
echo.
pause
