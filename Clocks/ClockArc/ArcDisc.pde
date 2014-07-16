abstract class ArcDisc implements Paintable {
  private color colour;
  private int radius;
  
  private int lastIndex = -1;
  private int curIndex;
  private int turnoverFadeFrame = 0;
  private int fadeInFrame = 0;
  
  private final float NORTH = 270;  
  
  public ArcDisc(color c, int r) {
    colour = c;
    radius = r;
  }
  
  abstract int getIndex();
  abstract int getMax();
 
  void paint() {
    curIndex = getIndex();
    handleTurnoverFade();
    
    // if the index has changed and there's no current fade-in, start new fade-in
    if (curIndex != lastIndex && fadeInFrame == 0) {
      fadeInFrame = 30;
    }

    if (fadeInFrame > 0) {
      // paint last index solid
      paintDisc(lastIndex);
      
      // fade next index in
      float a = map(fadeInFrame, 0, 30, 255, 0);
      paintDisc(curIndex, a);
      fadeInFrame--;
      if (fadeInFrame == 0) {
        lastIndex = curIndex;
      }
    } else {
      paintDisc(curIndex);
    }
  }
  
  void paintDisc(int index) {
     paintDisc(index, 255);
  }
  
  void paintDisc(int index, float a) {
    noStroke();
    fill(colour, a);
    index = index==0?getMax():index;
    float angle = map(index, 0, getMax(), 0, 360);
    arc(width/2, height/2, radius, radius, radians(NORTH), radians(angle+NORTH));
  }
  
  // makes the full ellipse fade out nicely when turning over to the next minute/hour/day
  void handleTurnoverFade() {
    if (curIndex != lastIndex && lastIndex == 0) {
      turnoverFadeFrame = 30;
    }
    if (turnoverFadeFrame > 0) {
      noStroke();
      float a = map(turnoverFadeFrame, 0, 30, 0, 255);
      fill(colour, a);
      ellipse(width/2, height/2, radius, radius);
      turnoverFadeFrame--;
    }
  }
}
