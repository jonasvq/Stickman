import processing.sound.*;
SoundFile Music;
PImage img;
int numTrees = 25;
float[] xTrees = new float[numTrees];
float[] yTrees = new float[numTrees];
float x = 200;
float y = 200;
float rightEyeX = 200;
float rightEyeY = 200;
float leftEyeX = 200;
float leftEyeY = 200;
float speed = 5;
int keyShift;
int numScoreBubbles = 12;
float[] xPos = new float[numScoreBubbles];
float[] yPos = new float[numScoreBubbles];
int R = (int)random(90, 255), G = (int)random(90, 255), B = (int)random(90, 255);
int scoreNumber = 0;

void setup() {
  frameRate(60);
  size(1600, 800);
  img = loadImage("Pixel_tree.png");
  //Music = new SoundFile(this, "8-bit_Music.mp3");
  //Music.loop();
  for (int i = 0; i < numTrees; i++) {
    xTrees[i] = random(125, width-125);
    yTrees[i] = random(125, height-125);
  }
  for (int i = 0; i < numScoreBubbles; i++) {
    xPos[i] = random(750, width-75);
    yPos[i] = random(75, height-75);
  }
}


void spawnTrees() {
  for (int i = 0; i < numTrees; i++) {
    image(img, xTrees[i], yTrees[i], 100.0, 100.0);
  }
}

void setNewBubblePos (int index) {
  xPos[index] = random(75, width-75);
  yPos[index] = random(75, height-75);
}

void setAllBubblePos() {
  for (int i = 0; i < numScoreBubbles; i++) {
    setNewBubblePos(i);
    keyShift = 0;
    scoreNumber = 0;
  }
}

void draw() {
  background(255);
  spawnTrees();
  strokeWeight(3);
  line(x, y, x, y+40);
  line(x, y+40, x+20, y+100);
  line(x, y+40, x-20, y+100);
  line(x, y+10, x+20, y+35);
  line(x, y+10, x-20, y+35);
  fill(255);
  ellipse(x, y-12.5, 25, 25);
  noFill();
  ellipse(rightEyeX+4.5, rightEyeY-16.1, 4.5, 4.5);
  ellipse(leftEyeX-4.5, leftEyeY-16.1, 4.5, 4.5);

  for (int i = 0; i < numScoreBubbles; i++) {
    fill(R, G, B);
    ellipse(xPos[i], yPos[i], 25, 25);
    noFill();
    if (dist(xPos[i], yPos[i], x, y) <50) {
      xPos[i]-=1700;
      yPos[i]-=1000;
      scoreNumber +=1;
      setNewBubblePos(i);
    }
  }
  textSize(35);
  text(scoreNumber + " Punkte", width-175, 100);
}

void upwards() {
  strokeWeight(2);
  line(x, y, x, y+40);
  line(x, y+40, x+20, y+100);
  line(x, y+40, x-20, y+100);
  line(x, y+10, x+20, y+35);
  line(x, y+10, x-20, y+35);
  ellipse(x, y-12.5, 25, 25);
  rightEyeX = 2000;
  rightEyeY = 1000;
  leftEyeX = 2000;
  leftEyeY = 1000;
  y -= speed;
}

void downwards() {
  strokeWeight(2);
  line(x, y, x, y+40);
  line(x, y+40, x+20, y+100);
  line(x, y+40, x-20, y+100);
  line(x, y+10, x+20, y+35);
  line(x, y+10, x-20, y+35);
  ellipse(x, y-12.5, 25, 25);
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
  strokeWeight(2);
  line(x, y, x, y+40);
  line(x, y+40, x+20, y+100);
  line(x, y+40, x-20, y+100);
  line(x, y+10, x+20, y+35);
  line(x, y+10, x-20, y+35);
  ellipse(x, y-12.5, 25, 25);
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
  strokeWeight(2);
  line(x, y, x, y+40);
  line(x, y+40, x+20, y+100);
  line(x, y+40, x-20, y+100);
  line(x, y+10, x+20, y+35);
  line(x, y+10, x-20, y+35);
  ellipse(x, y-12.5, 25, 25);
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
  if (key == 'w' && y > 25) {
    upwards();
  } else if (key == 'a' && x > 35) {
    left();
  } else if (key == 's' && y < height -125) {
    downwards();
  } else if (key == 'd' && x < width -35) {
    right();
  } else if (key == 'r') {
    setAllBubblePos();
  }
  if (key == CODED && keyCode == SHIFT) {
    speed = 10;
    keyShift += 1;
  } else if (keyShift == 2) {
    speed = 5;
    keyShift = 0;
  }
}
