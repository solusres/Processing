import themidibus.MidiBus;

MidiBus midiBus;

// current mode of VMeter input
VMeterMode vMeterMode = VMeterMode.SIZE;

ArrayList<Emitter> emitters;

// whether to clear each frame (leaving trails or not)
boolean trails = false;

// how frequently new particles are born
// TODO: this implementation needs a little work
int FREQUENCY = 5;
int FREQUENCY_MIN = 5;
int FREQUENCY_MAX = 60;

// how many frames a particle will last ( NOTE: high values of this can degrade performance... )
float LIFESPAN = 300;
float LIFESPAN_MIN = 30;
float LIFESPAN_MAX = 600;

// size of particles when created
float BIRTHSIZE = 30;
float BIRTHSIZE_MIN = 8;
float BIRTHSIZE_MAX = 50;

// how many particle streams each emitter has
int NUM_STREAMS = 6;
int NUM_STREAMS_MIN = 1;
int NUM_STREAMS_MAX = 12;


void setup() {
  size(800,800,P2D);
  colorMode(HSB, 360, 100, 100);
  
  emitters = new ArrayList<Emitter>();
  emitters.add(new Emitter(new PVector(width/4,height/4)));
  emitters.add(new Emitter(new PVector(3*width/4,height/4)));
  emitters.add(new Emitter(new PVector(width/4,3*height/4)));
  emitters.add(new Emitter(new PVector(3*width/4,3*height/4)));
  
  midiBus = new MidiBus(this, "VMeter 1.30 0", "VMeter 1.30 0");
  background(0);
}

void draw() {
  blendMode(ADD);
  if (!trails) {
    background(0);
  }

  for (Emitter e : emitters) {
    e.run();
  }
}

/*
  Push keys to change what VMeter controls.
  
  f = FREQUENCY
  l = lifespan
  n = number of streams 
  s = size
  
  Also:
  
  t = toggle trails
*/
void keyPressed() {
  switch(key) {
    case 'f':
    case 'F': 
      setVMeterMode(VMeterMode.FREQUENCY);
      break;
    case 'l':
    case 'L': 
      setVMeterMode(VMeterMode.LIFESPAN);
      break;
    case 'n':
    case 'N': 
      setVMeterMode(VMeterMode.NUM_STREAMS);
      break;
    case 's':
    case 'S': 
      setVMeterMode(VMeterMode.SIZE);
      break;
    case 't':
    case 'T':
      trails = !trails;
      break;
  }
}

void setVMeterMode(VMeterMode mode) {
  if (vMeterMode != mode) {
    vMeterMode = mode;
    println(mode);
  } 
}

/** VMETER INPUT **/

void controllerChange(int channel, int number, int value) {
  switch(vMeterMode) {

    case FREQUENCY:
      // TODO: this is a bit crap.
      FREQUENCY = (FREQUENCY_MAX - round(map(value, 0, 127, FREQUENCY_MIN, FREQUENCY_MAX))) + FREQUENCY_MIN;
      break;

    case LIFESPAN:
      LIFESPAN = map(value, 0, 127, LIFESPAN_MIN, LIFESPAN_MAX);      
      break;
      
    case NUM_STREAMS:
      NUM_STREAMS = round(map(value, 0, 127, NUM_STREAMS_MIN, NUM_STREAMS_MAX));
      break;

    case SIZE:
      BIRTHSIZE = map(value, 0, 127, BIRTHSIZE_MIN, BIRTHSIZE_MAX); 
      break;
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
    this(loc, new PVector(random(-1,1),random(-1,1)));
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
    stroke(color_, opacity);
    fill(color_, opacity);
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
    rotation = PI*sin(radians(frameCount)/2); 
  }

  void addParticles() {
    int streams = NUM_STREAMS;
    double angle;
    for (int i=0; i < streams; i++) {
      angle = i*TWO_PI/streams + rotation;
      float x = sin((float)angle);
      float y = cos((float)angle);
      particles.add(new Particle(origin, new PVector(x, y), color(frameCount % 360, 80, 5)));//abs(sin(radians(frameCount))) * 50)));
        
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
