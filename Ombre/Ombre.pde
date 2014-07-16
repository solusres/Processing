int SIZE = 500;
int RADIUS = 250;
int CELL_SIZE = 10;

float x_center = SIZE/2;
float y_center = SIZE/2;

void setup() {
  size(SIZE, SIZE, P2D);
  smooth();

  stroke(255);
  fill(255);
}

void draw() {
  background(0);

  for (int x = 0; x < SIZE; x += CELL_SIZE) {
    for (int y = 0; y < SIZE; y += CELL_SIZE) {
      float d = dist(width/2, height/2, x, y);
      float maxDist = dist(0, 0, width/2, height/2);
      float gray = map(d, 0, maxDist, 0, 255);

      fill(gray);
      ellipse(x, y, CELL_SIZE, CELL_SIZE);
    }
  }
  noLoop();
}

