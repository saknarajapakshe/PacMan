import java.awt.*;
import java.awt.event.*;
import java.io.IOException;
import java.util.HashSet;
import java.util.Random;
import javax.swing.*;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;

public class PacMan extends JPanel implements ActionListener, KeyListener {
    class Block {
        int x;
        int y;
        int width;
        int height;
        Image image;

        int startX;
        int startY;
        char direction = 'U';
        int velocityX = 0;
        int velocityY = 0;
        char requestedDirection = 'N'; // 'N' means no direction requested

        Block(Image image, int x, int y, int width, int height) {
            this.image = image;
            this.x = x;
            this.y = y;
            this.width = width;
            this.height = height;
            this.startX = x;
            this.startY = y;
        }

        boolean isAlignedWithGrid() {
            // Check if position is aligned with the tile grid
            return (x % tileSize == 0) && (y % tileSize == 0);
        }

        void updateDirection(char newDirection) {
            // Store the requested direction even if we can't change immediately
            char requestedDirection = newDirection;

            // Only change direction immediately if aligned with grid or reversing direction
            boolean canChangeNow = isAlignedWithGrid()
                    || (requestedDirection == 'U' && direction == 'D')
                    || (requestedDirection == 'D' && direction == 'U')
                    || (requestedDirection == 'L' && direction == 'R')
                    || (requestedDirection == 'R' && direction == 'L');

            if (canChangeNow) {
                char prevDirection = this.direction;
                this.direction = requestedDirection;
                updateVelocity();

                // Move in the new direction
                this.x += this.velocityX;
                this.y += this.velocityY;

                // Check for collisions
                for (Block wall : walls) {
                    if (collision(this, wall)) {
                        this.x -= this.velocityX;
                        this.y -= this.velocityY;
                        this.direction = prevDirection;
                        updateVelocity();
                        break;
                    }
                }
            } else {
                // Store the requested direction for later use
                this.requestedDirection = requestedDirection;
            }
        }

        void updateVelocity() {
            if (this.direction == 'U') {
                this.velocityX = 0;
                this.velocityY = -tileSize / 7; // Slower speed (was /5)
            } else if (this.direction == 'D') {
                this.velocityX = 0;
                this.velocityY = tileSize / 7; // Slower speed (was /5)
            } else if (this.direction == 'L') {
                this.velocityX = -tileSize / 7; // Slower speed (was /5)
                this.velocityY = 0;
            } else if (this.direction == 'R') {
                this.velocityX = tileSize / 7; // Slower speed (was /5)
                this.velocityY = 0;
            }
        }

        void reset() {
            this.x = this.startX;
            this.y = this.startY;

        }
    }

    private int rowCount = 21;
    private int columnCount = 19;
    private int tileSize = 32;
    private int boardWidth = columnCount * tileSize;
    private int boardHeight = rowCount * tileSize;

    private Image wallImage;
    private Image blueGhosImage;
    private Image orangeGhostImage;
    private Image redGhostImage;
    private Image pinkGhostImage;
    private Image cherryImage;

    private Image pacmanUpImage;
    private Image pacmanDownImage;
    private Image pacmanLeftImage;
    private Image pacmanRightImage; // X = wall, O = skip, P = pac man, ' ' = food
    // Ghosts will be randomly placed in valid positions
    private String[] tileMap = {
            "XXXXXXXXXXXXXXXXXXX",
            "X  C     X        X",
            "X XX XXX X XXX XXCX",
            "X                 X",
            "X XX X XXXXX X XX X",
            "X    X       X    X",
            "XXXX XXXX XXXX XXXX",
            "OOOX X       X XOOO",
            "XXXX X XX XX X XXXX",
            "O C               O",
            "XXXX X XXXXX X XXXX",
            "OOOX X       X XOOO",
            "XXXX X XXXXX X XXXX",
            "X        P       CX",
            "X XX XXX X XXX XX X",
            "X  X           X  X",
            "XX X X XXXXX X X XX",
            "X    X   X   X    X",
            "X XXXXXX X XXXXXX X",
            "X  C              X",
            "XXXXXXXXXXXXXXXXXXX"
    };
    HashSet<Block> walls;
    HashSet<Block> foods;
    HashSet<Block> ghosts;
    HashSet<Block> cherries;
    Block pacman;

    Timer gameLoop;
    char[] directions = { 'U', 'D', 'L', 'R' };// Up, Down, Left, Right - ghosts
    Random random = new Random();
    int Score = 0;
    int lives = 3;
    boolean gameOver = false;
    private boolean gamePaused = false;
    private int cherriesEaten = 0;

    // Sound clips
    private Clip beginningSound;
    private Clip chompSound;
    private Clip deathSound;
    private Clip fruitSound;
    private Clip intermissionSound;

    PacMan() {
        setPreferredSize(new Dimension(boardWidth, boardHeight));
        setBackground(Color.BLACK);

        // Load the images
        wallImage = new ImageIcon(getClass().getResource("/assets/wall .png")).getImage();
        blueGhosImage = new ImageIcon(getClass().getResource("/assets/blueGhost.png")).getImage();
        redGhostImage = new ImageIcon(getClass().getResource("/assets/redGhost.png")).getImage();
        orangeGhostImage = new ImageIcon(getClass().getResource("/assets/orangeGhost.png")).getImage();
        pinkGhostImage = new ImageIcon(getClass().getResource("/assets/pinkGhost.png")).getImage();

        cherryImage = new ImageIcon(getClass().getResource("/assets/cherry.png")).getImage();

        pacmanUpImage = new ImageIcon(getClass().getResource("/assets/pacmanUp.png")).getImage();
        pacmanDownImage = new ImageIcon(getClass().getResource("/assets/pacmanDown.png")).getImage();
        pacmanLeftImage = new ImageIcon(getClass().getResource("/assets/pacmanLeft.png")).getImage();
        pacmanRightImage = new ImageIcon(getClass().getResource("/assets/pacmanRight.png")).getImage();

        loadMap();
        for (Block ghost : ghosts) {
            char newDirection = directions[random.nextInt(4)];
            ghost.updateDirection(newDirection);
        }
        gameLoop = new Timer(50, this);
        gameLoop.start();
        addKeyListener(this);
        setFocusable(true);

        // Initialize sound clips
        initSounds();
        // Play the beginning sound
        playSound(beginningSound);
    }

    // Method to initialize sound clips
    private void initSounds() {
        try {
            // Load beginning sound
            AudioInputStream beginningInputStream = AudioSystem.getAudioInputStream(
                    getClass().getResource("/assets/SoundEffects/pacman_beginning.wav"));
            beginningSound = AudioSystem.getClip();
            beginningSound.open(beginningInputStream);

            // Load chomp sound
            AudioInputStream chompInputStream = AudioSystem.getAudioInputStream(
                    getClass().getResource("/assets/SoundEffects/pacman_chomp.wav"));
            chompSound = AudioSystem.getClip();
            chompSound.open(chompInputStream);

            // Load death sound
            AudioInputStream deathInputStream = AudioSystem.getAudioInputStream(
                    getClass().getResource("/assets/SoundEffects/pacman_death.wav"));
            deathSound = AudioSystem.getClip();
            deathSound.open(deathInputStream);

            // Load fruit eating sound
            AudioInputStream fruitInputStream = AudioSystem.getAudioInputStream(
                    getClass().getResource("/assets/SoundEffects/pacman_eatfruit.wav"));
            fruitSound = AudioSystem.getClip();
            fruitSound.open(fruitInputStream);

            // Load intermission sound
            AudioInputStream intermissionInputStream = AudioSystem.getAudioInputStream(
                    getClass().getResource("/assets/SoundEffects/pacman_intermission.wav"));
            intermissionSound = AudioSystem.getClip();
            intermissionSound.open(intermissionInputStream);

        } catch (UnsupportedAudioFileException | IOException | LineUnavailableException e) {
            System.out.println("Error loading sounds: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Method to play a sound
    private void playSound(Clip clip) {
        if (clip != null) {
            if (clip.isRunning()) {
                clip.stop();
            }
            clip.setFramePosition(0);
            clip.start();
        }
    }

    public void loadMap() {
        walls = new HashSet<Block>();
        foods = new HashSet<Block>();
        ghosts = new HashSet<Block>();
        cherries = new HashSet<Block>(); // Add this line

        for (int r = 0; r < rowCount; r++) {
            for (int c = 0; c < columnCount; c++) {
                String row = tileMap[r];
                char tileMapChar = row.charAt(c); // recognize specific tile

                int x = c * tileSize;
                int y = r * tileSize;

                if (tileMapChar == 'X') {// Block wall
                    Block wall = new Block(wallImage, x, y, tileSize, tileSize);
                    walls.add(wall);
                } else if (tileMapChar == 'P') {
                    pacman = new Block(pacmanRightImage, x, y, tileSize, tileSize);
                } else if (tileMapChar == ' ') {
                    Block food = new Block(null, x + 14, y + 14, 4, 4);
                    foods.add(food);
                } else if (tileMapChar == 'C') {
                    Block cherry = new Block(cherryImage, x, y, tileSize, tileSize);
                    cherries.add(cherry); // Add cherries to the set
                }
            }
        }

        // Place ghosts randomly in valid positions
        placeGhostsRandomly();
    }

    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        draw(g);

        // Draw pause indicator if game is paused
        if (gamePaused) {
            g.setColor(Color.WHITE);
            g.setFont(new Font("Arial", Font.BOLD, 24));
            String pauseText = "PAUSED";

            // Center the text
            FontMetrics fm = g.getFontMetrics();
            int textWidth = fm.stringWidth(pauseText);
            int x = (boardWidth - textWidth) / 2;
            int y = boardHeight / 2;

            g.drawString(pauseText, x, y);
        }
    }

    public void draw(Graphics g) {
        g.drawImage(pacman.image, pacman.x, pacman.y, pacman.width, pacman.height, null);

        for (Block wall : walls) {
            g.drawImage(wall.image, wall.x, wall.y, wall.width, wall.height, null);
        }

        for (Block ghost : ghosts) {
            g.drawImage(ghost.image, ghost.x, ghost.y, ghost.width, ghost.height, null);
        }

        for (Block food : foods) {
            g.setColor(Color.WHITE);
            g.fillRect(food.x, food.y, food.width, food.height);
        }

        // Draw cherries
        for (Block cherry : cherries) {
            g.drawImage(cherry.image, cherry.x, cherry.y, cherry.width, cherry.height, null);
        }        // Update the score and lives display
        if (gameOver) {
            // Draw big red "Game Over" text in the center of the window
            g.setColor(Color.RED);
            g.setFont(new Font("Arial", Font.BOLD, 48));
            String gameOverText = "GAME OVER";
            
            // Center the text
            FontMetrics fm = g.getFontMetrics();
            int textWidth = fm.stringWidth(gameOverText);
            int x = (boardWidth - textWidth) / 2;
            int y = boardHeight / 2;
            
            g.drawString(gameOverText, x, y);
            
            // Draw final score below the game over text
            g.setColor(Color.WHITE);
            g.setFont(new Font("Arial", Font.PLAIN, 24));
            String finalScore = "Final Score: " + Score;
            FontMetrics scoreFm = g.getFontMetrics();
            int scoreWidth = scoreFm.stringWidth(finalScore);
            int scoreX = (boardWidth - scoreWidth) / 2;
            int scoreY = y + 60;
            
            g.drawString(finalScore, scoreX, scoreY);
        } else {
            g.setFont(new Font("Arial", Font.PLAIN, 18));
            g.setColor(Color.WHITE);

            // Show lives, score and cherries eaten
            String scoreText = "x" + lives + "  Score: " + Score + "  Cherries: " + cherriesEaten;
            g.drawString(scoreText, tileSize / 2, tileSize / 2);

            // Draw a small cherry icon farther away from the text
            if (cherryImage != null) {
                g.drawImage(cherryImage, tileSize / 2 + 230, tileSize / 2 - 15, 16, 16, null);
            }
        }
    }

    public void MovePacman() {
        // Apply velocity
        pacman.x += pacman.velocityX;
        pacman.y += pacman.velocityY; // Wall collision handling
        for (Block wall : walls) {
            if (collision(pacman, wall)) {
                pacman.x -= pacman.velocityX;
                pacman.y -= pacman.velocityY;
                break;
            }
        } // for ghost collisions
        for (Block ghost : ghosts) {
            if (collision(ghost, pacman)) {
                lives -= 1;
                playSound(deathSound); // Play death sound when hit by ghost
                if (lives == 0) {
                    gameOver = true;
                    return;
                }
                resetPositions();
            }

            if (ghost.y == tileSize * 9 && ghost.direction != 'U' && ghost.direction != 'D') {
                ghost.updateDirection('U');
            }

            ghost.x += ghost.velocityX;
            ghost.y += ghost.velocityY;

            for (Block wall : walls) {
                if (collision(ghost, wall) || ghost.x <= 0 || ghost.x + ghost.width >= boardWidth) {
                    ghost.x -= ghost.velocityX;
                    ghost.y -= ghost.velocityY;
                    char newDirection = directions[random.nextInt(4)];
                    ghost.updateDirection(newDirection);
                }
            }
        } // check food collisions
        Block foodEaten = null;
        for (Block food : foods) {
            if (collision(pacman, food)) {
                foodEaten = food;
                Score += 10;
            }
        }
        if (foodEaten != null) {
            foods.remove(foodEaten);
            playSound(chompSound); // Play chomp sound when eating food
        }

        // Add cherry collision handling
        Block cherryEaten = null;
        for (Block cherry : cherries) {
            if (collision(pacman, cherry)) {
                cherryEaten = cherry;
                Score += 100; // Cherry is worth 100 points
                cherriesEaten++; // Increment the cherries eaten counter
            }
        }
        if (cherryEaten != null) {
            cherries.remove(cherryEaten);
            playSound(fruitSound); // Play fruit sound when eating cherry
        } // Update win condition to check both foods and cherries
        if (foods.isEmpty() && cherries.isEmpty()) {
            playSound(intermissionSound); // Play intermission sound when level is completed
            loadMap();
            resetPositions();
        }

        // Handle screen wrap (tunnel effect)
        int boardWidth = 19 * tileSize;
        int boardHeight = 21 * tileSize;

        // Horizontal wrapping (left/right tunnel)
        if (pacman.x < 0) {
            // If Pac-Man goes beyond the left edge, wrap to right side
            pacman.x = boardWidth - pacman.width;
        } else if (pacman.x >= boardWidth) {
            // If Pac-Man goes beyond the right edge, wrap to left side
            pacman.x = 0;
        }

        if (pacman.y < 0) {
            pacman.y = boardHeight - pacman.height;
        } else if (pacman.y >= boardHeight) {
            pacman.y = 0;
        }
    }

    public boolean collision(Block a, Block b) {
        return a.x < b.x + b.width &&
                a.x + a.width > b.x &&
                a.y < b.y + b.height &&
                a.y + a.height > b.y;
    }

    public void resetPositions() {
        pacman.reset();
        pacman.velocityX = 0;
        pacman.velocityY = 0;
        for (Block ghost : ghosts) {
            ghost.reset();
            char newDirection = directions[random.nextInt(4)];
            ghost.updateDirection(newDirection);
        }
    }

    public void updatePacmanDirection() {
        // Check if there's a pending direction change and pacman is now aligned with
        // grid
        if (pacman.requestedDirection != 'N' && pacman.isAlignedWithGrid()) {
            // Try to change to the requested direction
            char prevDirection = pacman.direction;
            pacman.direction = pacman.requestedDirection;
            pacman.updateVelocity();

            // Test the new direction for collisions
            pacman.x += pacman.velocityX;
            pacman.y += pacman.velocityY;

            boolean collision = false;
            for (Block wall : walls) {
                if (collision(pacman, wall)) {
                    collision = true;
                    break;
                }
            }

            if (collision) {
                // Revert if there's a collision
                pacman.x -= pacman.velocityX;
                pacman.y -= pacman.velocityY;
                pacman.direction = prevDirection;
                pacman.updateVelocity();
            } else {
                // Clear the requested direction
                pacman.requestedDirection = 'N';

                // Update the image based on new direction
                if (pacman.direction == 'U') {
                    pacman.image = pacmanUpImage;
                } else if (pacman.direction == 'D') {
                    pacman.image = pacmanDownImage;
                } else if (pacman.direction == 'L') {
                    pacman.image = pacmanLeftImage;
                } else if (pacman.direction == 'R') {
                    pacman.image = pacmanRightImage;
                }
            }
        }
    }

    // Method to find valid spawn positions for ghosts
    private void placeGhostsRandomly() {
        // Clear existing ghosts
        ghosts.clear();

        // Create a list of all valid spawn positions (empty spaces)
        java.util.List<int[]> validPositions = new java.util.ArrayList<>();

        for (int r = 0; r < rowCount; r++) {
            for (int c = 0; c < columnCount; c++) {
                String row = tileMap[r];
                char tileMapChar = row.charAt(c);

                // Valid positions are empty spaces, but not where pacman starts
                if (tileMapChar == ' ' && !(r == 13 && c == 9)) { // Avoid pacman's starting position
                    validPositions.add(new int[] { r, c });
                }
            }
        }

        // Shuffle the list and take first 4 positions for ghosts
        java.util.Collections.shuffle(validPositions);

        // Place 4 ghosts randomly
        Image[] ghostImages = { blueGhosImage, orangeGhostImage, pinkGhostImage, redGhostImage };

        for (int i = 0; i < Math.min(4, validPositions.size()); i++) {
            int[] position = validPositions.get(i);
            int x = position[1] * tileSize;
            int y = position[0] * tileSize;

            Block ghost = new Block(ghostImages[i], x, y, tileSize, tileSize);
            ghosts.add(ghost);
        }
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        MovePacman();
        updatePacmanDirection();
        repaint();
        if (gameOver) {
            gameLoop.stop();
        }
    }

    @Override
    public void keyTyped(KeyEvent e) {
    }

    @Override
    public void keyPressed(KeyEvent e) {
        if (gameOver) {
            return;
        }        // Handle pause with space bar (from previous response)
        if (e.getKeyCode() == KeyEvent.VK_SPACE) {
            gamePaused = !gamePaused;
            if (gamePaused) {
                gameLoop.stop();
            } else {
                gameLoop.start();
            }
            repaint(); // Force a repaint to show/hide the pause text immediately
            return;
        }

        if (gamePaused) {
            return;
        }

        // Just store the requested direction
        if (e.getKeyCode() == KeyEvent.VK_UP) {
            pacman.requestedDirection = 'U';
        } else if (e.getKeyCode() == KeyEvent.VK_DOWN) {
            pacman.requestedDirection = 'D';
        } else if (e.getKeyCode() == KeyEvent.VK_LEFT) {
            pacman.requestedDirection = 'L';
        } else if (e.getKeyCode() == KeyEvent.VK_RIGHT) {
            pacman.requestedDirection = 'R';
        }
    }

    @Override
    public void keyReleased(KeyEvent e) {
        if (gameOver) {
            loadMap();
            resetPositions();
            lives = 3;
            Score = 0;
            gameOver = false;
            gameLoop.start();
            playSound(beginningSound); // Play beginning sound when game restarts
        }
    }
}
