@echo off
echo =========================================
echo Creating Portable PacMan Game Installer
echo =========================================
echo.

REM Create installer directory
if exist "PacMan-Installer" rmdir /s /q "PacMan-Installer"
mkdir "PacMan-Installer"

echo Step 1: Copying game files...
copy "PacMan.jar" "PacMan-Installer\"
copy "RunPacMan.bat" "PacMan-Installer\"

echo Step 2: Creating installation script...
(
echo @echo off
echo title PacMan Game Installer
echo echo =========================================
echo echo       PacMan Game Installation
echo echo =========================================
echo echo.
echo echo This will install PacMan Game to your system.
echo echo.
echo set /p "installPath=Enter installation directory (default: C:\PacManGame^): "
echo if "%%installPath%%"=="" set "installPath=C:\PacManGame"
echo.
echo echo Creating installation directory...
echo if not exist "%%installPath%%" mkdir "%%installPath%%"
echo.
echo echo Copying game files...
echo copy "PacMan.jar" "%%installPath%%\"
echo copy "RunPacMan.bat" "%%installPath%%\"
echo.
echo echo Creating desktop shortcut...
echo set "desktopPath=%%USERPROFILE%%\Desktop"
echo ^(
echo echo @echo off
echo echo cd /d "%%installPath%%"
echo echo java -jar PacMan.jar
echo ^) ^> "%%desktopPath%%\PacMan Game.bat"
echo.
echo echo Creating Start Menu shortcut...
echo set "startMenuPath=%%APPDATA%%\Microsoft\Windows\Start Menu\Programs"
echo copy "%%desktopPath%%\PacMan Game.bat" "%%startMenuPath%%\"
echo.
echo echo =========================================
echo echo      Installation Complete!
echo echo =========================================
echo echo.
echo echo Game installed to: %%installPath%%
echo echo Desktop shortcut created: PacMan Game.bat
echo echo Start Menu shortcut created
echo echo.
echo echo To uninstall, simply delete the installation folder.
echo echo.
echo pause
) > "PacMan-Installer\Install.bat"

echo Step 3: Creating README for installer...
(
echo # PacMan Game Installer
echo.
echo ## Installation Instructions:
echo 1. Run Install.bat as Administrator
echo 2. Choose installation directory or press Enter for default
echo 3. Game will be installed with desktop and start menu shortcuts
echo.
echo ## Manual Installation:
echo 1. Copy PacMan.jar to any folder
echo 2. Double-click RunPacMan.bat to play
echo.
echo ## System Requirements:
echo - Windows 7 or later
echo - Java 8 or higher
echo.
echo ## Controls:
echo - Arrow keys: Move PacMan
echo - SPACE: Pause game
echo - ESC: Exit game
echo.
echo Enjoy playing PacMan!
) > "PacMan-Installer\README.txt"

echo Step 4: Creating uninstaller...
(
echo @echo off
echo title PacMan Game Uninstaller
echo echo =========================================
echo echo       PacMan Game Uninstaller
echo echo =========================================
echo echo.
echo set /p "confirm=Are you sure you want to uninstall PacMan Game? (Y/N): "
echo if /i "%%confirm%%"=="Y" (
echo     echo Removing desktop shortcut...
echo     if exist "%%USERPROFILE%%\Desktop\PacMan Game.bat" del "%%USERPROFILE%%\Desktop\PacMan Game.bat"
echo     echo Removing start menu shortcut...
echo     if exist "%%APPDATA%%\Microsoft\Windows\Start Menu\Programs\PacMan Game.bat" del "%%APPDATA%%\Microsoft\Windows\Start Menu\Programs\PacMan Game.bat"
echo     echo.
echo     echo Uninstallation complete!
echo     echo You can manually delete this folder: %%~dp0
echo ^) else (
echo     echo Uninstallation cancelled.
echo ^)
echo pause
) > "PacMan-Installer\Uninstall.bat"

echo Step 5: Creating ZIP package...
powershell -command "Compress-Archive -Path 'PacMan-Installer\*' -DestinationPath 'PacMan-Portable-Installer.zip' -Force"

echo.
echo =========================================
echo INSTALLER CREATION COMPLETE!
echo =========================================
echo.
echo Created:
echo - PacMan-Installer\ (installer folder)
echo - PacMan-Portable-Installer.zip (portable installer)
echo.
echo To distribute:
echo 1. Share PacMan-Portable-Installer.zip
echo 2. Users extract and run Install.bat
echo.
pause
