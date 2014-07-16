int SIZE = 500;
PGraphics pg, pGrid;

int GRID_SPACING = 20;
int SLICES = 10;

void setup() {
  size(SIZE, SIZE);
  smooth(8);

  pg = createGraphics(SIZE, SIZE);
  pGrid = createGraphics(SIZE, SIZE);
  buildGrid(pGrid);

  background(0);
}

void buildGrid(PGraphics pGrid) {
  pGrid.beginDraw();
  pGrid.stroke(0, 0, 100);
  pGrid.noFill();
  for (int gridX=0; gridX < width; gridX += GRID_SPACING) {
    for (int gridY=0; gridY < width; gridY += GRID_SPACING) {  
      pGrid.ellipse(gridX, gridY, 1, 1);
    }
  }
  pGrid.endDraw();
}

void drawGrid(PGraphics pGrid) {
  image(pGrid, 0, 0);
}

void draw() {
  doClear();
  buildGraphics();
  
  pushMatrix();
  translate(width/2, height/2);

  float rotationOffset = radians(frameCount/8.0);

  for (int i=0; i < SLICES; i++) {
    pushMatrix();
    rotate(i*(TWO_PI/SLICES) + rotationOffset);
    image(pg, 0, 0);
    popMatrix();
  }
  popMatrix();

//  drawGrid(pGrid);

  frame.setTitle("FPS : " + nf(frameRate, 2, 4));
}

void doClear() {
  //  background(0);
  fill(0, 0, 0, 10);
  rect(-1, -1, SIZE+1, SIZE+1);
}

void buildGraphics() {
  pg.beginDraw();
  pg.smooth(8);
  pg.colorMode(HSB, 360, 100, 100);
  pg.clear();
  //  pg.stroke(sin(radians(frameCount))*360,100,100);
  pg.noStroke();
  float hue = map(sin(radians(frameCount/8)), -1, 1, 0, 360);
  pg.fill(hue, 100, 100);

  float x, y, w, h;
  for (int i = 0; i < SIZE; i+=4) {
    x = i;
    y = 50+50*sin(radians(x+frameCount));
    w = 8;
    h = 100*(x/SIZE)*sin(x+radians(frameCount));
    pg.ellipse(x, y, w, h);
  }

  pg.endDraw();
}

