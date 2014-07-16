class ArcDiscMinute extends ArcDisc {
 
  public ArcDiscMinute(color c, int r) {
    super(c, r);
  }
  
  int getIndex() {
    return minute();
  }
  
  int getMax() {
    return 60; 
  }
}
