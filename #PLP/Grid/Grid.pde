/*
 * 
 */

float CELL_W = 12;
float CELL_H = 16;

int cells_wide;
int cells_tall;

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

  cells_wide = ceil(width / CELL_W);
  cells_tall = ceil(height / CELL_H);

  makeCorners();
}

void draw() {
  background(0);
  
  stroke(255, 0, 0);
  noFill();

  for (int i=0; i < cells_wide; i++) {
    for (int j=0; j < cells_tall; j++) {
      rect(i*CELL_W, j*CELL_H, CELL_W, CELL_H);
    }
  }

  maskFacade();
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

