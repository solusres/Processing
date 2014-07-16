/*
* Testing the geometry of the screen
 */

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
  size(192, 157);
  background(0);
  frameRate(25);

  makeCorners();
}

void draw () {
  background(0);

  stroke(255, 0, 0);
  noFill();

  float frames = 50;
  float factor = (frameCount % frames) / frames;
  float size   = factor * 2 * 32;

  stroke(255 - (0.9 * factor * 255), 0, 0);

  for (int i=0; i < corners.size(); i++) {
    PVector corner = corners.get(i);
    ellipse(corner.x, corner.y, size, size);
  }
  
  maskFacade();
}

// masks out the unaddressable portion of the facade
void maskFacade() {
  pushStyle();
  noStroke();
  fill(255);
  
  beginShape();
  vertex(  0,  0);
  vertex(  0, 32);
  vertex( 36, 32);
  vertex( 36, 16);
  vertex( 72, 16);
  vertex( 72,  0);
  endShape(CLOSE);
  
  beginShape();
  vertex(120,  0);
  vertex(120, 16);
  vertex(156, 16);
  vertex(156, 32);
  vertex(192, 32);
  vertex(192,  0);
  endShape(CLOSE);
  
  popStyle();
}



