import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;

final int W = 640;
final int H = 480;

OpenCV opencv;
Rectangle[] faces;
Capture cam;

void setup() {
  size(W, H);
  opencv = new OpenCV(this, W, H);
  cam = new Capture(this, W, H);
  cam.start();

  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
}

void draw() {
  if (cam.available()) {
    cam.read();
  }

  opencv.loadImage(cam);
  opencv.flip(1);
  
  image(opencv.getOutput(), 0, 0);
  faces = opencv.detect();

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}
