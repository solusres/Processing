int NOTCH_HEIGHT = 10;
float MAGNITUDE = 100;

float noiseOffset = 0;

void setup() {
  size(500, 500);
  smooth(8);
  fill(255);
  noStroke();
}

void draw() {
  pushMatrix();

  translate(width/2, height/2);
  rotate(HALF_PI);
  translate(-width/2, -height/2);
  translate(0, height/2);
  background(0);

  //drawAxis();

  float y;
  float x_0;

  for (int x=0; x < width; x++) {
    for (float factor = 8; factor >= .5; factor -= .5) {
      x_0 = map(x, 0, width, 0, TWO_PI);
      fill(255/factor, 0, 0);
      y = sin((x_0 * factor) + radians(frameCount)) * (MAGNITUDE / factor);
//      if ((x + 2 * frameCount) % 120 > 60) {
        float h = sin(radians(x*100000+frameCount)) * 60;
        h = max(h, 0);
        rect(x, y, h, 3);
        noiseOffset += .01;
//      }
    }
  }
  popMatrix();
}

void drawAxis() {
  pushStyle();
  stroke(255); 
  line(0, 0, width, 0); // x-axis
  for (float x_notch = 0; x_notch <= width; x_notch += width/4) {
    line(x_notch, NOTCH_HEIGHT, x_notch, -NOTCH_HEIGHT);
  }
  popStyle();
}

