abstract class GridShape {

  public GridShape() {
  }

  void draw(float x, float y) {
    pushMatrix();
    translate(x, y);
    this.draw();
    popMatrix();
  }

  abstract void draw();
}

