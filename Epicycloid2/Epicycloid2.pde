// http://www-history.mcs.st-and.ac.uk/Java/Epicycloid.html

int SIZE = 500;

int P_SIZE = 1;

float a = 5;
float b = 123;
float x;
float y;

void setup() {
  size (SIZE, SIZE);
  smooth(6);
  background(0);
  noStroke();
  fill(255);
  textAlign(LEFT, TOP);
}

void cycle() {
  pushMatrix();
  translate(SIZE/2, SIZE/2);
  
  for (float t = 0; t <= 1000; t += 0.1) {
  
    x = (a + b) * cos(t) - b * cos((a/b + 1) * t);
    y = (a + b) * sin(t) - b * sin((a/b + 1) * t);

    
    ellipse(x, y, P_SIZE, P_SIZE);
  }
  
  popMatrix(); 
}

void draw() {
  background(0);
  b = map(cos(radians(frameCount/60.)), -1, 1, 8, 127);
  cycle();
//  noLoop(); 
}

void drawRealtime() {
  float t = frameCount/50.;
  
  pushStyle();
  fill(0);
  rect(0,0,60,20);
  fill(255);
  text(str(t),0,0);
  popStyle();  
  
  pushMatrix();
  translate(SIZE/2, SIZE/2);
  
  // x = (a + b) cos(t) - b cos((a/b + 1)t)
  // y = (a + b) sin(t) - b sin((a/b + 1)t)
  
  x = (a + b) * cos(t) - b * cos((a/b + 1) * t);
  y = (a + b) * sin(t) - b * sin((a/b + 1) * t);

  ellipse(x, y, P_SIZE, P_SIZE);
  
  popMatrix();
}

