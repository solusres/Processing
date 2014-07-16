class OrbiterArcs extends Orbiter {
  float width;
  float angle;
  
  public OrbiterArcs(float radius, float width, float angle) {
    super(radius);
    this.width = width;
    this.angle = angle;
  }

  void innerDraw() {
//    pushStyle();
//    noStroke();
//    fill(200);
//
//    float x, y, z, theta;
//    for (int i = 0; i <= shapeCount; i++) {
//      theta = i*TWO_PI/shapeCount;
//      x = cos(theta)*this.radius;
//      y = 0;
//      z = sin(theta)*this.radius;
//      pushMatrix();
//      translate(x, y, z);
//      rotateZ(theta + frameCount*0.05);
//      box(shapeSize, shapeSize, shapeSize);
//      popMatrix();
//    }
//
//    popStyle();
  }
}
