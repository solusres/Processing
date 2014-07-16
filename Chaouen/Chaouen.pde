int SIZE = 500;
PGraphics pg;

int SLICES = 8;

void setup() {
  size(SIZE, SIZE);
  smooth(8);

  pg = createGraphics(SIZE, SIZE); 
}

void draw() {
  background(0);
  pg.beginDraw();
  pg.clear();
//  pg.rect(0,0,SIZE, SIZE);
  pg.stroke(255,0,0,200);
  pg.noFill();
  
  float y = map(sin(radians(frameCount)), -1, 1, 0, SIZE/4); 
//  y = 0;
  pg.bezier(0, SIZE/2, y, y, 3*y, 3*y, SIZE, SIZE/2);
  pg.bezier(SIZE/2, 0, y, y, 3*y, 3*y, SIZE/2, SIZE);
  
  pg.bezier(y, y, 0, SIZE/2, 3*y, 3*y, SIZE, SIZE/2);
  pg.bezier(y, y, SIZE/2, 0, 3*y, 3*y, SIZE/2, SIZE);
  
  pg.bezier(y, y, 0, SIZE/2, SIZE, SIZE/2, 3*y, 3*y);
  pg.bezier(y, y, SIZE/2, 0, SIZE/2, SIZE, 3*y, 3*y);
  
  pg.bezier(0, SIZE/2, y, y, SIZE, SIZE/2, 3*y, 3*y);
  pg.bezier(SIZE/2, 0, y, y, SIZE/2, SIZE, 3*y, 3*y);
  
  y = -y;
  pg.bezier(0, SIZE/2, y, y, 3*y, 3*y, SIZE, SIZE/2);
  pg.bezier(SIZE/2, 0, y, y, 3*y, 3*y, SIZE/2, SIZE);
  
  pg.bezier(y, y, 0, SIZE/2, 3*y, 3*y, SIZE, SIZE/2);
  pg.bezier(y, y, SIZE/2, 0, 3*y, 3*y, SIZE/2, SIZE);
  
  pg.bezier(y, y, 0, SIZE/2, SIZE, SIZE/2, 3*y, 3*y);
  pg.bezier(y, y, SIZE/2, 0, SIZE/2, SIZE, 3*y, 3*y);
  
  pg.bezier(0, SIZE/2, y, y, SIZE, SIZE/2, 3*y, 3*y);
  pg.bezier(SIZE/2, 0, y, y, SIZE/2, SIZE, 3*y, 3*y);
  
  pg.endDraw();
  
  translate(width/2, height/2);
  
  for (int i=0; i < SLICES; i++) {
    pushMatrix();
    rotate(i*(TWO_PI/SLICES));
    image(pg, 0, 0);
    popMatrix();  
  }
  
  frame.setTitle("FPS : " + nf(frameRate, 2, 4));
}
