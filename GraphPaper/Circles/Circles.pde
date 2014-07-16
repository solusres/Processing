int SIZE = 500;
int RADIUS = 50;

int CELLS;

void setup() {
  size(SIZE, SIZE);
  smooth(8);
  colorMode(HSB, 360, 100, 100);
  noStroke();

  CELLS = SIZE/RADIUS;
}

void draw() {
  background(0, 0, 100);
  
  pushStyle();
   
  // shift every other row sideways
  int offset;
  
  float weight = 0.001;
//  float weight = map(sin(radians(frameCount)), -1, 1, 0.00001, 5);

  for (int x = 0; x <= CELLS; x++) {

    for (int y = 0; y <= CELLS; y++) {
      offset = (y%2==0) ? 0 : RADIUS/2;
      
      strokeWeight(weight);
      stroke(0, 100, 0);
      noFill();
      ellipse(RADIUS*x + offset, RADIUS*y, RADIUS*2, RADIUS*2);
    }
  }
  popStyle();

  frame.setTitle("FPS : " + nf(frameRate, 2, 4));
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

