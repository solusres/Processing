int SIZE = 500;

void setup() {
  size(SIZE, SIZE);
  smooth(8);
  background(0);
}

float c = 100;

void draw() {
  stroke(255);

  float x, y, yoff;
  
  y = height/2;
  for (int i = 0; i < 22050; i++) {
    x = c*log10(i);
    if (i % 10000 == 0) {
      yoff = 320;
    } else if (i % 1000 == 0) {
      yoff = 160;
    } else if (i % 100 == 0) {
      yoff = 80;
    } else if (i % 10 == 0) {
      yoff = 40;
    } else {
      yoff = 10;
    }

    line(x, y - yoff, x, y + yoff);
  }
  noLoop();
}

// Calculates the base-10 logarithm of a number
float log10 (int x) {
  return (log(x) / log(10));
}
