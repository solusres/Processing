import processing.opengl.*;
import controlP5.*;
import peasy.*;

ControlP5 cp5;
PeasyCam cam;

boolean SHOW_FPS = false;

int POINTS = 15;
float OUTER_RADIUS = 150;
float INNER_RADIUS = 0;

float radius;
float rot;
color col;
float yHeight;

void setup() {
  size(400, 600, OPENGL);
  colorMode(HSB, 360, 100, 100);
  background(0);
  noStroke();
  fill(255, 50);
  
  cam = new PeasyCam(this, width/2, height/2, 0, OUTER_RADIUS*3);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
//  createControls();
}

void draw() {
  //  background(0);
  //  fadeRect(1);
  lights();

  float factor = radians(frameCount);
  float radFactor = cos(factor*4 + HALF_PI);
  float yFactor = sin(factor*2);

  radius = map(radFactor, -1, 1, INNER_RADIUS, OUTER_RADIUS);
//  rot = radians(frameCount/2);
  col = color((frameCount/4)%360, 80, 80);
  yHeight = yFactor*OUTER_RADIUS;

  pushStyle();
//  fill(col, 50);
  fill(0, 0, 100);
  pushMatrix();
  translate(width/2, height/2);
  translate(0, yHeight, 0);
  polygon(0, 0, radius, POINTS, rot, true);
  popMatrix();
  popStyle();

  if (SHOW_FPS) {
    frame.setTitle("FPS : " + nf(frameRate, 2, 4));
  }
}

void polygon(float x, float y, float radius, int npoints, float rotation, boolean pointsOnly) {
  float angle = TWO_PI / npoints;
  if (!pointsOnly) {
    beginShape();
  }

  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a + rotation) * radius;
    float sz = y + sin(a + rotation) * radius;
    pushMatrix();
    translate(sx, 0, sz);
    if (pointsOnly) {
      sphere(5);
    } else {
      vertex(sx, 0, sz);
    }
    popMatrix();
  }

  if (!pointsOnly) {
    endShape(CLOSE);
  }
}

void fadeRect(float opacity) {
  pushStyle();
  fill(0, opacity);
  rect(-1, -1, width+1, height+1);
  popStyle();
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

  cp5.addSlider("OUTER_RADIUS")
    .setPosition(C_MARGIN, C_MARGIN + 0 * C_HEIGHT)
      .setRange(10, width/2)
        .setGroup(group);

  cp5.addSlider("INNER_RADIUS")
    .setPosition(C_MARGIN, C_MARGIN + 1 * C_HEIGHT)
      .setRange(10, width/2)
        .setGroup(group);

  cp5.addSlider("POINTS")
    .setPosition(C_MARGIN, C_MARGIN + 2 * C_HEIGHT)
      .setRange(1, 20)
        .setGroup(group);

  // TODO: there has to be an easy way to move the label to the right...
//  cp5.addToggle("SHARE_ROTATION")
//    .setPosition(C_MARGIN, C_MARGIN + 4 * C_HEIGHT)
//      .setSize(9, 9)
//        .setGroup(group);
//
//  cp5.addToggle("POINTS_ONLY")
//    .setPosition(75, C_MARGIN + 4 * C_HEIGHT)
//      .setSize(9, 9)
//        .setGroup(group);
} 

