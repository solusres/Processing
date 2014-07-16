int SIZE = 500;

ArrayList<PVector> points;
ArrayList<Integer> colors;

color[] COLOR_POOL = {#A59193, #986240, #854641, #4A5C60, #7F6A57}; 

void setup() {
  size(SIZE, SIZE, P2D);
  smooth(8);

  points = new ArrayList<PVector>();
  colors = new ArrayList<Integer>();
  
  stroke(0);
  strokeWeight(2);
}

void draw() {
  background(0);
  
  PVector p;
  beginShape(TRIANGLE_FAN);
  for (int i=0; i < points.size(); i++) {
    p = points.get(i);
    
    fill(colors.get(i));
    vertex(p.x, p.y);
  }
  endShape();

  if (frameCount % 30 == 0) {
    frame.setTitle("FPS : " + nf(frameRate, 2, 4));
  }
}

void mouseMoved() {
  
  
}

void mousePressed() {
   points.add(new PVector(mouseX, mouseY));
   colors.add(COLOR_POOL[int(random(COLOR_POOL.length))]);
}
