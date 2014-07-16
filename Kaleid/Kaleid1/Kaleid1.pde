int SIZE = 500;
PGraphics pg;

int SLICES = 6;

void setup() {
  size(SIZE, SIZE);
  //  smooth(8);

  pg = createGraphics(SIZE, SIZE);
}

void draw() {
//  background(0);
  fill(0,0,0,200);
  rect(-1,-1,SIZE+1,SIZE+1);
  pg.beginDraw();
  pg.clear();
  pg.stroke(200,200,200);

  for (int x = 0; x < SIZE; x+=2) {
    pg.ellipse(x, 80+50*sin(x+radians(frameCount)), 3, 10*sin(x+radians(frameCount)));
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

