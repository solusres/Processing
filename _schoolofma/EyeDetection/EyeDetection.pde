import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;

final int W = 640;
final int H = 480;

OpenCV opencv;
Rectangle[] eyes;
Capture cam;

void setup() {
  size(W, H);
  opencv = new OpenCV(this, W, H);
  cam = new Capture(this, W, H);
  cam.start();

  opencv.loadCascade(OpenCV.CASCADE_EYE);
}

void draw() {
  if (cam.available()) {
    cam.read();
  }

  opencv.loadImage(cam);
//  opencv.flip(1);

  pushMatrix();
//  scale(-1, 1);
  image(cam.get(), 0, 0, width, height);
  popMatrix();
  eyes = opencv.detect();

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);

//  if (eyes.length == 2) {
//    println("TWO EYES");
    for (int i = 0; i < eyes.length; i++) {
      PImage eye = cam.get(eyes[i].x, eyes[i].y, eyes[i].width, eyes[i].height);
      if ((i+1)%2 < eyes.length) {
        image(eye, int(eyes[(i+1)%2].x), int(eyes[(i+1)%2].y));
      }
//      image(eye, 0, 0);

      //    rect(eyes[i].x, eyes[i].y, eyes[i].width, eyes[i].height);
      //    text(i, eyes[i].x, eyes[i].y);
    }
//  }
}

void keyPressed() {
  if (key == 's') {
    String timestamp = getTimestamp();
    saveFrame("helloOpenCV-"+timestamp+".png");
  }
}

String getTimestamp() {
  return year() + nf(month(), 2) + nf(day(), 2) + "-" + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
}
