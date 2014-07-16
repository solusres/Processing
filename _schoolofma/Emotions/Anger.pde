class Anger extends Emotion {
  float R = 50;
  float ANGER_MUL = 250;
  float SEGMENTS = 720;
  
  float anger;
  float noise = random(10);
  float theta = TWO_PI / SEGMENTS;
  
  public Anger() {
    this.title_de = "die Ärger";
    this.title_en = "anger";
  }

  void update() {
    float distance = SIZE/2 - dist(width/2, height/2, mouseX, mouseY);
    anger = norm(constrain(distance, 0, SIZE/2), 0, SIZE/2);
  }

  void drawEmoter() {
    pushStyle();
    noFill();
    stroke(lerpColor(#FFFFFF, #FF0000,anger));
    strokeWeight(constrain(anger*10, 1, 10));

    pushMatrix();
    translate(width/2, height/2);

    float x, y;
    float howAngry = anger * ANGER_MUL;

    beginShape();

    for (float a = 0; a < TWO_PI; a += theta) {
      float radius = (R + noise(noise)*howAngry);
      
      x = cos(a) * radius;
      y = sin(a) * radius;
      
      vertex(x, y);
      
      noise += 0.01;
    }
    
    endShape();

    popMatrix();
    popStyle();
  }
}
