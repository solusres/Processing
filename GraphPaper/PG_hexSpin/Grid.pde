class Grid {
  public boolean DEBUG = false;

  public float x_inc;
  public float y_inc;
  public float x_max;
  public float y_max;
  // shifts alternating rows/cols
  public float x_offset;
  public float y_offset;

  // list of shapes to draw at each point
  // TODO: currently draws all shapes at each point,
  //       but could alternate one per point...
  public ArrayList<GridShape> shapes;

  /**
   * CONSTRUCTICORS
   */
  public Grid(int cols, int rows, float x_inc, float y_inc) {
    this(cols, rows, x_inc, y_inc, 0, 0);
  }

  public Grid(int cols, int rows, float x_inc, float y_inc, float x_offset, float y_offset) {
    this.x_inc = x_inc;
    this.y_inc = y_inc;
    this.x_max = x_inc * cols;
    this.y_max = y_inc * rows;
    this.x_offset = x_offset;
    this.y_offset = y_offset;

    shapes = new ArrayList<GridShape>();
  }

  /**
   * Draw the grid
   */
  void draw() {
    float local_x_off;
    float local_y_off;

    pushStyle();

    int x = 0;
    int y = 0;

    for (int xi = 0; xi <= x_max/x_inc; xi++) {
      x = int(xi * x_inc);
      for (int yi = 0; yi <= y_max/y_inc; yi++) {
        y = int(yi * y_inc);
        local_x_off = (yi%2==0) ? 0 : x_offset;
        local_y_off = (xi%2==0) ? 0 : y_offset;

        if (DEBUG) {
          drawGridPoint(x + local_x_off, y + local_y_off);
        }

        drawShape(x + local_x_off, y + local_y_off);
      }
    }
    popStyle();
  }

  void drawShape(float x, float y) {
    for (GridShape shape : shapes) {
      shape.draw(x, y);
    }
  }

  /**
   * Useful for debugging.
   */
  void drawGridPoint(float x, float y) {
    pushStyle();
    stroke(360, 100, 100);
    fill(360, 100, 100);
    ellipse(x, y, 3, 3);
    popStyle();
  }
}

