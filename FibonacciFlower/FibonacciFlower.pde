import gifAnimation.*;
GifMaker gifExport;
boolean EXPORT = false;

int SIZE = 500;
int MAX_LEAVES = 1000;
float G = 1 / 1.16180339;
float GA = 360 - 360*G;

float rad = 10;
float rgrowth = 1.005;

float growx = 1.0001;
float growy = 1.018;
float xscl = 45;
float yscl = 19;

int cur = MAX_LEAVES;
float rot = 0;

void setup() {
  size(SIZE, SIZE, P2D);
  smooth(8);
  background(0);
  
  stroke(255);
  fill(0);
  
  if (EXPORT) {
    gifExport = new GifMaker(this, "export.gif");
    gifExport.setRepeat(0);
  }
}

void draw() {
  
  if (cur > 0) {
    cur--;
    
    xscl *= growx;
    yscl *= growy;
    
    rot += GA;
    rot -= int(rot/360) * 360;
    
    rad *= rgrowth;
    
    float x = cos(rot * PI/180) * rad;
    float y = sin(rot * PI/180) * rad;
    translate(width/2, height/2);
    pushMatrix();
    translate(x, y);
//    rotate(rot);
    ellipse(0, 0, 5, 5);
    popMatrix();
  }
  
  frame.setTitle(int(frameRate) + " fps");
  
  if (EXPORT) {
    gifExport.setDelay(1000/60);
    gifExport.addFrame();
  
    if (true) {
      gifExport.finish();
      exit();
    }
  }
}
