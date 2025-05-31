@echo off
title PacMan Game Uninstaller
echo =========================================
echo       PacMan Game Uninstaller
echo =========================================
echo.
set /p "confirm=Are you sure you want to uninstall PacMan Game? (Y/N): "
if /i "%confirm%"=="Y" (
    echo Removing desktop shortcut...
    if exist "%USERPROFILE%\Desktop\PacMan Game.bat" del "%USERPROFILE%\Desktop\PacMan Game.bat"
    echo Removing start menu shortcut...
    if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\PacMan Game.bat" del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\PacMan Game.bat"
    echo.
    echo Uninstallation complete!
    echo You can manually delete this folder: %~dp0
) else (
    echo Uninstallation cancelled.
)
pause
