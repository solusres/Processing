import gifAnimation.*;
GifMaker gifExport;
boolean EXPORT = false;

void setup() {
  size(500, 500);
  fill(255);
  smooth();

  if (EXPORT) {
    gifExport = new GifMaker(this, "export.gif");
    gifExport.setRepeat(0);
  }
}

void draw() {
  pushMatrix();
  translate(0, height/2);
  background(0);

  float a = radians(frameCount/4);

  for (float x=0; x < width; x+=0.2) {
    float y = sin(x+a) * 200;
    rect(x, y, 2, 2);
  }
  popMatrix();

  frame.setTitle(int(frameRate) + " fps");

  if (EXPORT) {
    gifExport.setDelay(1000/60);
    gifExport.addFrame();

    if (a > PI/8) {
      gifExport.finish();
      exit();
    }
  }
}

