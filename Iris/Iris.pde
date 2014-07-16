import codeanticode.syphon.SyphonServer;
float RADIUS = 1;
int POINTS = 360*2;
float ANGLE = TWO_PI / POINTS;
float NOISE_FACTOR = 40;

float noise;

SyphonServer syphon;

void setup() {
  size(500, 500, OPENGL);
  colorMode(HSB, 360, 100, 100);
  background(0);
  noFill();
  noise = random(10);
  
   syphon = new SyphonServer(this, "Processing Syphon");
}

void draw() {
//  background(0);
  pushStyle();
  fill(0, 3);
  if (frameCount %2 == 0)
  rect(-1, -1, width+1, height+1);
  popStyle();
  
  stroke((frameCount/2)%360, 100, 100, 50);
  pushMatrix();
  translate(width/2, height/2);
  float x, y, xnext, ynext;
  for (float a = 0; a < TWO_PI; a += ANGLE) {
    x = cos(a) * (RADIUS + noise(noise)*NOISE_FACTOR);
    y = sin(a) * (RADIUS + noise(noise)*NOISE_FACTOR);
    noise += 0.01;
    xnext = cos(a + ANGLE) * (RADIUS + noise(noise)*NOISE_FACTOR); 
    ynext = sin(a + ANGLE) * (RADIUS + noise(noise)*NOISE_FACTOR);

    line(x, y, xnext, ynext);
  }
  popMatrix();
  RADIUS += 0.8;
  
  if (RADIUS > 0.7 * width) {
    RADIUS = 1; 
  }
  
  syphon.sendScreen();
}

void mousePressed() {
  background(0);
  RADIUS = 1; 
}
