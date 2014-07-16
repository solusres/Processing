class Fear extends Emotion {
  final float R = 50;
  final float SEGMENTS = 720;
  final float FEAR_THRESH = 50;

  float fear;
  float noise = random(10);  
  float theta = TWO_PI / SEGMENTS;
  
  public Fear() {
    this.title_de = "die Angst";
    this.title_en = "fear";
  }

  void update() {
    float distance = SIZE/2 - dist(width/2, height/2, mouseX, mouseY);
  }

  void drawEmoter() {
    pushStyle();
    stroke(255);
    noFill();

    pushMatrix();
    translate(width/2, height/2);

    PVector pos = new PVector();
    PVector posMouse = new PVector(mouseX - width/2, mouseY - height/2);

    beginShape();
    for (float a = 0; a < TWO_PI; a += theta) {
      pos.x = cos(a) * R;
      pos.y = sin(a) * R;
      
      float distance = pos.dist(posMouse);
      
      if (distance < FEAR_THRESH) {
        float twixt = PVector.angleBetween(pos, posMouse);
        pos.sub(new PVector(cos(twixt) * 10, sin(twixt) * 10));
      }

      vertex(pos.x, pos.y);
    }
    endShape(CLOSE);

    popMatrix();
    popStyle();
  }
}
