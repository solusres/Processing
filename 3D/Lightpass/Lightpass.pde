import gifAnimation.*;
GifMaker gifExport;
boolean EXPORT = false;

int SIZE = 500;
int RAD = 100;
int INC = RAD;


void setup() {
  size(SIZE, SIZE, P3D);
  smooth();
  fill(255);
  noStroke();
  //  stroke(255,0,0);
  sphereDetail(20);
  rectMode(CENTER);

  if (EXPORT) {
    gifExport = new GifMaker(this, "export.gif");
    gifExport.setRepeat(0);
    gifExport.setQuality(10); // default is 10.
  }
}

void draw() {
  background(0);

  pushMatrix();
    translate(SIZE/2, SIZE/2, 0);
    spotLight(255, 0, 0, 0, map(frameCount%180, 0, 180, -3*SIZE, 3*SIZE), 200, 0, 0, -1, PI/2, 2);
    rect(0, 0, SIZE, SIZE);
  
    pushMatrix();
      translate(-SIZE/4, -SIZE/4, 0);
      sphere(SIZE/8);
    popMatrix();
  
    pushMatrix();
      translate(-SIZE/4, SIZE/4, 0);
      sphere(SIZE/8);
    popMatrix();
  
    pushMatrix();
      translate(SIZE/4, -SIZE/4, 0);
      sphere(SIZE/8);
    popMatrix();
  
    pushMatrix();
      translate(SIZE/4, SIZE/4, 0);
      sphere(SIZE/8);
    popMatrix();

  popMatrix();

  if (EXPORT) {
    gifExport.setDelay(1000/60);
    gifExport.addFrame();

    if (frameCount == 180) {
      gifExport.finish();
      exit();
    }
  }
}

