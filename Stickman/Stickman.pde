import processing.sound.*;
SoundFile Music;
PImage unmute;
PImage mute;
PImage img;
PImage bubbleEffect;
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

  void setup() {
  frameRate(60);
  size(1600, 800);
  img = loadImage("Pixel_tree.png");
  unmute = loadImage("Volume_On.png");
  mute = loadImage("mute.png");
  bubbleEffect = loadImage("Bubble_effects.png"); 
  Music = new SoundFile(this, "8-bit_Music.mp3");
  Music.loop();
  for (int i = 0; i < numOfTrees; i++) {
    treesXPosition[i] = random(0, width-100);
    treesYPosition[i] = random(0, height-125);
  }
  for (int i = 0; i < numScoreBubbles; i++) {
    bubbleX[i] = random(75, width-75);
    bubbleY[i] = random(75, height-75);
  }
}

void volumeSetting(){
  if(Music.isPlaying() == true){
       Music.pause();
  } else if(Music.isPlaying() == false){
        Music.play();
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

void setAllBubblePos() {
  for (int i = 0; i < numScoreBubbles; i++) {
    setNewBubblePos(i);
    //keyShift = 0;
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
    fill(redValue, greenValue, blueValue);
    noStroke();
    ellipse(bubbleX[i], bubbleY[i], 25, 25);
    image(bubbleEffect, bubbleX[i]-12, bubbleY[i]-12, 25, 25);
    stroke(1);
    noFill();
    if (dist(bubbleX[i], bubbleY[i], x, y) <50) {
      bubbleX[i]-=1700;
      bubbleY[i]-=1000;
      scoreNumber +=1;
      setNewBubblePos(i);
    }
  }
  textSize(35);
  fill(0);
  text(scoreNumber + " Punkte", width-175, 50);
  textSize(25);
  text("Press 'r' to reset", width-200, height-50);
  noFill();
println(keyShift);
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
