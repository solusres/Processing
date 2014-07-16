boolean SHOW_FPS = true;
float RAD = 250;
int SIDES = 8;
int DEPTH = 30;
float FRAMES_TO_ANIMATE = 180;

color outer = #81114D;
color inner = #EAC9DC;
PShape root;

void setup() {
  size(500, 500, P2D);
//  smooth(8);
  colorMode(HSB, 360, 100, 100);

  root = polygon(0,0,RAD,SIDES,0);
}

void draw() {
  background(0);

  pushMatrix();
  translate(width/2, height/2);
  
  shape(root, 0, 0);
  PShape base = root;
  PShape next;
  float amt;
  color c;
  
  for (int i=0; i < DEPTH; i++) {
    amt = norm(frameCount%FRAMES_TO_ANIMATE, 0, FRAMES_TO_ANIMATE-1);
    c = lerpColor(outer, inner, norm(i, -1, DEPTH));
    next = lerpShape(base, c, amt);
    shape(next, 0, 0);
    base = next;
  }
  
  popMatrix();
  
  if (SHOW_FPS) {
    frame.setTitle("FPS : " + nf(frameRate, 2, 4));
  }
}

PShape polygon(float x, float y, float radius, int npoints, float rotation) {
  PShape ret = createShape(); 
  
  ret.beginShape();
  ret.fill(outer);
  ret.noStroke();
  float sx, sy, angle;
  for (int i = 0; i < npoints; i++) {
    angle = i*TWO_PI/npoints;
    sx = x + cos(angle + rotation) * radius;
    sy = y + sin(angle + rotation) * radius;
    ret.vertex(sx, sy);
  }

  ret.endShape(CLOSE);
  return ret;
}

PShape lerpShape(PShape s, color c, float lerpAmt) {
  PShape ret = createShape();
 
  int vertexCount = s.getVertexCount();
  PVector a, b, l;
  
  ret.beginShape();
  ret.fill(c);
  ret.noStroke();
  for (int i = 0; i < vertexCount; i++) {
    a = s.getVertex(i);
    b = s.getVertex(i+1==vertexCount ? 0 : i+1);
    l = PVector.lerp(a, b, lerpAmt);
    ret.vertex(l.x, l.y);
  }

  ret.endShape(CLOSE);
  
  return ret;
}

