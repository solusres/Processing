import SimpleOpenNI.*;

import org.openkinect.*;
import org.openkinect.processing.*;

int W = 640;
int H = 480;

boolean USE_OPENKINECT = false;

Kinect kinect;
SimpleOpenNI openni;

void setup() {
  size(2*W, H);

  if (USE_OPENKINECT) {
    kinect = new Kinect(this);
    kinect.start();
    kinect.enableDepth(true);
    kinect.enableRGB(true);
  } else {
    openni = new SimpleOpenNI(this);
    openni.enableDepth();
    openni.enableRGB();
  }
}

void draw() {
  background(0);

  if (USE_OPENKINECT) {
    image(kinect.getDepthImage(), 0, 0);
    image(kinect.getVideoImage(), W, 0);
  } else {
    openni.update();
    image(openni.depthImage(), 0, 0);
    image(openni.rgbImage(), W, 0);
  }

  if (frameCount % 30 == 0) {
    frame.setTitle("FPS : " + nf(frameRate, 2, 4));
  }
}

void stop() {
  kinect.quit();
  super.stop();
}
