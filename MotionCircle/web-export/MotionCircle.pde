import controlP5.*;

ControlP5 cp5;

boolean SHOW_FPS = true;

float RADIUS = 150;
int SHAPES = 100;
float SHAPE_RADIUS = 30;
int SHAPE_SIDES = 3;
boolean SHARE_ROTATION = false;
boolean POINTS_ONLY = false;

void setup() {
  size(500, 500);
  smooth(8);
  colorMode(HSB, 360, 100, 100);

  createControls();
}

void draw() {
  background(0);

  pushMatrix();
  translate(width/2, height/2);

  // debug circle
  //  noFill();
  //  stroke(0, 0, 100);  
  //  ellipse(0, 0, 2*RADIUS, 2*RADIUS);

  float x, y, angle;
  float rotOffset = radians(frameCount/2);
  color c;

  pushStyle();
  noFill();
  stroke(0, 0, 100);

  for (int i=0; i < SHAPES; i++) {
    angle = i*TWO_PI/SHAPES;
    x = (cos(angle) * RADIUS);
    y = (sin(angle) * RADIUS);
    
    c = color(map(angle, 0, TWO_PI, 0, 360), 50, 50);
    stroke(c);
    
    if (SHAPE_SIDES == 1) {
      ellipse(x, y, SHAPE_RADIUS*2, SHAPE_RADIUS*2);
    }
    else {
      polygon(x, y, SHAPE_RADIUS, SHAPE_SIDES, SHARE_ROTATION ? rotOffset : angle + rotOffset);
    }
  }

  popStyle();
  popMatrix();

  if (SHOW_FPS) {
    frame.setTitle("FPS : " + nf(frameRate, 2, 4));
  }
}

void polygon(float x, float y, float radius, int npoints, float rotation) {
  float angle = TWO_PI / npoints;
  if (!POINTS_ONLY) {
    beginShape();
  }
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a + rotation) * radius;
    float sy = y + sin(a + rotation) * radius;
    if (POINTS_ONLY) {
      ellipse(sx, sy, 2, 2);
    } else {
      vertex(sx, sy);
    }
  }
  
  if (!POINTS_ONLY) {
    endShape(CLOSE);
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame();
  }
}

void createControls() {
  int C_MARGIN = 5;
  int C_HEIGHT = 15;

  cp5 = new ControlP5(this);

  Group group = cp5.addGroup("controls")
    .setPosition(C_MARGIN, C_HEIGHT)
        .setBackgroundColor(color(255, 80))
          .setBackgroundHeight(C_MARGIN + 5 * C_HEIGHT + 2*C_MARGIN)
            .setWidth(170)
              .setLabel("controls")
                ;

  cp5.addSlider("RADIUS")
    .setPosition(C_MARGIN, C_MARGIN + 0 * C_HEIGHT)
      .setRange(10, width/2)
        .setGroup(group);

  cp5.addSlider("SHAPES")
    .setPosition(C_MARGIN, C_MARGIN + 1 * C_HEIGHT)
      .setRange(2, 200)
        .setGroup(group);

  cp5.addSlider("SHAPE_RADIUS")
    .setPosition(C_MARGIN, C_MARGIN + 2 * C_HEIGHT)
      .setRange(1, width/2)
        .setGroup(group);

  cp5.addSlider("SHAPE_SIDES")
    .setPosition(C_MARGIN, C_MARGIN + 3 * C_HEIGHT)
      .setRange(1, 20)
        .setGroup(group);
        
  // TODO: there has to be an easy way to move the label to the right...
  cp5.addToggle("SHARE_ROTATION")
    .setPosition(C_MARGIN, C_MARGIN + 4 * C_HEIGHT)
      .setSize(9, 9)
        .setGroup(group);
        
  cp5.addToggle("POINTS_ONLY")
    .setPosition(75, C_MARGIN + 4 * C_HEIGHT)
      .setSize(9, 9)
        .setGroup(group);
}


