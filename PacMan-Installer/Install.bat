@echo off
title PacMan Game Installer
echo =========================================
echo       PacMan Game Installation
echo =========================================
echo.
echo This will install PacMan Game to your system.
echo.
set /p "installPath=Enter installation directory (default: C:\PacManGame^): "
if "%installPath%"=="" set "installPath=C:\PacManGame"

echo Creating installation directory...
if not exist "%installPath%" mkdir "%installPath%"

echo Copying game files...
copy "PacMan.jar" "%installPath%\"
copy "RunPacMan.bat" "%installPath%\"

echo Creating desktop shortcut...
set "desktopPath=%USERPROFILE%\Desktop"
(
echo @echo off
echo cd /d "%installPath%"
echo java -jar PacMan.jar
) > "%desktopPath%\PacMan Game.bat"

echo Creating Start Menu shortcut...
set "startMenuPath=%APPDATA%\Microsoft\Windows\Start Menu\Programs"
copy "%desktopPath%\PacMan Game.bat" "%startMenuPath%\"

echo =========================================
echo      Installation Complete!
echo =========================================
echo.
echo Game installed to: %installPath%
echo Desktop shortcut created: PacMan Game.bat
echo Start Menu shortcut created
echo.
echo To uninstall, simply delete the installation folder.
echo.
pause
