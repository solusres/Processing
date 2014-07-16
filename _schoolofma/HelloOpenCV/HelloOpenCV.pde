import processing.video.*;
import gab.opencv.*;

final int W = 640;
final int H = 480;

OpenCV opencv;
boolean captureBg = false;
PImage bgImage;
Capture cam;

void setup() {
  size(W, H);
  opencv = new OpenCV(this, W, H);
  cam = new Capture(this, W, H);
  cam.start();
  bgImage = createImage(W, H, RGB);
  
//  opencv.startBackgroundSubtraction(5, 3, 0.5);
}

void draw() {
  if (cam.available()) {
    cam.read();
  }

  opencv.loadImage(cam);
  opencv.flip(1);
  if (captureBg) {
    bgImage = opencv.getSnapshot();
    captureBg = false;
  }
//  opencv.updateBackground();
  opencv.dilate();
  opencv.erode();
  
  opencv.diff(bgImage);
//  opencv.threshold(77);
//  opencv.erode();
  image(opencv.getOutput(), 0, 0);
//  image(cam.

//  ArrayList<Contour> contours = opencv.findContours(/* find inner holes */false, /* sort by size */true);
//
//  stroke(255, 0, 0);
//  for (Contour con : contours) {
//    con.draw();
//    pushStyle();
//    //    stroke(0, 255, 0);
//    //    noFill();
//    //    beginShape();
//    //    for (PVector point : con.getPolygonApproximation().getPoints()) {
//    //      vertex(point.x, point.y);
//    //    }
//    //    endShape();
//
//    float centerX = con.getBoundingBox().x + con.getBoundingBox().width/2;
//    float centerY = con.getBoundingBox().y + con.getBoundingBox().height/2;
//
//    stroke(255);
//    fill(255);
//    ellipse(centerX, centerY, 2, 2);
//    popStyle();
//  }

  if (frameCount % 30 == 0) {
    frame.setTitle("FPS : " + nf(frameRate, 2, 2));
  }
}

void keyPressed() {
  if (key == ' ') {
    captureBg = true;
  }
  if (key == 's') {
    String timestamp = getTimestamp();
    saveFrame("helloOpenCV-"+timestamp+".png");
  }
}

String getTimestamp() {
  return year() + nf(month(), 2) + nf(day(), 2) + "-" + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
}
