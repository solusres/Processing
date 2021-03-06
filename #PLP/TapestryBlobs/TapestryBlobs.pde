/*
 * 
 */

int scaleFactor = 1;

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

Banner b;

void setup() {
  size(192 * scaleFactor, 157 * scaleFactor, OPENGL);
  background(0);
  frameRate(25);

  b = new Banner(72, 0, 6, 16, 8);

  makeCorners();
}

void draw() {
  scale(scaleFactor);
  background(0);

  b.draw();

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

