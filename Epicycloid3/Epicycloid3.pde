// http://www-history.mcs.st-and.ac.uk/Java/Epicycloid.html

int SIZE = 500;

int P_SIZE = 2;

float A = 37;
float B_MIN = 17;
float B_MAX = 23;

void setup() {
  size (SIZE, SIZE);
  colorMode(HSB, 500);
  smooth(6);
  background(0);
  noStroke();
  fill(255);
  textAlign(LEFT, TOP);
}

void cycloid(float a, float b) {
  pushMatrix();
  translate(SIZE/2, SIZE/2);
  
  float x;
  float y;
  
  float hue;
  float sat = 500;
  float bri;
  
  for (float t = 0; t <= 1000; t += 0.1) {
  
    x = (a + b) * cos(t) - b * cos((a/b + 1) * t);
    y = (a + b) * sin(t) - b * sin((a/b + 1) * t);

    pushStyle();
    
    hue = t % 500;
    bri = map(SIZE/2 - dist(x, y, 0, 0), 0, SIZE/2, 0, 500);
    
    fill(hue, sat, bri);
    ellipse(x, y, P_SIZE, P_SIZE);
    popStyle();
  }
  
  popMatrix(); 
}

void draw() {
  background(0);
  float a = A;
  float b = map(sin(radians(frameCount/120.)), -1, 1, B_MIN, B_MAX);
  cycloid(a, b);
  
  frame.setTitle("b [" + B_MIN + ", " + B_MAX + "] : " + nf(b,2,4) + " | FPS : " + nf(frameRate,2,4));
  
//  saveFrame("frames/####.tif");
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
  
  float a = 8;
  float b = 13;
  
  float x = (a + b) * cos(t) - b * cos((a/b + 1) * t);
  float y = (a + b) * sin(t) - b * sin((a/b + 1) * t);

  ellipse(x, y, P_SIZE, P_SIZE);
  
  popMatrix();
}

