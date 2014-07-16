// http://www-history.mcs.st-and.ac.uk/Java/Epicycloid.html

int SIZE = 1000;

float P_SIZE_MIN = 1;
float P_SIZE_MAX = 7;

float A = 2;
float B_MIN = 95;
float B_MAX = 303;

float COLOR_RANGE = 200;

void setup() {
  size (SIZE, SIZE);
  colorMode(HSB, COLOR_RANGE);
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
  
  float dist;
  
  float hue;
  float sat = COLOR_RANGE;
  float bri;
  
  float p_size;
  
  for (float t = 0; t <= 2000; t += 0.1) {
  
    x = (a + b) * cos(t) - b * cos((a/b + 1) * t);
    y = (a + b) * sin(t) - b * sin((a/b + 1) * t);

    pushStyle();
    
    dist = dist(x, y, 0, 0);
    
    hue = (t+frameCount) % COLOR_RANGE;
    bri = map(SIZE/2 - dist, 0, SIZE/2, 100, COLOR_RANGE);
    
//    p_size = map(dist-(frameCount % SIZE/2), 0, SIZE/2, P_SIZE_MIN, P_SIZE_MAX);
    p_size = map(dist, 0, SIZE/2, P_SIZE_MIN, P_SIZE_MAX);
    
    fill(hue, sat, bri);
    ellipse(x, y, p_size, p_size);
    popStyle();
  }
  
  popMatrix(); 
}

void draw() {
  background(0);
  float a = A;
  float b = map(sin(radians(frameCount/30.)), -1, 1, B_MIN, B_MAX);
  cycloid(a, b);
  
  frame.setTitle("b [" + B_MIN + ", " + B_MAX + "] : " + nf(b,2,4) + " | FPS : " + nf(frameRate,2,4));
  
//  saveFrame("frames/####.tif");
}

