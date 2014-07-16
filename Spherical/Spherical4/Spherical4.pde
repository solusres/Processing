import gifAnimation.*;
GifMaker gifExport;
boolean EXPORT = false;

int SIZE = 500;
float R = 200;
float R2 = sq(R);
int ROWS = 61;
float INC = TWO_PI/ROWS;

float CIRCLE_R = 10;

void setup() {
  size(SIZE, SIZE, P3D);
  smooth();
  colorMode(HSB, 360, 100, 100);
  noStroke();

  if (EXPORT) {
    gifExport = new GifMaker(this, "export.gif");
    gifExport.setRepeat(0);
  }
}

void draw() {
  background(0);  
 
  // walk circles of the sphere in the XZ plane
  for (float h = R; h >= -R; h-=(2*R)/ROWS) {
    pushMatrix();
    translate(width/2, height/2, 0);
    
    float radius = sqrt(sq(R) - sq(h));

    // walk the radius of the circle
    for (float a = 0; a < TWO_PI; a += INC) {
      pushMatrix();
      translate(cos(a + radians(frameCount/12.0)) * radius, h, sin(a + radians(frameCount/12.0)) * radius);
      
      float f = sin(radians(frameCount + h));
      
      fill((frameCount+h)%360, 80, 100);
      ellipse(0, 0, sin(a+radians(frameCount)) * CIRCLE_R, sin(a+radians(frameCount)) * CIRCLE_R);
      popMatrix();
    }

    popMatrix();
  }

  if (EXPORT) {
    gifExport.setDelay(1000/60);
    gifExport.addFrame();

    if (false) {
      gifExport.finish();
      exit();
    }
  }
  
  frame.setTitle("FPS : " + nf(frameRate, 2, 4));
}

