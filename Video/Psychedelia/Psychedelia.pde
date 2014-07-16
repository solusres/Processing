// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 16-13: Simple motion detection

import processing.video.*;
// Variable for capture device
Capture video;
// Previous Frame
PImage prevFrame;
// How different must a pixel be to be a "motion" pixel
float threshold = 50;

void setup() {
  size(640, 480);
  colorMode(HSB);
  //  println(Capture.list());
  video = new Capture(this, width, height, 30);
  video.start();
}

void draw() {
  if (video.available()) {
    video.read();
  }

  image(psyche(video), 0, 0);
}

PImage psyche(PImage img) {
  img.loadPixels();

  PImage ret = createImage(img.width, img.height, HSB);
  ret.loadPixels();

  float fluxFactor = (0.60*sin(0.823*radians(frameCount)) + 0.40*sin(0.916*radians(frameCount)));

  for (int i = 0; i < width; i++ ) {
    for (int j = 0; j < height; j++ ) {
      int loc = i + j*width;

      float hue = hue(img.pixels[loc]);
      float sat = saturation(img.pixels[loc]);
      float bri = brightness(img.pixels[loc]);

      hue = hue - 255*fluxFactor;
      if (hue < 0) {
        hue += 255;
      }

      ret.pixels[loc] = color(hue, sat, bri);
    }
  } 

  ret.updatePixels();

  return ret;
}

