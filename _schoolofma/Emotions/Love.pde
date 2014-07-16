class Love extends Emotion {
  final float SEGMENTS = 720;

  float love;
  float theta = TWO_PI / SEGMENTS;
  float R = 50;

  public Love() {
    this.title_de = "die Liebe";
    this.title_en = "love";
  }

  void update() {
    float distance = SIZE/2 - dist(width/2, height/2, mouseX, mouseY);
    love = norm(distance, 0, SIZE*sqrt(2)/2);
    background(love * 200, 0,0);
  }

  void drawEmoter() {
    pushStyle();
    stroke(255);
    noFill();

    if (frameCount % 100 > 80 && frameCount % 100 < 85) {
      strokeWeight(constrain(30*love, 1, 15));
    } else if (frameCount % 100 > 96 && frameCount % 100 < 99) {
      strokeWeight(constrain(10*love, 1, 8));
    } else {
      strokeWeight(1);
    }

    pushMatrix();
    translate(width/2, height/2);
    ellipse(0, 0, 2*R + (love*100), 2*R + (love*100));
    popMatrix();
    popStyle();
  }
}
