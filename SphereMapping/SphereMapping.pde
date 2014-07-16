int SIZE = 500;

float radius = SIZE/4;


void setup() {
  size(SIZE, SIZE, P3D);
  smooth(8);
}

void draw() {
  lights();
  background(0);

  pushMatrix();
  pushStyle();
  translate(width/2., height/2., 0);
  stroke(255);
  noFill();
  sphere(radius);
  popStyle();

  PVector projection = computeSphereVector(mouseX, mouseY);
  projection.mult(radius);

  pushMatrix();
  pushStyle();
  translate(projection.x, projection.y, projection.z);
  noStroke();
  fill(255, 0, 0);
  sphere(5);
  popStyle();
  popMatrix();

  popMatrix();

  frame.setTitle("FPS : " + nf(frameRate, 2, 4));
}

PVector computeSphereVector(int x, int y) {
  float pX = (x-width/2.0)/radius;    
  float pY = (y-height/2.0)/radius;
  float L2 = pX*pX + pY*pY;
  if (L2>=1) {
    PVector ans = new PVector(pX, pY, 0); 
    ans.normalize(); //interpret the click as being on the boundary
    return ans;
  } 
  else
  {
    float pZ = sqrt(1 - L2); 
    return new PVector(pX, pY, pZ);
  }
} 

