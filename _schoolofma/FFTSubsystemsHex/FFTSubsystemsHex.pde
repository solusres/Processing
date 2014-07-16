import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import peasy.*;

boolean EXPORT = false;

final int SIDES = 6;
final int SHAPE_COUNT = 10;
//final String TRACKNAME = "subsystems_22.mp3";
final String TRACKNAME = "chocolatedog.mp3";

PeasyCam cam;
boolean isRotating = true;

// shapes
boolean drawHexes = true;
ArrayList<PVector> LUT;
PShape shapeGroup;
float shapeHeight = 50;
float shapeSpacing = 1;

ArrayList<Orbiter> orbiters;

// sounds
Minim minim;
FilePlayer song;
FFT fft;
float rawFFT[];
Envelope env;
AudioOutput out;

// frequency foo
float SMOOTHING = 0.8;

FreqRange bass = new FreqRange(20, 200);
float bassLast;
FreqRange snare = new FreqRange(10000, 11000);

PShader blur;

int SIZE = 800;

void setup() {
  size(SIZE, SIZE, OPENGL);

  cam = new PeasyCam(this, width/2, height/2, 0, 1000);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(1500);

  initShapes();
  initSounds();

  blur = loadShader("blur.glsl");
  background(0);
}

void draw() {
  update();

  background(0);
  //  filter(blur);
  lights();

  drawFFTCross();

  pushMatrix();
  translate(width/2, height/2);

  drawShapes();
  drawOrbiters();
  pointLight(0, 0, 255, 0, 0, 0);

  popMatrix();

  drawHUD();

  drawFPS();
  
  if (frameCount == 120) {
    background(255);
    song.play(); 
  }
  
  if (EXPORT) {
    saveFrame("video/frame-#####.tif");
  }
}

//// END P5 LOOP
////
//// BEGIN INIT FUNCTIONS

void initShapes() {
  pushStyle();
  fill(0, 0, 180, 100);
  stroke(0, 200);
  shapeGroup = createShape(GROUP);

  LUT = new ArrayList<PVector>(SIDES);
  float theta = TWO_PI/SIDES;
  for (int i = 0; i < SIDES; i++) {
    LUT.add(new PVector(cos(i*theta), sin(i*theta)));
  }

  PShape currShape;
  PVector point;
  float radius;
  for (int i = 0; i < SHAPE_COUNT; i++) {
    currShape = createShape();
    currShape.beginShape(QUAD_STRIP);

    int flip = 1;
    for (int j = 0; j <= SIDES; j++) {

      if (j==SIDES) {
        // connect that last side
        point = LUT.get(0);
      } else {
        point = LUT.get(j);
      }

      radius = i * shapeSpacing;
      currShape.vertex(point.x*radius, shapeHeight * flip, point.y*radius);
      currShape.vertex(point.x*radius, -shapeHeight * flip, point.y*radius);
      //      flip *= -1; // hmm... I'm surprised it works without this, but ok.
    }
    currShape.endShape();

    shapeGroup.addChild(currShape);
  }
  popStyle();

  orbiters = new ArrayList<Orbiter>();
  orbiters.add(new OrbiterCubes(300, 300, 15));
  orbiters.add(new OrbiterCubes(400, 120, 8));
  orbiters.add(new OrbiterCubes(250, 240, 6));
  orbiters.add(new OrbiterCubes(250, 240, 6));
} 

void initSounds() {
  minim = new Minim(this);  
  out = minim.getLineOut();

  song = new FilePlayer(minim.loadFileStream(TRACKNAME, 1024, true));
  fft = new FFT(1024, 44100);
  fft.logAverages(120, 20);
  rawFFT = new float[fft.avgSize()];
  env = new Envelope(fft.avgSize());

  song.patch(out);
  song.pause();
  song.rewind(); // this is ridiculous, but play happens on .patch
}

//// END INIT FUNCTIONS
////
//// BEGIN UPDATE FUNCTIONS

void rotateCamera() {
  if (isRotating) {
    cam.rotateX(0.003);
    cam.rotateY(0.002);
    cam.rotateZ(0.001);
  }
}

void update() {
  // rotate the camera
  rotateCamera();

  PShape curr;
  int children = shapeGroup.getChildCount();
  for (int c=0; c < children; c++) {
    curr = shapeGroup.getChild(c);
    curr.resetMatrix();
    curr.scale(1, map(sin((frameCount+10*c)*0.05), -1, 1, 0.98*(children-c)/2, 1.02*(children-c)/2), 1);
  }

  updateFFT();
  updateFreqRanges();
}

void updateFFT() {
  // run the FFT
  fft.forward(out.mix);

  // get the frequency averages
  for (int i = 0; i < fft.avgSize (); i++) {
    rawFFT[i] = fft.getAvg(i);
  }

  // normalize values across the spectrum
  // (so bass freq values aren't huge)
  // (well... *as* huge...)
  env.apply(rawFFT);
}

void updateFreqRanges() {
  // UPDATE BASS
  float bassAmp =  bass.getAvgWithMin(fft, 1);

  // use some smoothing make things less erratic
  bassAmp = bassLast * SMOOTHING + bassAmp * (1-SMOOTHING);
  bassLast = bassAmp;

  // blast the shapeagons
  shapeGroup.resetMatrix();
  shapeGroup.scale(bassAmp, 1, bassAmp);

  // UPDATE SNARE
  float amp = snare.getAvg(fft);
  float snareScale = 100;
  Orbiter o = orbiters.get(1);
  o.radius = o.radius * SMOOTHING + (amp * snareScale) * (1-SMOOTHING);
}

//// END UPDATE FUNCTIONS
//// 
//// BEGIN DRAW FUNCTIONS

void drawFPS() {
  if (frameCount % 30 == 0) {
    frame.setTitle("FPS : " + nf(frameRate, 2, 2));
  }
}

void drawShapes() {
  if (drawHexes) {
    shape(shapeGroup, 0, 0);
  }
}

void drawOrbiters() {
  for (Orbiter o : orbiters) {
    o.draw();
  }
}

void drawFFTCross() {
  drawFFT();
  pushMatrix();
  translate(width/2, height/2);
  rotateX(HALF_PI);
  translate(-width/2, -height/2);
  drawFFT();
  popMatrix();
}

void drawFFT() {
  pushStyle();
  stroke(255, 50);

  float fftAvg;
  float slices = fft.avgSize();
  float sliceWidth = width/slices;
  int barWidth = 2;

  for (int i = 0; i < slices; i++) {
    fftAvg = rawFFT[i];
    fftAvg *= 100; // embiggening
    rect(i*sliceWidth, (height-fftAvg)/2, barWidth, fftAvg);
  }
  popStyle();
}

void drawHUD() {
  cam.beginHUD();
  // just FYI
  //  pushStyle();
  //  fill(255);
  //  text(fft.avgSize() + " avgs in FFT", 0, textAscent());
  //  popStyle();
  cam.endHUD();
}

//// END DRAW FUNCTIONS
////
//// BEGIN HANDLER FUNCTIONS

void keyPressed() {
  if (key == ' ') {
    if (song.isPlaying()) {
      song.pause();
    } else {
      song.play();
    }
  }

  if (key == 's') {
    String timestamp = getTimestamp();
    save(this.getClass().getName() + "-" + timestamp + ".jpg");
  }

  if (key == 'c') {
    isRotating = !isRotating;
  }
  
  if (key == 'h') {
    drawHexes = !drawHexes; 
  }

  if (keyCode == 37) { // left arrow {
    song.rewind();
  }
}

//// END HANDLER FUNCTIONS
////
//// BEGIN UTIL FUNCTIONS

String getTimestamp() {
  return year() + nf(month(), 2) + nf(day(), 2) + "-" + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
}

void stop() {
  song.close();
  minim.stop(); 
  super.stop();
}
