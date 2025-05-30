@echo off
echo =========================================
echo Pac-Man Game Build and Distribution Script
echo =========================================
echo.

REM Clean previous builds
if exist "bin" rmdir /s /q "bin"
if exist "PacMan-Distribution" rmdir /s /q "PacMan-Distribution"
if exist "PacMan.jar" del "PacMan.jar"
if exist "PacMan-Game-v1.0.zip" del "PacMan-Game-v1.0.zip"

echo Step 1: Creating bin directory...
mkdir "bin"

echo Step 2: Compiling Java files...
javac -d bin src/*.java
if %errorlevel% neq 0 (
    echo ERROR: Compilation failed!
    pause
    exit /b 1
)

echo Step 3: Copying assets...
xcopy /E /I src\assets bin\assets > nul

echo Step 4: Creating JAR file...
jar cfm PacMan.jar MANIFEST.MF -C bin .
if %errorlevel% neq 0 (
    echo ERROR: JAR creation failed!
    pause
    exit /b 1
)

echo Step 5: Creating distribution folder...
mkdir "PacMan-Distribution"
copy "PacMan.jar" "PacMan-Distribution\"
copy "RunPacMan.bat" "PacMan-Distribution\"

echo Step 6: Creating README file...
echo # Pac-Man Game > "PacMan-Distribution\README.txt"
echo. >> "PacMan-Distribution\README.txt"
echo ## How to Run: >> "PacMan-Distribution\README.txt"
echo 1. Double-click RunPacMan.bat >> "PacMan-Distribution\README.txt"
echo 2. Or run: java -jar PacMan.jar >> "PacMan-Distribution\README.txt"
echo. >> "PacMan-Distribution\README.txt"
echo ## Requirements: >> "PacMan-Distribution\README.txt"
echo - Java 8 or higher >> "PacMan-Distribution\README.txt"
echo. >> "PacMan-Distribution\README.txt"
echo ## Controls: >> "PacMan-Distribution\README.txt"
echo - Arrow keys to move >> "PacMan-Distribution\README.txt"
echo - SPACE to pause >> "PacMan-Distribution\README.txt"

echo Step 7: Creating ZIP distribution...
powershell -command "Compress-Archive -Path 'PacMan-Distribution\*' -DestinationPath 'PacMan-Game-v1.0.zip' -Force"

echo.
echo =========================================
echo BUILD COMPLETE!
echo =========================================
echo.
echo Created files:
echo - PacMan.jar (executable JAR)
echo - PacMan-Distribution\ (distribution folder)
echo - PacMan-Game-v1.0.zip (distribution archive)
echo.
echo To distribute your game:
echo 1. Share the ZIP file, or
echo 2. Share the PacMan-Distribution folder, or
echo 3. Share just the PacMan.jar file
echo.
pause
