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
