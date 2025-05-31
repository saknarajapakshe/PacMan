@echo off
echo =========================================
echo Creating Simple PacMan Game Installer
echo =========================================
echo.

REM Create simple installer directory
if exist "PacMan-SimpleInstaller" rmdir /s /q "PacMan-SimpleInstaller"
mkdir "PacMan-SimpleInstaller"

echo Step 1: Copying game files...
copy "PacMan.jar" "PacMan-SimpleInstaller\"
copy "RunPacMan.bat" "PacMan-SimpleInstaller\"

echo Step 2: Creating simple installer...
(
echo @echo off
echo title PacMan Game Installer
echo echo ==========================================
echo echo           PacMan Game Installer
echo echo ==========================================
echo echo.
echo echo Installing PacMan Game...
echo echo.
echo.
echo REM Check for Java
echo java -version ^>nul 2^>^&1
echo if %%errorlevel%% neq 0 ^(
echo     echo Error: Java not found! Please install Java first.
echo     echo Download from: https://www.java.com
echo     pause
echo     exit /b 1
echo ^)
echo.
echo echo Java found - continuing installation...
echo echo.
echo.
echo REM Create game directory
echo set "gameDir=%%USERPROFILE%%\PacManGame"
echo if not exist "%%gameDir%%" mkdir "%%gameDir%%"
echo.
echo echo Copying game files...
echo copy "PacMan.jar" "%%gameDir%%\"
echo copy "RunPacMan.bat" "%%gameDir%%\"
echo.
echo echo Creating desktop shortcut...
echo ^(
echo echo @echo off
echo echo cd /d "%%gameDir%%"
echo echo start java -jar PacMan.jar
echo ^) ^> "%%USERPROFILE%%\Desktop\Play PacMan.bat"
echo.
echo echo ==========================================
echo echo         Installation Complete!
echo echo ==========================================
echo echo.
echo echo Game installed to: %%gameDir%%
echo echo Desktop shortcut: Play PacMan.bat
echo echo.
echo echo Double-click "Play PacMan.bat" on your desktop to play!
echo echo.
echo pause
) > "PacMan-SimpleInstaller\Install.bat"

echo Step 3: Creating README...
(
echo PacMan Game - Simple Installer
echo ==============================
echo.
echo INSTALLATION:
echo 1. Run Install.bat
echo 2. Game will be installed to your user folder
echo 3. Desktop shortcut will be created
echo.
echo MANUAL INSTALLATION:
echo 1. Copy PacMan.jar anywhere you want
echo 2. Double-click RunPacMan.bat to play
echo.
echo REQUIREMENTS:
echo - Java 8 or higher
echo - Windows 7 or later
echo.
echo CONTROLS:
echo - Arrow Keys: Move PacMan
echo - SPACE: Pause
echo.
echo Have fun playing!
) > "PacMan-SimpleInstaller\README.txt"

echo Step 4: Creating ZIP package...
powershell -command "Compress-Archive -Path 'PacMan-SimpleInstaller\*' -DestinationPath 'PacMan-Simple-Installer.zip' -Force"

echo.
echo =========================================
echo    SIMPLE INSTALLER CREATED!
echo =========================================
echo.
echo Files created:
echo - PacMan-SimpleInstaller\ (installer folder)
echo - PacMan-Simple-Installer.zip (distributable)
echo.
pause
