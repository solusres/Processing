import gifAnimation.*;
GifMaker gifExport;
boolean EXPORT = false;

int SIZE = 500;
float R = 200;
float R2 = sq(R);
int ROWS = 24;
float INC = TWO_PI/ROWS;

void setup() {
  size(SIZE, SIZE, P3D);
  smooth();

  stroke(255, 0, 0);
  fill(255);

  if (EXPORT) {
    gifExport = new GifMaker(this, "export.gif");
    gifExport.setRepeat(0);
  }
}

void draw() {
  background(0);


  // sq(R) = sq(x) + sq(y) + sq(z);
  for (float h = -R; h <= R; h+=(2*R)/ROWS) {
    pushMatrix();
    translate(width/2, height/2, 0);
    float radius = sqrt(sq(R) - sq(h));

    for (float a = 0; a < TWO_PI; a += INC) {
      pushMatrix();
      rotateY(radians(frameCount/2));
      translate(cos(a) * radius, h, sin(a) * radius);

      ellipse(0, 0, 1, 1);
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
}

