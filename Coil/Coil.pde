int SIZE = 500;

float COIL_WIDTH = 40;
float COIL_RADIUS = 80;
float ANGLES = 120;
float ANGLE_INTERVAL = TWO_PI / ANGLES;
float Y_INTERVAL = 1;

void setup() {
  size(SIZE, SIZE, OPENGL);
  smooth(8);
}

void draw() {
  background(0);
  lights();

  translate(width/2, -100, 0);
  
  fill(255, 255, 255, 255);
  noStroke();
  
  beginShape(TRIANGLE_STRIP);

  for (int i=0; i < height/Y_INTERVAL + 200; i++) {
    float x = cos(i*ANGLE_INTERVAL + radians(frameCount)) * COIL_RADIUS;
    float y = ((i%2==0)?-COIL_WIDTH/2:COIL_WIDTH/2) + i*Y_INTERVAL;
    float z = sin(i*ANGLE_INTERVAL + radians(frameCount)) * COIL_RADIUS;

    vertex(x, y, z);
  }

  endShape();
}

