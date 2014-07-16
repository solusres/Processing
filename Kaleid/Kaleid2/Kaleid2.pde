int SIZE = 500;
PGraphics pg;

int SLICES = 6;

void setup() {
  size(SIZE, SIZE);
  smooth(8);
//  colorMode(HSB, 360, 100, 100);

  pg = createGraphics(SIZE, SIZE);
  background(0);
}

void draw() {
//  background(0);
  fill(0,0,0,10);
  rect(-1,-1,SIZE+1,SIZE+1);
  pg.beginDraw();
  pg.colorMode(HSB, 360, 100, 100);
  pg.clear();
//  pg.stroke(sin(radians(frameCount))*360,100,100);
  pg.noStroke();
  pg.fill(sin(radians(frameCount/8))*360, 100, 100);

  float x, y, w, h;
  for (int i = 0; i < SIZE; i+=2) {
    x = i;
    y = x+50*sin(x+radians(frameCount));
    w = 3;
    h = 100*(x/SIZE)*sin(x+radians(frameCount));
    pg.ellipse(x, y, w, h);
  }

  pg.endDraw();

  translate(width/2, height/2);

  float rotationOffset = radians(frameCount/8.0);

  for (int i=0; i < SLICES; i++) {
    pushMatrix();
    rotate(i*(TWO_PI/SLICES) + rotationOffset);
    image(pg, 0, 0);
    popMatrix();
  }

  frame.setTitle("FPS : " + nf(frameRate, 2, 4));
}

