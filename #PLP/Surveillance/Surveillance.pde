/*
 * Surveillance Cones
 */

int CAMERA_SIZE = 8; 

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

  PVector mouse = new PVector(mouseX, mouseY);

  for (int i=0; i < corners.size(); i++) {
    PVector corner = corners.get(i);
    drawCamera(corner, mouse);
  }
  
  maskFacade();  
}

void drawCamera(PVector loc, PVector target) {
  // used to make cameras blink
  float blinkFactor = sin(radians(frameCount*4));
  // angle between target and camera
  float angle = atan2(target.y-loc.y, target.x-loc.x);
    
  pushMatrix();
  translate(loc.x, loc.y);
  
  fill(255 * blinkFactor, 0, 0);
  noStroke();
  ellipse(0, 0, CAMERA_SIZE, CAMERA_SIZE);
  
//  fill(0,255,0);
//  text(int(degrees(angle)), 0, 0);
  
  rotate(angle);
  fill(0, 180, 0, 200);
  
  float h = 60;
  float w = CAMERA_SIZE;
  triangle(0, 0, h, w/2, h, -w/2);
//  ellipse(CAMERA_SIZE/2, 0, 4, 4);
  popMatrix();
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



