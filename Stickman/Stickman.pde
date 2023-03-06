import processing.sound.*;
SoundFile gameMusic;
SoundFile lobbyMusic;
SoundFile winMusic;
SoundFile loseMusic;
PImage img;
PImage bubbleDesign;
PImage nyanCat;
PImage tacnayn;
PImage sadSponge;
PImage easyMode;
PImage hardMode;
PImage extremeMode;
PFont welcome;
int numOfTrees = 32;
float[] treesXPosition = new float[numOfTrees];
float[] treesYPosition = new float[numOfTrees];
float x = 200;
float y = 200;
float rightEyeX = 200;
float rightEyeY = 200;
float leftEyeX = 200;
float leftEyeY = 200;
float speed = 5;
int keyShift;
int numScoreBubbles = 28;
float[] bubbleX = new float[numScoreBubbles];
float[] bubbleY = new float[numScoreBubbles];
int redValue = (int)random(90, 255), greenValue = (int)random(90, 255), blueValue = (int)random(90, 255);
int scoreNumber = 0;
int winScore;
int timer;
int time = timer + 30;
int difficulty = 0;
int lobbySong = 0;
int gameSong = 0;
int winSong = 0;
int loseSong = 0;
int winSongVar = 1;
int loseSongVar = 1;

void setup() {
  frameRate(60);
  size(1600, 800);
  welcome = createFont("28DaysLater.ttf", 60);
  img = loadImage("Pixel_tree.png");
  nyanCat = loadImage("nyan-cat.png");
  bubbleDesign = loadImage("pizza.png");
  tacnayn = loadImage("tacnayn.png");
  sadSponge = loadImage("sadspongebob.png");
  easyMode = loadImage("easy.png");
  hardMode = loadImage("hard.png");
  extremeMode = loadImage("extreme.png");
  gameMusic = new SoundFile(this, "8-bit_Music.mp3");
  lobbyMusic = new SoundFile(this, "Lobby-Music.mp3");
  winMusic = new SoundFile(this, "win-song.mp3");
  loseMusic = new SoundFile(this, "lose-song.mp3");
  for (int i = 0; i < numOfTrees; i++) {
    treesXPosition[i] = random(0, width-100);
    treesYPosition[i] = random(0, height-125);
  }
  for (int i = 0; i < numScoreBubbles; i++) {
    bubbleX[i] = random(75, width-75);
    bubbleY[i] = random(75, height-75);
  }
}

void easy() {
  stroke(0);
  strokeWeight(5);
  fill(0, 255, 0);
  rectMode(CENTER);
  rect(400, 400, 250, 250);
  strokeWeight(0);
  noStroke();
  imageMode(CENTER);
  image(easyMode, 400, 325, 75, 75);
  fill(0);
  textSize(30);
  textAlign(CENTER);
  text("EASY", 400, 400);
  textSize(20);
  text("Reach a score of 20", 400, 425);
  text("Time: 40 seconds", 400, 450);
  textAlign(LEFT);
  noFill();
  imageMode(CORNER);
}

void hard() {
  stroke(0);
  strokeWeight(5);
  fill(255, 0, 0);
  rectMode(CENTER);
  rect(800, 400, 250, 250);
  strokeWeight(0);
  noStroke();
  imageMode(CENTER);
  image(hardMode, 800, 325, 75, 75);
  fill(0);
  textSize(30);
  textAlign(CENTER);
  text("HARD", 800, 400);
  textSize(20);
  text("Reach a score of 30", 800, 425);
  text("Time: 30 seconds", 800, 450);
  textAlign(LEFT);
  noFill();
  imageMode(CORNER);
}

void extreme() {
  stroke(0);
  strokeWeight(5);
  fill(180, 0, 255);
  rectMode(CENTER);
  rect(1200, 400, 250, 250);
  strokeWeight(0);
  noStroke();
  imageMode(CENTER);
  image(extremeMode, 1200, 325, 75, 75);
  fill(0);
  textSize(30);
  textAlign(CENTER);
  text("EXTREME", 1200, 400);
  textSize(20);
  text("Reach a score of 40", 1200, 425);
  text("Time: 20 seconds", 1200, 450);
  textAlign(LEFT);
  noFill();
  imageMode(CORNER);
}

void chooseDifficulty() {
  background(255);
  textFont(welcome);
  textAlign(CENTER);
  textSize(100);
  text("STICKMAN", width/2, 175);
  textAlign(LEFT);
  easy();
  hard();
  extreme();
  if (dist(400, 400, mouseX, mouseY) < 125 && mousePressed) {
    difficulty += 1;
    gameSong += 1;
    winScore = 20;
    timer = 2400;
  } else if (dist(800, 400, mouseX, mouseY) < 125 && mousePressed) {
    difficulty += 1;
    gameSong += 1;
    winScore = 30;
    timer = 1800;
  } else if (dist(1200, 400, mouseX, mouseY) < 125 && mousePressed) {
    difficulty += 1;
    gameSong += 1;
    winScore = 40;
    timer = 1200;
  }
}

void game() {
  background(255);
  spawnTrees();
  player();
  Text();
  drawBubbles();
}

void winningScreen() {
  background(255);
  noStroke();
  y += 1000;
  fill(255, 255, 0);
  rectMode(CENTER);
  rect(width/2, height/2, 1000, 250);
  imageMode(CENTER);
  image(nyanCat, (width/2)-500, height/2, 250, 250);
  image(nyanCat, (width/2)+500, height/2, 250, 250);
  fill(0);
  textSize(30);
  textAlign(CENTER);
  text("YOU WON", width/2, height/2);
  textAlign(LEFT);
  text("Press 'r' to reset", width-230, height-50);
}

void losingScreen() {
  background(255);
  noStroke();
  y += 1000;
  fill(255, 0, 0);
  rectMode(CENTER);
  rect(width/2, height/2, 1000, 250);
  imageMode(CENTER);
  image(tacnayn, (width/2)-500, height/2, 250, 250);
  image(tacnayn, (width/2)+500, height/2, 250, 250);
  image(sadSponge, width/2, 662.5, 250, 250);
  fill(0);
  textSize(30);
  textAlign(CENTER);
  text("YOU LOST", width/2, height/2);
  textAlign(LEFT);
  text("Press 'r' to reset", width-230, height-50);
}

void drawBubbles() {
  for (int i = 0; i < numScoreBubbles; i++) {
    fill(redValue, greenValue, blueValue);
    noStroke();
    ellipse(bubbleX[i], bubbleY[i], 37, 37);
    image(bubbleDesign, bubbleX[i]-18, bubbleY[i]-18, 37, 37);
    stroke(1);
    noFill();
    if (dist(bubbleX[i], bubbleY[i], x, y) <50) {
      bubbleX[i]-=1700;
      bubbleY[i]-=1000;
      scoreNumber +=1;
      setNewBubblePos(i);
    }
  }
}

void Text() {
  textSize(35);
  fill(0);
  text("Score " + scoreNumber, width-175, 50);
  textSize(30);
  text("Press 'r' to reset", width-230, height-50);
  text("Press 'Shift' to sprint", 35, height-50);
  noFill();
}

void player() {
  strokeWeight(2);
  line(x, y, x, y+40);
  line(x, y+40, x+20, y+100);
  line(x, y+40, x-20, y+100);
  line(x, y+10, x+20, y+40);
  line(x, y+10, x-20, y+40);
  fill(255);
  ellipse(x, y-12.5, 25, 25);
  noFill();
  ellipse(rightEyeX+4.5, rightEyeY-16.1, 4.5, 4.5);
  ellipse(leftEyeX-4.5, leftEyeY-16.1, 4.5, 4.5);
}

void spawnTrees() {
  for (int i = 0; i < numOfTrees; i++) {
    image(img, treesXPosition[i], treesYPosition[i], 100, 100);
  }
}

void setNewBubblePos (int index) {
  bubbleX[index] = random(75, width-75);
  bubbleY[index] = random(75, height-75);
}

void setAllBubblePosAndResetGame() {
  for (int i = 0; i < numScoreBubbles; i++) {
    setNewBubblePos(i);
    imageMode(CORNER);
    scoreNumber = 0;
    keyShift = 0;
    speed = 5;
    timer = time;
    difficulty = 0;
    lobbySong = 0;
    gameSong = 0;
    winSong = 0;
    loseSong = 0;
    winSongVar = 1;
    loseSongVar = 1;
    Text();
    x = 200;
    y = 200;
    rightEyeX = 200;
    rightEyeY = 200;
    leftEyeX = 200;
    leftEyeY = 200;

    if (lobbyMusic.isPlaying() == true) {
      lobbyMusic.stop();
    } else if (gameMusic.isPlaying() == true) {
      gameMusic.stop();
    } else if (winMusic.isPlaying() == true) {
      winMusic.stop();
    } else if (loseMusic.isPlaying() == true) {
      loseMusic.stop();
    } else {
      break;
    }
  }
}

void draw() {
  if (difficulty < 1) {
    chooseDifficulty();
  } else if (scoreNumber >= winScore) {
    winningScreen();
    timer = 0;
    winSong = winSongVar;
  } else if (timer <= 0) {
    losingScreen();
    loseSong = loseSongVar;
  } else {
    game();
    fill(0);
    text( timer / 60 + " Seconds", 50, 50);
    noFill();
    timer -= 2;
  }
  if (timer < 0) {
    timer = 0;
  }
  if (lobbySong < 1) {
    lobbyMusic.loop();
    lobbySong += 1;
  } else if (gameSong == 1) {
    lobbyMusic.stop();
    gameMusic.loop();
    gameSong += 1;
  } else if ( winSong == 1) {
    gameMusic.stop();
    winMusic.loop();
    winSongVar += 1;
  } else if ( loseSong == 1) {
    gameMusic.stop();
    loseMusic.play();
    loseSongVar +=1;
  }
}
void upwards() {
  player();
  rightEyeX = 2000;
  rightEyeY = 1000;
  leftEyeX = 2000;
  leftEyeY = 1000;
  y -= speed;
}

void downwards() {
  player();
  if (keyShift == 0) {
    rightEyeX = x;
    rightEyeY = y+5;
    leftEyeX = x;
    leftEyeY = y+5;
  } else {
    rightEyeX = x;
    rightEyeY = y+10;
    leftEyeX = x;
    leftEyeY = y+10;
  }

  ellipse(rightEyeX+4.5, rightEyeY-16.1, 4.5, 4.5);
  ellipse(leftEyeX-4.5, leftEyeY-16.1, 4.5, 4.5);
  y += speed;
}

void right() {
  player();
  if (keyShift == 0) {
    rightEyeX = x+5;
    rightEyeY = y;
  } else {
    rightEyeX = x+10;
    rightEyeY = y;
  }
  leftEyeX = x;
  leftEyeY = y-1000;
  ellipse(rightEyeX+4.5, rightEyeY-16.1, 4.5, 4.5);
  ellipse(leftEyeX+4.5, leftEyeY-16.1, 4.5, 4.5);
  x += speed;
}

void left() {
  player();
  if (keyShift == 0) {
    leftEyeX = x-5;
    leftEyeY = y;
  } else {
    leftEyeX = x-10;
    leftEyeY = y;
  }
  rightEyeX = x+5;
  rightEyeY = y-1000;
  ellipse(rightEyeX+4.5, rightEyeY-16.1, 4.5, 4.5);
  ellipse(leftEyeX+4.5, leftEyeY-16.1, 4.5, 4.5);
  x -= speed;
}

void keyPressed() {
  if (key == 'w' && y > 30) {
    upwards();
  } else if (key == 'a' && x > 35) {
    left();
  } else if (key == 's' && y < height -125) {
    downwards();
  } else if (key == 'd' && x < width -35) {
    right();
  } else if (key == 'r') {
    setAllBubblePosAndResetGame();
  }

  if (key == CODED && keyCode == SHIFT) {
    speed = 10;
    keyShift += 1;
  } else if (keyShift >= 2) {
    speed = 5;
    keyShift = 0;
  }
}
