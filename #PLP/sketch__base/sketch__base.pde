/*
 * Base sketch for #PLP
 */

int scale_factor = 4;

float R = 56;
float R2 = sq(R);
int ROWS = 32;
float INC = TWO_PI/ROWS;

float CIRCLE_R = 5;

int WIDTH = 192;
int HEIGHT = 157;

ArrayList<PVector> corners = new ArrayList<PVector>();

void makeCorners() {
  // top corners, left to right
  corners.add(new PVector(  0, 32));
  corners.add(new PVector( 36, 32));
  corners.add(new PVector( 36, 16));
  corners.add(new PVector( 72, 16));
  corners.add(new PVector( 72, 0));
  corners.add(new PVector(120, 0));
  corners.add(new PVector(120, 16));
  corners.add(new PVector(156, 16));
  corners.add(new PVector(156, 32));
  corners.add(new PVector(192, 32));
  // bottom corners
  corners.add(new PVector(  0, 157));
  corners.add(new PVector(192, 157));
}


void setup() {
  size(WIDTH * scale_factor, HEIGHT * scale_factor, P3D);
  background(0);
  frameRate(25);
  smooth(8);
  colorMode(HSB, 360, 100, 100);
  noStroke();

  makeCorners();
}

void draw() {
  scale(scale_factor);

  pushMatrix();
  pushStyle();
  translate(0, 0, -R*2);
  fill(0,200);
  rect(-1,-1, WIDTH+1, HEIGHT+1);
  popStyle();
  popMatrix();

  // walk circles of the sphere in the XZ plane
  for (float h = R; h >= -R; h-=(2*R)/ROWS) {
    pushMatrix();
    translate(WIDTH/2, HEIGHT/2, 0);

    float radius = sqrt(sq(R) - sq(h));

    // walk the radius of the circle
    for (float a = 0; a < TWO_PI; a += INC) {
      pushMatrix();
      translate(cos(a + radians(frameCount/12.0)) * radius, h+4, sin(a + radians(frameCount/12.0)) * radius);

      float f = sin(radians(frameCount + h));

      fill((frameCount*2+h)%360, 80, 100);
      ellipse(0, 0, sin(a+radians(frameCount)) * CIRCLE_R, sin(a+radians(frameCount)) * CIRCLE_R);
      popMatrix();
    }

    popMatrix();
  }

  maskFacade();

  frame.setTitle("FPS : " + nf(frameRate, 2, 4));
}

// masks out the unaddressable portion of the facade
void maskFacade() {
  pushStyle();
  noStroke();
  fill(255);

  beginShape();
  vertex(  0, 0);
  vertex(  0, 32);
  vertex( 36, 32);
  vertex( 36, 16);
  vertex( 72, 16);
  vertex( 72, 0);
  endShape(CLOSE);

  beginShape();
  vertex(120, 0);
  vertex(120, 16);
  vertex(156, 16);
  vertex(156, 32);
  vertex(192, 32);
  vertex(192, 0);
  endShape(CLOSE);

  popStyle();
}

