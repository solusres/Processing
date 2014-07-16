class Goal {
  int x, y;
  int radius;

  public Goal(int x, int y, int radius) {
    this.x = x;
    this.y = y;
    this.radius = radius;
  }

  void draw() {
    pushStyle();
    stroke(255,0,0);
    strokeWeight(2);
    fill(255, 40);
    ellipse(x, y, radius*2, radius*2);
    popStyle();
  }
  
  boolean isInside(PVector p) {
    return pow((p.x - this.x),2) + pow((p.y - this.y),2) < pow(this.radius, 2);
  }
}
