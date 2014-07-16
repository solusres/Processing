import gifAnimation.*;
GifMaker gifExport;
boolean EXPORT = false;

int ROWS = 6;
int COLS = 6;

// how many frames a hexagon transition takes
int FRAMES = 60;

int SIDES = 6;

float RADIUS = 50;
float SQRT3 = sqrt(3);
float INC_X = 1.5*RADIUS;
float INC_Y = SQRT3*RADIUS;

int WIDTH = int(INC_X * COLS);
int HEIGHT = int(INC_Y * ROWS);

ArrayList<Hexagon> hexes;

void setup() {
  size(WIDTH, HEIGHT, P2D);
  smooth();
  noStroke();
//  stroke(255, 0, 0);

  hexes = new ArrayList<Hexagon>();
  
  boolean offset = false;
  for (float x=0; x < width+INC_X; x += INC_X) {
    float y=offset ? INC_Y/2 : 0; // every other column is shifted down a half-hex
    for (; y < height+INC_Y; y += INC_Y) {
      hexes.add(new Hexagon(x, y));
    }
    offset = !offset;
  }

  if (EXPORT) {
    gifExport = new GifMaker(this, "export.gif");
    gifExport.setRepeat(0);
  }
}

void draw() {
  background(102);

  for( Hexagon hex : hexes) {
    hex.run(); 
  }

  frame.setTitle(int(frameRate) + " fps");

  if (EXPORT) {
    gifExport.setDelay(1000/60);
    gifExport.addFrame();

    if (frameCount == 2*FRAMES) {
      gifExport.finish();
      exit();
    }
  }
}

class Hexagon {
  float x;
  float y;
  float r_curr;
  float factor;
  float offset;
  boolean flip;
  
  Hexagon(float x, float y) {
    this.x = x;
    this.y = y;
    // this part's not great--makes everything look too regular
    // find a better way to ensure tiling
//    randomSeed(4*(long)abs(width/2-x));
    this.offset = int(random(0,500));
  }
  
  void run() {
    update();
    paint(); 
  }
  
  
  void update() {
    if ((frameCount+this.offset)%FRAMES == 0) {
      this.flip = !this.flip; 
    }
    
    this.factor = (FRAMES-((frameCount+this.offset)%FRAMES))/float(FRAMES);
    this.r_curr = RADIUS * this.factor;
  }
  
  void paint() {
    pushMatrix();
    translate(x, y);
  
    // bg hex
    fill(this.flip ? 0 : 255);
    polygon(0, 0, RADIUS, SIDES);
  
    // fg hex
    fill(this.flip ? 255 : 0);
    polygon(0, 0, this.r_curr, SIDES); 
    popMatrix();
  }
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

