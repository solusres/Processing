class OrbiterCubes extends Orbiter {
  int shapeCount;
  float shapeSize;

  public OrbiterCubes(float radius, int shapeCount, float shapeSize) {
    super(radius);
    this.shapeCount = shapeCount;
    this.shapeSize = shapeSize;
  }
  
  void update() {
    super.update();
  }

  void innerDraw() {
    pushStyle();
    noStroke();
    fill(200);

    float x, y, z, theta;
    for (int i = 0; i <= shapeCount; i++) {
      theta = i*TWO_PI/shapeCount;
      x = cos(theta)*this.radius;
      y = 0;
      z = sin(theta)*this.radius;
      pushMatrix();
      translate(x, y, z);
      rotateZ(theta + frameCount*0.05);
      box(shapeSize, shapeSize, shapeSize);
      popMatrix();
    }

    popStyle();
  }
}
