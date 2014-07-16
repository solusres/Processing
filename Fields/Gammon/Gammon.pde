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
  
  for (int x=INC; x < SIZE; x+=INC) {
    for (int y=INC; y < SIZE; y+=INC) {
      pushMatrix();
      translate(x, y);
//      rotate(a+x+y);
      ellipse(0, 0, sin(a+(y)) * INC, INC);
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

