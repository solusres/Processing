import gifAnimation.*;
GifMaker gifExport;
boolean EXPORT = false;

int SIZE = 500;
int POINTS = 20;
float RADIUS = 150;
float PT_RADIUS = 50;

float A_INC = TWO_PI / POINTS;

void setup() {
  size(SIZE, SIZE, P2D);
  colorMode(HSB, 360, 100, 100);
  blendMode(ADD);
  smooth();
  noStroke();

  if (EXPORT) {
    gifExport = new GifMaker(this, "export.gif");
    gifExport.setRepeat(0);
  }
}

void draw() {
  background(0);

  pushMatrix();
  translate(width/2, height/2);
  for (float main_r = SIZE; main_r > 0; main_r -= 30) {
    for (float a = 0; a < TWO_PI; a += A_INC) {
      float offset = sin(radians(frameCount) + a/2);
      float r = offset * ( PT_RADIUS * (main_r/SIZE) );
      
      fill(233,100,abs(offset*86));
  
      float sx = cos(a) * main_r;
      float sy = sin(a) * main_r;
      ellipse(sx, sy, r, r);
    }
  }

  popMatrix();

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

