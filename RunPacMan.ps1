# Pac-Man Game Launcher
Write-Host "Starting Pac-Man Game..." -ForegroundColor Green

# Check if Java is installed
try {
    $javaVersion = java -version 2>&1
    Write-Host "Java found: $($javaVersion[0])" -ForegroundColor Yellow
} catch {
    Write-Host "Error: Java is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Java JDK/JRE to run this game" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Run the game
try {
    java -jar PacMan.jar
} catch {
    Write-Host "Error running the game: $($_.Exception.Message)" -ForegroundColor Red
    Read-Host "Press Enter to exit"
}
