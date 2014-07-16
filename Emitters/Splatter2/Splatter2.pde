ArrayList<Emitter> emitters;

// whether to clear each frame (leaving trails or not)
boolean trails = false;

// how frequently new particles are born
// TODO: this implementation needs a little work
int FREQUENCY = 10;
int FREQUENCY_MIN = 5;
int FREQUENCY_MAX = 60;

// how many frames a particle will last ( NOTE: high values of this can degrade performance... )
float LIFESPAN = 200;
float LIFESPAN_MIN = 30;
float LIFESPAN_MAX = 600;

// size of particles when created
float BIRTHSIZE = 30;
float BIRTHSIZE_MIN = 8;
float BIRTHSIZE_MAX = 50;

// how many particle streams each emitter has
int NUM_STREAMS = 2;
int NUM_STREAMS_MIN = 1;
int NUM_STREAMS_MAX = 12;


void setup() {
  size(800,800,P2D);
  colorMode(HSB, 360, 100, 100);
  
  emitters = new ArrayList<Emitter>();
  float points = 12;
  float radius = width/4;
  float angle;
  float x;
  float y;
  
  for (int i=0; i < points; i++) {
    angle = i*TWO_PI/points;
    x = (cos(angle) * radius) + width/2;
    y = (sin(angle) * radius) + height/2;
    Emitter e = new Emitter(new PVector(x,y));
    e.rotation = angle*2;
    emitters.add(e);
  }
  
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
  frame.setTitle(int(frameRate) + " fps");
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
