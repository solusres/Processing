// responds to mouse movement

import gifAnimation.*;
GifMaker gifExport;
boolean EXPORT = false;

int SIZE = 500;
int ROWS = 20;
int INC = SIZE/ROWS;

void setup() {
  size(SIZE, SIZE, P2D);
  smooth();
  
  stroke(255);
  
  if (EXPORT) {
    gifExport = new GifMaker(this, "export.gif");
    gifExport.setRepeat(0);
  }
}

void draw() {
  background(0);
  
  float a = radians(frameCount*2);
  float size;
  float offset;
  
  for (int x=INC; x < SIZE; x+=INC) {
    for (int y=INC; y < SIZE; y+=INC) {
      pushMatrix();
      translate(x, y);
      
      offset = (pow((mouseX-x),2)+pow((mouseY-y),2))/pow((SIZE/2),2);
      size = cos(a-offset) * INC;
      ellipse(0, 0, size, size);
      popMatrix();
    } 
  }
  
  if (EXPORT) {
    gifExport.setDelay(1000/60);
    gifExport.addFrame();
  
    if (a > PI) {
      gifExport.finish();
      exit();
    }
  }
}

