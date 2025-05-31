# 🎮 PacMan Game

A classic PacMan arcade game built in Java using **Object-Oriented Programming (OOP) concepts**.

## ✨ Special Features

- **Java OOP Implementation**: Demonstrates core OOP principles including:
  - **Encapsulation**: Game logic encapsulated in separate classes
  - **Inheritance**: Extends JPanel for custom game rendering
  - **Polymorphism**: Different ghost behaviors through method overriding
  - **Abstraction**: Clean separation between game logic and UI

## 🎯 Game Features

- Navigate PacMan through a maze collecting food
- Collect power pellets to eat ghosts temporarily
- Sound effects and scoring system
- Pause/resume and restart functionality

## 🎮 Controls

- **Arrow Keys**: Move PacMan
- **Spacebar**: Pause/Resume
- **Enter**: Restart (when game over)

## 🚀 How to Run

### Easy Way (JAR File)
```bash
java -jar PacMan.jar
```

### From Source
1. Compile: `javac -cp src src/*.java -d bin`
2. Copy assets: `xcopy src\assets bin\assets /E /I /Y`
3. Run: `java -cp bin App`

## 📋 Requirements

- Java 8 or higher

## 📁 Project Structure

```
PacMan/
├── src/
│   ├── App.java          # Main entry point (JFrame setup)
│   ├── PacMan.java       # Game logic (OOP implementation)
│   └── assets/           # Images and sounds
├── PacMan.jar            # Executable file
└── README.md
```

## 🎨 Technical Details

- **Language**: Java with **OOP Design Patterns**
- **GUI Framework**: Swing (JFrame, JPanel)
- **Resolution**: 608x672 pixels
- **Architecture**: Object-oriented game structure

---

**A perfect example of Java OOP in game development!** 👾
