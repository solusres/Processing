import gifAnimation.*;
boolean EXPORT = false;

ArrayList<Emitter> emitters;

// whether to clear each frame (leaving trails or not)
boolean trails = false;

int SIZE = 500;
// size of particles when created
int BIRTHSIZE = SIZE/30;
// how many frames a particle will last ( NOTE: high values of this can degrade performance... )
float LIFESPAN = SIZE*2/9;
// how frequently new particles are born (every x frames)
int FREQUENCY = 10;
// how many particle streams each emitter has
int NUM_STREAMS = 2;
int POINTS = 12;

GifMaker gifExport;

void setup() {
  size(SIZE, SIZE, P2D);
  colorMode(HSB, 360, 100, 100);
  smooth();
  hint(DISABLE_DEPTH_MASK);

  emitters = new ArrayList<Emitter>();
  float radius = width/4;
  float angle;
  float x;
  float y;

  for (int i=0; i < POINTS; i++) {
    angle = i*TWO_PI/POINTS;
    x = (cos(angle) * radius) + width/2;
    y = (sin(angle) * radius) + height/2;
    Emitter e = new Emitter(new PVector(x, y));
    e.rotation = angle*2;
    emitters.add(e);
  }

  if (EXPORT) {
    gifExport = new GifMaker(this, "export.gif");
    gifExport.setRepeat(0);             // make it an "endless" animation
    gifExport.setQuality(1);
  }

  background(0);
}

void draw() {
  blendMode(ADD);
  if (!trails) {
    background(0);
  }

  float radius = sin(radians(frameCount)/2) * (width/4);
  float angle;
  float x;
  float y;

  pushStyle();
  fill(frameCount % 360, 80, 5);
  for (int i=0; i < POINTS/2; i++) {
    angle = i*TWO_PI/(POINTS/2);
    x = (cos(angle) * radius) + width/2;
    y = (sin(angle) * radius) + height/2;

    for (int s = 12; s >= 0 ; s--) {
      int size = s * BIRTHSIZE + 1;
      ellipse(x, y, size, size);
    }
  }
  popStyle();

  for (Emitter e : emitters) {
    e.run();
  }

  frame.setTitle(int(frameRate) + " fps");

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

/** PARTICLE **/

class Particle {
  PVector location;
  PVector velocity;
  color color_;
  float lifespan = LIFESPAN;
  float life;
  float birthsize = BIRTHSIZE;
  float size;

  Particle(PVector loc) {    
    this(loc, new PVector(random(-1, 1), random(-1, 1)));
  }

  Particle (PVector loc, PVector vel) {
    this(loc, vel, color(255));
  }

  Particle (PVector loc, PVector vel, color c) {
    location = loc.get();
    velocity = vel.get();
    color_ = c;
    life = lifespan;
    size = birthsize;
  }

  void run() {
    update();
    display();
  }

  void update() {
    location.add(velocity);
    size = (life/lifespan)*birthsize;
    life--;
  }

  void display() {
    float opacity = max(min(255, life), 0);
    stroke(color_);
    fill(color_);
    ellipse(location.x, location.y, size, size);
  }

  boolean isDead() {
    return life < 0;
  }
}

/** EMITTER **/

class Emitter {
  ArrayList<Particle> particles;
  PVector origin;
  double rotation;

  Emitter(PVector location) {
    particles = new ArrayList<Particle>();
    origin = location.get();
    rotation = 0;
  }

  void run() {
    update();
    if (frameCount % FREQUENCY == 0) {
      addParticles();
    }
    updateParticles();
  }

  void update() {
    //    rotation = PI*sin(radians(frameCount)*4);
  }

  void addParticles() {
    int streams = NUM_STREAMS;
    double angle;
    for (int i=0; i < streams; i++) {
      angle = i*TWO_PI/streams + rotation;
      float x = sin((float)angle);
      float y = cos((float)angle);
      particles.add(new Particle(origin, new PVector(x, y), color(frameCount % 360, 80, 50)));
    }
  }

  void updateParticles() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}

