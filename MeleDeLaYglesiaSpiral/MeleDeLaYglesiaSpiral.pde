int SIZE = 500;

ArrayList<Pop> pops;

color[] COLOR_POOL = {
  #A59193, #986240, #854641, #4A5C60, #7F6A57
}; 

void setup() {
  size(SIZE, SIZE, P2D);
  smooth(8);

  pops = new ArrayList<Pop>();

  noStroke();
}

void draw() {
//  background(0);

  pushMatrix();
  translate(width/2, height/2);
  beginShape(TRIANGLE_FAN);
  vertex(0, 0);
  for (Pop p : pops) {
    fill(p.c);
    vertex(p.x, p.y);
  }
  endShape();

  //  for (int deg=0; deg < millis() / 20; deg++) {

  float theta = radians(frameCount*100);
  float r = pow(1.0053611, theta);
  float x = cos(radians(theta)) * r;
  float y = sin(radians(theta)) * r;
  color c = COLOR_POOL[int(random(COLOR_POOL.length))];
  pops.add(new Pop(x, y, c));
  popMatrix();

  if (frameCount % 30 == 0) {
    frame.setTitle("FPS : " + nf(frameRate, 2, 4));
  }
}

void mouseMoved() {
}

void mousePressed() {
}
