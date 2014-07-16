/*
 * Sagrada
 * #ProgramaLaPlaza
 * 
 * Soma Holiday
 * somaholiday@gmail.com
 * @somahol
 */

ArrayList<Emitter> emitters;

//int SIZE = 500;
int SIZE = 157;
// size of particles when created
int BIRTHSIZE = SIZE/30;
// how many frames a particle will last ( NOTE: high values of this can degrade performance... )
float LIFESPAN = SIZE*2/10;
// how frequently new particles are born (every x frames)
int FREQUENCY = 5;
// how many particle streams each emitter has
int NUM_STREAMS = 2;
int POINTS = 12;

int ELLIPSE_R = 121;

int HALF_POINTS_LU = POINTS/2;
float ANGLE_LU = TWO_PI/HALF_POINTS_LU;

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
    x = (cos(angle) * radius);
    y = (sin(angle) * radius);
    Emitter e = new Emitter(new PVector(x, y));
    e.rotation = angle*2;
    emitters.add(e);
  }
}

void draw() {
  pushStyle();
  fill(0, 0, 0, 5);
  noStroke();
  rect(-1, -1, width+1, height+1);
  popStyle();

  pushMatrix();
  translate(width/2, height/2);
  rotate(cos(radians(frameCount/3))*PI);

  float radius = sin(radians(frameCount*2)/2) * (width/4);
  float angle;
  float x;
  float y;

  pushStyle();

  // ELLIPSES 1
  fill(0, 0, 0, 2);
  stroke((frameCount + 180) % 360, 80, 50);
  for (int i=0; i < HALF_POINTS_LU; i++) {
    angle = i*ANGLE_LU;
    x = (cos(angle) * radius);
    y = (sin(angle) * radius);

    ellipse(x, y, ELLIPSE_R, ELLIPSE_R);
  }

  // EMITTERS
  for (Emitter e : emitters) {
    e.run();
  }

  // ELLIPSES 2
  noFill();
  stroke((frameCount + 180) % 360, 80, 50);
  for (int i=0; i < HALF_POINTS_LU; i++) {
    angle = i*ANGLE_LU + HALF_PI;
    x = (cos(angle) * radius*1.5);
    y = (sin(angle) * radius*1.5);

    ellipse(x, y, ELLIPSE_R, ELLIPSE_R);
  }
  popStyle();
  
  popMatrix();

//  fill(0, 0, 100);
//  text(frameRate, 0, 0);
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
    pushStyle();
    stroke(color_);
    fill(color_);
    ellipse(location.x, location.y, size, size);
    popStyle();
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

  double ANGLE_LU = TWO_PI/NUM_STREAMS;

  Emitter(PVector location) {
    particles = new ArrayList<Particle>();
    origin = location.get();
    rotation = 0;
  }

  void run() {
    //    update();
    if (frameCount % FREQUENCY == 0) {
      addParticles();
    }
    updateParticles();
  }

  void update() {
    //    rotation = PI*sin(radians(frameCount)*4);
  }

  void addParticles() {
    double angle;
    for (int i=0; i < NUM_STREAMS; i++) {
      angle = i*ANGLE_LU + rotation;
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


