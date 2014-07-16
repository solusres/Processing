import gifAnimation.*;
GifMaker gifExport;
boolean EXPORT = false;

int SIZE = 500;

float CENTER_RADIUS = 130;
float PETAL_DIAMETER = 30;

float MIN_LEN = 120;
float MAX_LEN = 100;

int PETALS = 16;
float A_INC = TWO_PI/PETALS;

void setup() {
  size(SIZE, SIZE, P2D);
  smooth();

  noStroke();
  fill(255);

  if (EXPORT) {
    gifExport = new GifMaker(this, "export.gif");
    gifExport.setRepeat(0);
  }
}

void draw() {
  background(0);

  pushMatrix();
  translate(SIZE/2, SIZE/2);

  for (float a=0; a < TWO_PI; a+=A_INC) {
    float factor = sin((a + radians(frameCount*4)));
    // dance up and down
//    float len = map(factor, -1, 1, MIN_LEN, MAX_LEN);
    float len = MAX_LEN;

    pushMatrix();
    rotate(a);
    // spin flower
//    rotate(a + radians(frameCount));
    pushStyle();
    stroke(255);
    line(0, 0, 0, len-PETAL_DIAMETER/2);
    popStyle();
    float mouth_offset = sin(radians(frameCount*2) + a)*HALF_PI;
    noStroke();
    pushStyle();
    fill(255,0,0);
    ellipse(0, len, PETAL_DIAMETER - 5, PETAL_DIAMETER - 5);
    popStyle();
    arc(0, len, PETAL_DIAMETER, PETAL_DIAMETER, PI-mouth_offset, TWO_PI+mouth_offset, PIE);
    popMatrix();
  }
  
//  ellipse(0, 0, CENTER_RADIUS, CENTER_RADIUS);
  ellipse(0, 0, MAX_LEN*2-PETAL_DIAMETER, MAX_LEN*2-PETAL_DIAMETER);

  popMatrix();

  if (EXPORT) {
    gifExport.setDelay(1000/60);
    gifExport.addFrame();

    if (true) {
      gifExport.finish();
      exit();
    }
  }
}

