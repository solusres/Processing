class GridPolygon extends GridShape {
  int sides;
  float radius;
  float rotation;

  public GridPolygon(int sides, float radius) {
    this(sides, radius, 0);
  }

  public GridPolygon(int sides, float radius, float rotation) {
    this.sides = sides;
    this.radius = radius;
    this.rotation = rotation;
  }

  void draw() {
    strokeWeight(0.001);
    stroke(0, 100, 0);
    noFill();
    
    if (sides > 1) {
      polygon(0, 0, radius, sides);  
    } else {
      ellipse(0, 0, 2*radius, 2*radius);
    }
    
  }

  void polygon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a + rotation) * radius;
      float sy = y + sin(a + rotation) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}

