/*
* Start coding and have fun! 
 * if you want you can use this header
 * to explain your project!
 * 
 */


ArrayList<Emitter> emitters;

// how frequently new particles are born
// {5, 60}
// TODO: this implementation needs a little work
int FREQUENCY = 5;

// how many frames a particle will last ( NOTE: high values of this can degrade performance... )
// {30, 600}
float LIFESPAN = 60;

// size of particles when created
// {8, 50}
float BIRTHSIZE = 15;

// how many particle streams each emitter has
// {1, 12}
int NUM_STREAMS = 3;

float POINTS = 6;

void setup() {
  size(192, 157); 
  background(0); 
  frameRate(25);
  colorMode(HSB, 360, 100, 100);

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
}

void draw() {
  background(0);

//  x = (cos(angle + radians(frameCount)) * radius) + width/2;
//  y = (sin(angle + radians(frameCount)) * radius) + height/2;

  for (Emitter e : emitters) {
    e.run();
  }
  maskFacade();
}

// masks out the unaddressable portion of the facade
void maskFacade() {
  pushStyle();
  noStroke();
  fill(255);

  beginShape();
  vertex(  0, 0);
  vertex(  0, 32);
  vertex( 36, 32);
  vertex( 36, 16);
  vertex( 72, 16);
  vertex( 72, 0);
  endShape(CLOSE);

  beginShape();
  vertex(120, 0);
  vertex(120, 16);
  vertex(156, 16);
  vertex(156, 32);
  vertex(192, 32);
  vertex(192, 0);
  endShape(CLOSE);

  popStyle();
}

/** PARTICLE **/

class Particle {
  PVector location;
  PVector velocity;
  color color_;
  float life;  
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
    life = LIFESPAN;
    size = BIRTHSIZE;
  }

  void run() {
    update();
    display();
  }

  void update() {
    location.add(velocity);
    size = (life/LIFESPAN)*BIRTHSIZE;
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

  void setLoc(PVector location) {
    origin = location.get();
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
      particles.add(new Particle(origin, new PVector(x, y), color(frameCount % 360, 100, 80)));
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

