import gifAnimation.*;
GifMaker gifExport;
boolean EXPORT = false;

int RAD = 100;
int INC = RAD;

float SPIRAL_RAD = 200;


void setup() {
  size(800, 800, P3D);
  smooth(6);
  fill(255);
//  noFill();
  noStroke();
//  stroke(255,0,0);
  sphereDetail(20);
  
  if (EXPORT) {
    gifExport = new GifMaker(this, "export.gif");
    gifExport.setRepeat(0);
    gifExport.setQuality(1);
  }
}

void draw() {
  background(0);
  pointLight(255, 0, 0, width/2, 0, -200);
  pointLight(0, 255, 0, width/2, height/2, -200);
  pointLight(0, 0, 255,  width/2, height, -200);
  float x;
  float y;
  float a = -radians(frameCount);
  
  for (int z=5; z >= -50; z-=1) {
    x = cos(a + (z*PI/12)) * (SPIRAL_RAD+z);
    y = sin(a + (z*PI/12)) * (SPIRAL_RAD+z);
    pushMatrix();
    translate(width/2, height/2, 0);
      pushMatrix();
      translate(x, y, z*INC);
      sphere(RAD);
      popMatrix();
      
      pushMatrix();
      translate(-x, -y, z*INC);
      sphere(RAD);
      popMatrix();
    
    popMatrix();
  }
  
  if (EXPORT) {
    gifExport.setDelay(1000/60);
    gifExport.addFrame();

    if (frameCount == 180) {
      gifExport.finish();
      exit();
    }
  }
}
