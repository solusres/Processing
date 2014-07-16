abstract class Orbiter {
  float radius;
  PVector rotation;
  PVector currRotation;

  public Orbiter(float radius) {
    this.radius = radius;
    this.rotation = new PVector(random(-0.005, 0.005), random(-0.01, 0.01), random(-0.005, 0.005));
    this.currRotation = new PVector(0, 0, 0);
  }

  void setRotation(PVector rotation) {
    this.rotation = rotation;
  }

  void setRadius(float radius) {
    this.radius = radius;
  }

  void update() {
    this.currRotation.add(this.rotation);
  }

  void draw() {
    update();

    pushMatrix();
    rotateX(currRotation.x);
    rotateY(currRotation.y);
    rotateZ(currRotation.z);
    
    innerDraw();
    
    popMatrix();
  }
  
  abstract void innerDraw();
}
