import processing.sound.*;
SoundFile gameMusic;
PImage img;
PImage bubbleDesign;
PImage nyanCat;
PImage tacnayn;
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
int winScore = 60;
int timer = 2400;
int time = timer + 59;

void setup() {
  frameRate(60);
  size(1600, 800);
  img = loadImage("Pixel_tree.png");
  nyanCat = loadImage("nyan-cat.png");
  bubbleDesign = loadImage("pizza.png");
  tacnayn = loadImage("tacnayn.png");
  gameMusic = new SoundFile(this, "8-bit_Music.mp3");
  gameMusic.loop();
  for (int i = 0; i < numOfTrees; i++) {
    treesXPosition[i] = random(0, width-100);
    treesYPosition[i] = random(0, height-125);
  }
  for (int i = 0; i < numScoreBubbles; i++) {
    bubbleX[i] = random(75, width-75);
    bubbleY[i] = random(75, height-75);
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

void volumeSetting() {
  if (gameMusic.isPlaying() == true) {
    gameMusic.pause();
  } else if (gameMusic.isPlaying() == false) {
    gameMusic.play();
  }
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
    Text();
    x = 200;
    y = 200;
    rightEyeX = 200;
    rightEyeY = 200;
    leftEyeX = 200;
    leftEyeY = 200;
  }
}

void draw() {
  if (scoreNumber >= winScore) {
    winningScreen();
    timer = 0;
  } else if (timer <= 0) {
    losingScreen();
  } else {
    game();
  }
  if (timer < 0) {
    timer = 0;
  }
  fill(0);
  text( timer / 60 + " Seconds", 175, 50);
  noFill();
  timer--;
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
  } else if (key == 'm') {
    volumeSetting();
  }
  if (key == CODED && keyCode == SHIFT) {
    speed = 10;
    keyShift += 1;
  } else if (keyShift >= 2) {
    speed = 5;
    keyShift = 0;
  }
}
