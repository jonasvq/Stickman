class stickman {
 int xPos, yPos;
 int speed = 5;
 int lEyeX = 400, lEyeY = 400, rEyeX = 400, rEyeY = 400;
 
 stickman(int x, int y) {
   xPos = x;
   yPos = y;
   leftEyeX = lEyeX;
   leftEyeY = lEyeY;
   rightEyeX = rEyeX;
   rightEyeY = rEyeY;
 }
 void display(){
   strokeWeight(2);
  line(xPos, yPos, xPos, yPos+40);
  line(xPos, yPos+40, xPos+20, yPos+100);
  line(xPos, yPos+40, xPos-20, yPos+100);
  line(xPos, yPos+10, xPos+20, yPos+40);
  line(xPos, yPos+10, xPos-20, yPos+40);
  fill(255);
  ellipse(xPos, yPos-12.5, 25, 25);
  noFill();
  ellipse(rEyeX+4.5, rEyeY-16.1, 4.5, 4.5);
  ellipse(lEyeX-4.5, lEyeY-16.1, 4.5, 4.5);
 }
 void goRight(){
   xPos += speed;
   rEyeY = yPos;
   rEyeX = xPos;
   rEyeX += speed;
   lEyeX = 2000;
   rEyeX = xPos;
   
    
}
void goLeft(){
   xPos -= speed;
   lEyeY = yPos;
   lEyeX = xPos+5; 
   lEyeX -= speed;
   rEyeX = 2000; 
   lEyeX = xPos;
   
}
void goUp(){
   yPos -= speed; 
   lEyeY = 2000; 
   rEyeY = 2000; 
}
void goDown(){
   yPos += speed; 
   lEyeY = yPos-5; 
   lEyeX = xPos; 
   rEyeY = yPos-5; 
   rEyeX = xPos; 
   lEyeY += 5; 
   rEyeY += 5;
}
void sprint(){
 speed = 10; 
}
void walk(){
  speed = 5;
}
void ypos(){
  y = yPos;
}
void xpos(){
  x = xPos;
}

}
