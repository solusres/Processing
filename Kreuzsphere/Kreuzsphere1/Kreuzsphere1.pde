import processing.opengl.*;
import controlP5.*;

ControlP5 cp5;

boolean SHOW_FPS = false;

int POINTS = 5;
float OUTER_RADIUS = 150;
float INNER_RADIUS = 20;

float radius;
float rot;
color col;

void setup() {
  size(400, 600, OPENGL);
  colorMode(HSB, 360, 100, 100);
  background(0);
  noStroke();
  fill(255, 50);
  
//  createControls();
}

void draw() {
  //  background(0);
  //  fadeRect(1);
  lights();

  float factor = sin(radians(frameCount));

  radius = map(factor, -1, 1, INNER_RADIUS, OUTER_RADIUS);
  rot = radians(frameCount/2);
  col = color((frameCount/4)%360, 80, 80);

  pushStyle();
  fill(col, 50);
  pushMatrix();
  translate(width/2, height/2);

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
    float sy = y + sin(a + rotation) * radius;
    pushMatrix();
    translate(sx, sy);
    if (pointsOnly) {
      sphere(8);
    } else {
      vertex(sx, sy);
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

