class GridPolygonSpin extends GridPolygon {

  public GridPolygonSpin(int sides, float radius) {
    super(sides, radius);
  }
  
  void draw() {
    rotation = map(sin(radians(frameCount/4)), -1, 1, 0, PI);
    
    super.draw();
  }
}

