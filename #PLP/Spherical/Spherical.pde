/*
 * A sphere of circles
 *
 * Soma Holiday
 * somaholiday@gmail.com
 * @somahol
 */

int scale_factor = 1;

float R = 56;
float R2 = sq(R);
int ROWS = 24;
float INC = TWO_PI/ROWS;

float CIRCLE_R = 4;

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

  background(0);
//  pushMatrix();
//  translate(WIDTH/2.0, HEIGHT/2.0+4, (HEIGHT/2.0));
//  fill(0,0,0,100);
//  ellipse(0, 0, 2*R, 2*R);
//  popMatrix();

  // walk circles of the sphere in the XZ plane
  for (float h = R; h >= -R; h-=(2*R)/ROWS) {
    pushMatrix();
    translate(WIDTH/2, HEIGHT/2, 0);

    float radius = sqrt(sq(R) - sq(h));
    float hue;

    // walk the radius of the circle
    for (float a = 0; a < TWO_PI; a += INC) {
      pushMatrix();
      translate(cos(a + 2*sin(radians(frameCount/4.0))) * radius, h+4, sin(a + 2*sin(radians(frameCount/4.0))) * radius);

      hue = abs(frameCount*2 + h) % 360;
      fill(hue, 80, 100);
      ellipse(0, 0, abs(sin(a+radians(frameCount))) * CIRCLE_R, abs(sin(a+radians(frameCount))) * CIRCLE_R);
      popMatrix();
    }

    popMatrix();
  }

//  maskFacade();

//  frame.setTitle("FPS : " + nf(frameRate, 2, 4));
  textSize(12);
  fill(0,0,100);
  text(nf(frameRate, 2, 4), 0, 0);
}

// masks out the unaddressable portion of the facade
void maskFacade() {
//  pushStyle();
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

//  popStyle();
}

