class Guides implements Paintable {
  private color colour;
  
  public Guides(color c) {
    colour = c;
  }
  
  void paint() {
    stroke(colour);
    for (int i=1; i <= 12; i++) {
      float f = (float)(i)/12;
      arc(width/2, height/2, width-1, height-1, f*TWO_PI, f*TWO_PI);
    }
  }
}
