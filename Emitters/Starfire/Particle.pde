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
    fill(color_, opacity);
    ellipse(location.x, location.y, size, size);
  }

  boolean isDead() {
    return life < 0;
  }
}
