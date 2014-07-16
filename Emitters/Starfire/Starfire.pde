import codeanticode.syphon.*;
import gifAnimation.*;
boolean EXPORT = false;

SyphonServer syphon;

ArrayList<Emitter> emitters;

// whether to clear each frame (leaving trails or not)
boolean trails = false;

int SIZE = 500;
// size of particles when created
int BIRTHSIZE = SIZE/10;
// how many frames a particle will last ( NOTE: high values of this can degrade performance... )
float LIFESPAN = SIZE/2;
// how frequently new particles are born (every x frames)
int FREQUENCY = 10;
// how many particle streams each emitter has
int NUM_STREAMS = 16;

GifMaker gifExport;

void setup() {
  size(SIZE, SIZE, OPENGL);
  colorMode(HSB, 360, 100, 100);
  smooth(8);
  hint(DISABLE_DEPTH_MASK);

  emitters = new ArrayList<Emitter>();

  emitters.add(new Emitter(new PVector(width/2, height/2)));

  if (EXPORT) {
    gifExport = new GifMaker(this, "export.gif");
    gifExport.setRepeat(0);             // make it an "endless" animation
    gifExport.setQuality(1);
  }

  background(0);
  
  syphon = new SyphonServer(this, "Processing Syphon");
}

void draw() {
  blendMode(ADD);
  if (!trails) {
    background(0);
  }

  for (Emitter e : emitters) {
    e.run();
    e.rotation = sin(radians(frameCount));
  }
  
  syphon.sendScreen();

//  frame.setTitle(int(frameRate) + " fps");

  if (EXPORT) {
    if (frameCount > 360) {
      gifExport.setDelay(1000/60);
      gifExport.addFrame();
    }
  
    if (frameCount >= 360*2) {
      gifExport.finish();
      exit();
    }
  }
}
