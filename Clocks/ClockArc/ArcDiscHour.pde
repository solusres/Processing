class ArcDiscHour extends ArcDisc {
 
  public ArcDiscHour(color c, int r) {
    super(c, r);
  }
  
  int getIndex() {
    return hour()<=12?hour():hour()%12;
  }
  
  int getMax() {
    return 12; 
  }
}
