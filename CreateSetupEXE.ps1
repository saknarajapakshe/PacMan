# PacMan Game Setup Script
# This creates a Windows executable installer

param(
    [string]$OutputPath = "PacMan-Setup.exe"
)

Write-Host "==========================================" -ForegroundColor Green
Write-Host "    Creating PacMan Game Setup EXE" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""

# Check if required files exist
if (-not (Test-Path "PacMan.jar")) {
    Write-Host "Error: PacMan.jar not found!" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path "RunPacMan.bat")) {
    Write-Host "Error: RunPacMan.bat not found!" -ForegroundColor Red
    exit 1
}

# Create temporary setup folder
$setupFolder = "PacMan-Setup-Temp"
if (Test-Path $setupFolder) {
    Remove-Item $setupFolder -Recurse -Force
}
New-Item -ItemType Directory -Path $setupFolder | Out-Null

Write-Host "Step 1: Preparing setup files..." -ForegroundColor Yellow

# Copy game files
Copy-Item "PacMan.jar" "$setupFolder\"
Copy-Item "RunPacMan.bat" "$setupFolder\"

# Create setup script
$setupScript = @"
@echo off
title PacMan Game Setup
color 0A
echo.
echo    ██████╗  █████╗  ██████╗███╗   ███╗ █████╗ ███╗   ██╗
echo    ██╔══██╗██╔══██╗██╔════╝████╗ ████║██╔══██╗████╗  ██║
echo    ██████╔╝███████║██║     ██╔████╔██║███████║██╔██╗ ██║
echo    ██╔═══╝ ██╔══██║██║     ██║╚██╔╝██║██╔══██║██║╚██╗██║
echo    ██║     ██║  ██║╚██████╗██║ ╚═╝ ██║██║  ██║██║ ╚████║
echo    ╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
echo.
echo                    GAME SETUP WIZARD
echo    ==========================================
echo.
echo    Welcome to PacMan Game Setup!
echo.

REM Check for Java
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo    [ERROR] Java is not installed or not in PATH!
    echo    Please install Java 8 or later from:
    echo    https://www.oracle.com/java/technologies/downloads/
    echo.
    pause
    exit /b 1
)

echo    [✓] Java detected
echo.

set "defaultPath=%USERPROFILE%\Games\PacMan"
set /p "installPath=    Install to (default: %defaultPath%): "
if "%installPath%"=="" set "installPath=%defaultPath%"

echo.
echo    Installing to: %installPath%
echo.

REM Create installation directory
if not exist "%installPath%" (
    mkdir "%installPath%" >nul 2>&1
    if %errorlevel% neq 0 (
        echo    [ERROR] Cannot create directory: %installPath%
        pause
        exit /b 1
    )
)

echo    [✓] Installation directory created
echo.

REM Copy files
echo    Copying game files...
copy /Y "PacMan.jar" "%installPath%\" >nul
copy /Y "RunPacMan.bat" "%installPath%\" >nul

if %errorlevel% neq 0 (
    echo    [ERROR] Failed to copy game files!
    pause
    exit /b 1
)

echo    [✓] Game files copied
echo.

REM Create desktop shortcut
set "desktopPath=%USERPROFILE%\Desktop"
(
echo @echo off
echo title PacMan Game
echo cd /d "%installPath%"
echo java -jar PacMan.jar
) > "%desktopPath%\PacMan Game.bat"

echo    [✓] Desktop shortcut created
echo.

REM Create start menu entry
set "startMenuPath=%APPDATA%\Microsoft\Windows\Start Menu\Programs"
copy "%desktopPath%\PacMan Game.bat" "%startMenuPath%\" >nul 2>&1

echo    [✓] Start menu entry created
echo.

REM Create uninstaller
(
echo @echo off
echo title PacMan Game Uninstaller
echo echo Removing PacMan Game...
echo if exist "%USERPROFILE%\Desktop\PacMan Game.bat" del "%USERPROFILE%\Desktop\PacMan Game.bat"
echo if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\PacMan Game.bat" del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\PacMan Game.bat"
echo echo.
echo echo Game shortcuts removed.
echo echo To complete uninstallation, delete: %installPath%
echo pause
) > "%installPath%\Uninstall.bat"

echo    [✓] Uninstaller created
echo.
echo    ==========================================
echo                INSTALLATION COMPLETE!
echo    ==========================================
echo.
echo    PacMan Game has been successfully installed!
echo.
echo    Installation location: %installPath%
echo    Desktop shortcut: PacMan Game.bat
echo    Start Menu: PacMan Game.bat
echo.
echo    To play: Double-click the desktop shortcut
echo    To uninstall: Run Uninstall.bat from the game folder
echo.
echo    Controls:
echo    - Arrow Keys: Move PacMan
echo    - SPACE: Pause
echo    - ESC: Exit
echo.
echo    Enjoy the game!
echo.
pause

REM Clean up temporary files
cd /d "%TEMP%"
rmdir /s /q "%~dp0" >nul 2>&1
"@

$setupScript | Out-File -FilePath "$setupFolder\setup.bat" -Encoding ASCII

Write-Host "Step 2: Creating self-extracting archive..." -ForegroundColor Yellow

# Create a PowerShell script that will be converted to EXE
$extractorScript = @"
# Self-extracting PacMan Game installer
`$ErrorActionPreference = "Stop"

# Embedded files will be inserted here by the build script
`$files = @{
    "PacMan.jar" = @"
[PACMAN_JAR_BASE64]
"@
    "RunPacMan.bat" = @"
[RUNPACMAN_BAT_BASE64]
"@
    "setup.bat" = @"
[SETUP_BAT_BASE64]
"@
}

# Extract to temp directory
`$tempDir = Join-Path `$env:TEMP "PacManSetup_`$(Get-Random)"
New-Item -ItemType Directory -Path `$tempDir -Force | Out-Null

try {
    # Extract files
    foreach (`$file in `$files.GetEnumerator()) {
        `$bytes = [System.Convert]::FromBase64String(`$file.Value)
        `$filePath = Join-Path `$tempDir `$file.Key
        [System.IO.File]::WriteAllBytes(`$filePath, `$bytes)
    }
    
    # Run setup
    Set-Location `$tempDir
    Start-Process "setup.bat" -Wait
} finally {
    # Cleanup
    Remove-Item `$tempDir -Recurse -Force -ErrorAction SilentlyContinue
}
"@

# Encode files to base64
$jarBase64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes("PacMan.jar"))
$batBase64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes("RunPacMan.bat"))
$setupBase64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes("$setupFolder\setup.bat"))

# Replace placeholders
$extractorScript = $extractorScript -replace '\[PACMAN_JAR_BASE64\]', $jarBase64
$extractorScript = $extractorScript -replace '\[RUNPACMAN_BAT_BASE64\]', $batBase64
$extractorScript = $extractorScript -replace '\[SETUP_BAT_BASE64\]', $setupBase64

# Save the PowerShell installer
$psInstallerPath = "PacMan-Setup.ps1"
$extractorScript | Out-File -FilePath $psInstallerPath -Encoding UTF8

Write-Host "Step 3: Creating batch wrapper..." -ForegroundColor Yellow

# Create a batch file that runs the PowerShell script
$batchWrapper = @"
@echo off
title PacMan Game Setup
echo Starting PacMan Game Setup...
powershell -ExecutionPolicy Bypass -File "%~dp0PacMan-Setup.ps1"
if errorlevel 1 (
    echo.
    echo Setup failed! Please run as Administrator.
    pause
)
"@

$batchWrapper | Out-File -FilePath "PacMan-Setup.bat" -Encoding ASCII

# Cleanup
Remove-Item $setupFolder -Recurse -Force

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "           SETUP CREATION COMPLETE!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Created installers:" -ForegroundColor Cyan
Write-Host "- PacMan-Setup.bat (Windows installer)" -ForegroundColor White
Write-Host "- PacMan-Setup.ps1 (PowerShell installer)" -ForegroundColor White
Write-Host ""
Write-Host "To distribute:" -ForegroundColor Cyan
Write-Host "1. Share both PacMan-Setup.bat and PacMan-Setup.ps1" -ForegroundColor White
Write-Host "2. Users run PacMan-Setup.bat" -ForegroundColor White
Write-Host ""
