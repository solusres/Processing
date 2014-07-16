boolean SHOW_FPS = false;

// CONSTANTS
float SQRT3 = sqrt(3);

// SHAPE STATE
float RADIUS = 50;

// GRID STATE
Grid grid;

int ROWS = 10;
int COLS = 10;
float X_INC = RADIUS * 1.5;
float Y_INC = RADIUS * SQRT3/2;
float X_OFFSET = X_INC/2;
float Y_OFFSET = 0;

GridShape[] shapes = new GridShape[] {
  new GridPolygon(6, RADIUS)
};

//  for (float f = 2; f > 0; f -= 0.5) {
//    grid.shapes.add(new GridPolygon(1, f*RADIUS));
//  }

void setup() {
  size(int(X_INC * COLS), int(Y_INC * ROWS));
  smooth(8);
  colorMode(HSB, 360, 100, 100);

  grid = new Grid(COLS, ROWS, X_INC, Y_INC, X_OFFSET, Y_OFFSET);
  
//  grid.DEBUG = true;
  
  // is there really no better way to do this?
  for (GridShape shape : shapes) {
    grid.shapes.add(shape);
  }
}

void draw() {
  background(0, 0, 100);

  grid.draw();

  if (SHOW_FPS) {
    frame.setTitle("FPS : " + nf(frameRate, 2, 4));
  }
  
  noLoop();
}

