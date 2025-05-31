# PacMan Game - User Manual

## 🎮 Welcome to PacMan!

This is a classic implementation of the beloved PacMan arcade game. Navigate through the maze, collect pellets, avoid ghosts, and achieve the highest score possible!

## 📋 Table of Contents
1. [Installation](#installation)
2. [How to Play](#how-to-play)
3. [Controls](#controls)
4. [Game Features](#game-features)
5. [Scoring System](#scoring-system)
6. [Tips & Strategies](#tips--strategies)
7. [Troubleshooting](#troubleshooting)
8. [System Requirements](#system-requirements)

## 💾 Installation

### Quick Start (No Installation Required)
1. Download `PacMan-Game-v1.0.zip`
2. Extract the ZIP file to any folder
3. Double-click `RunPacMan.bat`
4. Start playing!

### Full Installation (Recommended)
1. Download `PacMan-Simple-Installer.zip`
2. Extract the ZIP file
3. Right-click `Install.bat` and select "Run as Administrator"
4. Follow the installation prompts
5. Use the desktop shortcut to play

### Alternative Installation Methods
- **Portable Installer**: `PacMan-Portable-Installer.zip` - Choose custom install location
- **JAR File**: `PacMan.jar` - For Java developers (requires Java knowledge)

## 🎯 How to Play

### Objective
Navigate PacMan through the maze to collect all the small dots (pellets) while avoiding the colorful ghosts. Complete the level by eating all pellets!

### Basic Gameplay
1. **Start the Game**: PacMan begins in the center-bottom of the maze
2. **Move Around**: Use arrow keys to navigate through the maze corridors
3. **Collect Pellets**: Eat the small white dots scattered throughout the maze
4. **Avoid Ghosts**: Stay away from the colored ghosts (Red, Blue, Pink, Orange)
5. **Use Power Pellets**: Eat large flashing dots to temporarily turn ghosts vulnerable
6. **Eat Vulnerable Ghosts**: When ghosts turn blue, you can eat them for bonus points
7. **Collect Bonuses**: Grab cherry and other fruit items for extra points

### Winning
Complete the level by eating all the small pellets in the maze. The game will advance to the next level with increased difficulty.

### Game Over
The game ends when PacMan touches a ghost that isn't in vulnerable (blue) state. You'll hear a distinctive sound effect when this happens.

## 🎮 Controls

### Keyboard Controls
- **↑ Arrow Key**: Move PacMan up
- **↓ Arrow Key**: Move PacMan down
- **← Arrow Key**: Move PacMan left
- **→ Arrow Key**: Move PacMan right
- **SPACE**: Pause/Resume the game
- **ESC**: Exit the game

### Control Tips
- **Smooth Movement**: Hold down arrow keys for continuous movement
- **Direction Queuing**: Press a direction key before reaching an intersection to turn immediately
- **Wall Collision**: PacMan will stop if you try to move into a wall
- **Responsive Controls**: The game responds instantly to your input

## ✨ Game Features

### Characters

#### PacMan (Yellow)
- **Your Character**: The yellow circle that eats pellets
- **Animation**: Changes sprite direction based on movement
- **Lives**: You have multiple lives (game over when all are lost)

#### Ghosts
- **Red Ghost (Blinky)**: Aggressive, directly chases PacMan
- **Pink Ghost (Pinky)**: Tries to ambush PacMan by targeting ahead of him
- **Blue Ghost (Inky)**: Unpredictable movement pattern
- **Orange Ghost (Clyde)**: Switches between chasing and fleeing

#### Vulnerable State
- **Blue Ghosts**: When PacMan eats a power pellet, all ghosts turn blue
- **Eating Ghosts**: While blue, ghosts can be eaten for bonus points
- **Duration**: Vulnerability lasts for a limited time
- **Warning**: Ghosts flash before returning to normal

### Game Elements

#### Pellets (Small Dots)
- **Standard Food**: Small white dots throughout the maze
- **Point Value**: 10 points each
- **Objective**: Collect all to complete the level

#### Power Pellets (Large Dots)
- **Location**: Four corners of the maze
- **Effect**: Makes all ghosts vulnerable for a short time
- **Point Value**: 50 points each
- **Strategy**: Save for when you're in danger or want to score big

#### Bonus Items
- **Cherries**: Appear occasionally in the center of the maze
- **Point Value**: 100-300 points each
- **Timing**: Limited time to collect before they disappear

## 🏆 Scoring System

### Point Values
- **Small Pellet**: 10 points
- **Power Pellet**: 50 points
- **First Ghost**: 200 points
- **Second Ghost**: 400 points
- **Third Ghost**: 800 points
- **Fourth Ghost**: 1600 points
- **Cherry**: 100 points
- **Other Fruits**: 200-300 points

### Scoring Tips
- **Ghost Combos**: Eat multiple ghosts during one power pellet for maximum points
- **Fruit Timing**: Grab bonus fruits quickly before they disappear
- **Efficient Routes**: Plan your path to maximize pellet collection
- **Power Pellet Strategy**: Use power pellets when surrounded by ghosts

## 💡 Tips & Strategies

### Beginner Tips
1. **Learn the Maze**: Memorize the layout and tunnel locations
2. **Use Corners**: Ghosts move slower around tight corners
3. **Tunnel Escape**: Use the side tunnels to escape from ghosts
4. **Power Pellet Timing**: Save power pellets for emergencies
5. **Pattern Recognition**: Each ghost has predictable behavior patterns

### Advanced Strategies
1. **Ghost Herding**: Group ghosts together before eating a power pellet
2. **Fruit Prioritization**: Balance between pellets and bonus fruit collection
3. **Corner Trapping**: Use maze corners to avoid multiple ghosts
4. **Speed Management**: Don't rush - controlled movement is better
5. **Audio Cues**: Listen for sound effects to understand game state

### Pro Tips
- **Preemptive Turning**: Press direction keys early at intersections
- **Ghost Behavior**: Learn each ghost's unique AI pattern
- **Safe Zones**: Identify areas where you can safely plan your next move
- **Risk vs Reward**: Weigh the points against the danger of each move

## 🔧 Troubleshooting

### Game Won't Start

#### Java Not Found
**Problem**: "Java is not recognized" error
**Solution**: 
1. Install Java from https://www.java.com
2. Restart your computer
3. Try running the game again

#### Missing Files
**Problem**: Game crashes immediately
**Solution**:
1. Ensure all files from the ZIP are extracted together
2. Don't move files out of the game folder
3. Re-download if files are missing

### Performance Issues

#### Slow Gameplay
**Problem**: Game runs slowly or choppy
**Solution**:
1. Close other applications
2. Update Java to the latest version
3. Restart your computer
4. Check system resource usage

#### No Sound
**Problem**: Game plays but no audio
**Solution**:
1. Check system volume settings
2. Ensure audio drivers are updated
3. Try running as Administrator
4. Test with other audio applications

### Display Issues

#### Window Too Small/Large
**Problem**: Game window doesn't fit screen
**Solution**:
1. Check display resolution settings
2. Try different screen scaling options
3. Update graphics drivers

#### Graphics Problems
**Problem**: Missing sprites or corrupted images
**Solution**:
1. Update graphics drivers
2. Try running in compatibility mode
3. Re-download the game files

### Getting Help
If you continue experiencing issues:
1. Check the `INSTALLATION_GUIDE.md` for more details
2. Verify your system meets the requirements
3. Try the alternative installation methods
4. Restart your computer and try again

## 💻 System Requirements

### Minimum Requirements
- **Operating System**: Windows 7 or later
- **Processor**: 1 GHz or faster
- **Memory**: 512 MB RAM
- **Storage**: 50 MB available space
- **Java**: Version 8 or higher
- **Graphics**: DirectX 9 compatible
- **Sound**: Windows compatible audio device

### Recommended Requirements
- **Operating System**: Windows 10 or later
- **Processor**: 2 GHz dual-core
- **Memory**: 1 GB RAM
- **Storage**: 100 MB available space
- **Java**: Latest version
- **Graphics**: Dedicated graphics card
- **Sound**: High-quality audio system for best experience

### Compatibility
- **Windows Versions**: 7, 8, 8.1, 10, 11
- **Java Versions**: 8, 11, 17, 21+
- **Architecture**: 32-bit and 64-bit systems
- **Display**: Any resolution 800×600 or higher

---

## 🎊 Have Fun!

You're now ready to enjoy the classic PacMan experience! Remember to:
- Take breaks during long gaming sessions
- Challenge friends to beat your high score
- Experiment with different strategies
- Most importantly, have fun!

**Waka waka waka!** 👾

---

*For technical issues or feedback, refer to the DEVELOPER_GUIDE.md or INSTALLATION_GUIDE.md files included with your game.*
