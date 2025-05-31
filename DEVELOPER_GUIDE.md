# PacMan Game - Developer Documentation

## 📋 Table of Contents
1. [Project Overview](#project-overview)
2. [Architecture](#architecture)
3. [Development Setup](#development-setup)
4. [Building the Game](#building-the-game)
5. [Code Structure](#code-structure)
6. [Asset Management](#asset-management)
7. [Distribution](#distribution)
8. [Troubleshooting](#troubleshooting)
9. [Contributing](#contributing)

## 🎮 Project Overview

This is a classic PacMan game implementation written in Java using Swing for the graphical user interface. The game features:

- Classic PacMan gameplay mechanics
- Animated sprites for PacMan and ghosts
- Sound effects for various game events
- Power pellets and scoring system
- Multiple ghost AI behaviors
- Smooth keyboard controls

### Technical Specifications
- **Language**: Java 8+
- **GUI Framework**: Java Swing
- **Audio**: WAV sound files
- **Graphics**: PNG sprite images
- **Build System**: Batch scripts for Windows

## 🏗️ Architecture

### Core Classes

#### `App.java`
- **Purpose**: Main entry point and window setup
- **Responsibilities**:
  - Creates the main JFrame window
  - Sets up window properties (size, title, close behavior)
  - Initializes the PacMan game instance
  - Handles window focus and visibility

```java
public class App {
    public static void main(String[] args) throws Exception {
        // Window configuration
        int rowCount = 21;
        int columnCount = 19;
        int tileSize = 32;
        // ... game initialization
    }
}
```

#### `PacMan.java`
- **Purpose**: Main game logic and rendering
- **Key Components**:
  - Game loop and timing
  - Player input handling
  - Ghost AI and movement
  - Collision detection
  - Score management
  - Audio playback

### Game Board
- **Dimensions**: 21 rows × 19 columns
- **Tile Size**: 32×32 pixels
- **Total Window Size**: 608×672 pixels

## 🛠️ Development Setup

### Prerequisites
1. **Java Development Kit (JDK)**: Version 8 or higher
2. **Text Editor/IDE**: VS Code, IntelliJ IDEA, or Eclipse
3. **Command Line**: Windows Command Prompt or PowerShell

### Environment Setup
```bash
# Verify Java installation
java -version
javac -version

# Clone or download the project
# Navigate to project directory
cd c:\path\to\PacMan\PacMan
```

### Project Structure
```
PacMan/
├── src/                    # Source code
│   ├── App.java           # Main class
│   ├── PacMan.java        # Game logic
│   └── assets/            # Game assets
│       ├── *.png          # Sprite images
│       └── SoundEffects/  # Audio files
├── bin/                   # Compiled classes
├── lib/                   # External libraries
├── MANIFEST.MF           # JAR manifest
└── *.bat                 # Build scripts
```

## 🔨 Building the Game

### Method 1: Using Build Script (Recommended)
```bash
# Run the automated build script
.\BuildGame.bat
```

This script performs:
1. Cleans previous builds
2. Compiles Java source files
3. Copies assets to build directory
4. Creates executable JAR file
5. Generates distribution packages

### Method 2: Manual Build
```bash
# Create build directory
mkdir bin

# Compile Java files
javac -d bin src/*.java

# Copy assets
xcopy /E /I src\assets bin\assets

# Create JAR file
jar cfm PacMan.jar MANIFEST.MF -C bin .
```

### Build Outputs
- **`PacMan.jar`**: Executable Java archive
- **`bin/`**: Compiled class files and assets
- **`PacMan-Distribution/`**: Ready-to-distribute folder
- **`PacMan-Game-v1.0.zip`**: Compressed distribution

## 📁 Code Structure

### Main Game Loop
The game follows a standard game loop pattern:

1. **Input Processing**: Handle keyboard events
2. **Update Logic**: Move entities, check collisions
3. **Render**: Draw game state to screen
4. **Timing**: Maintain consistent frame rate

### Key Methods in PacMan.java

#### `paintComponent(Graphics g)`
- Renders the game board and all entities
- Called automatically by Swing's repaint system

#### `actionPerformed(ActionEvent e)`
- Main game loop method (called by Timer)
- Updates game state each frame

#### `keyPressed(KeyEvent e)`
- Handles player input
- Maps arrow keys to PacMan movement

### Collision Detection
- Grid-based collision system
- Checks for wall collisions before movement
- Detects PacMan-ghost interactions
- Handles food/power pellet collection

## 🎨 Asset Management

### Sprite Assets
Located in `src/assets/`:

#### Character Sprites
- `pacmanUp.png`, `pacmanDown.png`, `pacmanLeft.png`, `pacmanRight.png`
- `redGhost.png`, `blueGhost.png`, `pinkGhost.png`, `orangeGhost.png`
- `scaredGhost.png` (when ghosts are vulnerable)

#### Game Objects
- `wall.png` - Maze walls
- `powerFood.png` - Power pellets
- `cherry.png`, `cherry2.png` - Bonus fruits

### Audio Assets
Located in `src/assets/SoundEffects/`:
- `pacman_beginning.wav` - Game start sound
- `pacman_chomp.wav` - Eating pellets
- `pacman_death.wav` - Game over
- `pacman_eatfruit.wav` - Bonus items
- `pacman_intermission.wav` - Level transitions

### Asset Loading
```java
// Example asset loading
Image image = new ImageIcon(getClass().getResource("/assets/pacmanUp.png")).getImage();
```

## 📦 Distribution

### Available Distribution Methods

#### 1. JAR Distribution
- **File**: `PacMan.jar`
- **Target**: Java developers and advanced users
- **Usage**: `java -jar PacMan.jar`

#### 2. ZIP Package
- **File**: `PacMan-Game-v1.0.zip`
- **Target**: General users
- **Contents**: JAR + runner script + documentation

#### 3. Installer Packages
- **Simple Installer**: `PacMan-Simple-Installer.zip`
- **Portable Installer**: `PacMan-Portable-Installer.zip`
- **Features**: Desktop shortcuts, Start Menu entries, uninstaller

### Creating Distribution Packages

```bash
# Create all distribution packages
.\BuildGame.bat

# Create specific installer types
.\CreateSimpleInstaller.bat
.\CreatePortableInstaller.bat
```

## 🐛 Troubleshooting

### Common Build Issues

#### "Java not found" Error
```bash
# Check Java installation
java -version
javac -version

# Add Java to PATH if needed
set PATH=%PATH%;C:\Program Files\Java\jdk-11\bin
```

#### Asset Loading Failures
- Ensure assets are in `src/assets/` directory
- Check file names match exactly (case-sensitive)
- Verify images are valid PNG format
- Confirm audio files are WAV format

#### JAR Execution Issues
```bash
# Check JAR manifest
jar tf PacMan.jar | findstr MANIFEST

# Verify main class in manifest
jar xf PacMan.jar META-INF/MANIFEST.MF
type META-INF\MANIFEST.MF
```

### Runtime Issues

#### Game Window Not Appearing
- Check for Java Swing EDT issues
- Verify display resolution compatibility
- Test with different Java versions

#### Audio Not Playing
- Confirm WAV files are uncompressed
- Check audio drivers and system volume
- Test with different audio file formats

#### Performance Issues
- Reduce timer frequency if needed
- Optimize image loading and caching
- Check system resource usage

## 🤝 Contributing

### Development Guidelines

#### Code Style
- Use camelCase for variable names
- Add comments for complex logic
- Keep methods focused and small
- Follow Java naming conventions

#### Adding New Features
1. Create feature branch
2. Implement changes in appropriate classes
3. Test thoroughly
4. Update documentation
5. Submit pull request

#### Asset Guidelines
- Use PNG format for images (32×32 pixels recommended)
- Use WAV format for audio (16-bit, 44.1kHz)
- Maintain consistent art style
- Optimize file sizes

### Testing Checklist
- [ ] Game compiles without errors
- [ ] All sprites load correctly
- [ ] Audio plays on all events
- [ ] Controls respond properly
- [ ] Game logic works as expected
- [ ] Distribution packages work on clean systems

### Version Control
```bash
# Commit changes
git add .
git commit -m "Add new feature: ghost AI improvement"

# Tag releases
git tag -a v1.1 -m "Version 1.1 - Enhanced gameplay"
```

## 📝 Additional Resources

### Useful Commands
```bash
# Quick test run
java -jar PacMan.jar

# Rebuild everything
.\BuildGame.bat

# Create installer
.\CreateSimpleInstaller.bat

# Check JAR contents
jar tf PacMan.jar
```

### File Locations
- **Source Code**: `src/`
- **Compiled Classes**: `bin/`
- **Distribution**: `PacMan-Distribution/`
- **Installers**: `*-Installer/`
- **Documentation**: `*.md` files

---

## 🎯 Next Steps

1. **Test Your Changes**: Always test on a clean system
2. **Document Updates**: Update this file when adding features
3. **User Feedback**: Gather feedback from players
4. **Performance**: Profile and optimize as needed
5. **Cross-Platform**: Consider Linux/Mac compatibility

Happy coding! 🎮
