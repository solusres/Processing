class ArcDiscSecond extends ArcDisc {
 
  public ArcDiscSecond(color c, int r) {
    super(c, r);
  }
  
  int getIndex() {
    return second();
  }
  
  int getMax() {
    return 60; 
  }
}
