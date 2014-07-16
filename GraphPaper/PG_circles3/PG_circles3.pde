boolean SHOW_FPS = false;

// CONSTANTS
float SQRT3 = sqrt(3);

// SHAPE STATE
float RADIUS = 40;

// GRID STATE
Grid grid;

int ROWS = 15;
int COLS = 15;
float X_INC = RADIUS;
float Y_INC = RADIUS;
float X_OFFSET = 0;
float Y_OFFSET = 0;

GridShape[] shapes = {
  new GridPolygon(1, RADIUS/2+RADIUS/5),
  new GridPolygon(1, RADIUS/2),
  new GridPolygon(1, RADIUS/2-RADIUS/5),
};

  void setup() {
    size(int(X_INC * COLS), int(Y_INC * ROWS));
    smooth(8);
    colorMode(HSB, 360, 100, 100);

    grid = new Grid(COLS, ROWS, X_INC, Y_INC, X_OFFSET, Y_OFFSET);

//    grid.DEBUG = true;

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

void keyPressed() {
  if(key == 's') {
    saveFrame();
  }
}

