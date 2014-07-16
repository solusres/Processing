// Page 244 - 1

void setup() {
  size(800, 800);
  background(#202020);
  smooth();
  frameRate(30);

  rectMode(CENTER);
  blendMode(SCREEN);
  colorMode(HSB, 360, 100, 100);
}

/*void draw() {
  fill(#202020, 190);
  noStroke();
  rect(width / 2, height / 2, width, height);
  //noFill();

  pushMatrix();
  for (int x = 20; x < width - 10; x += 20) {
    for (int y = 20; y < height - 10; y += 20) {
    float mouse = atan2(mouseY - y, mouseX - x);
    pushMatrix();
      translate(x, y);
      rotate(mouse);
      stroke(abs(mouse) * 114, 80, 80);
      triangle(0, 0, - 10, 5, - 10, -5);
      stroke(#FF50BB);
      point(0, 0);
      popMatrix();
    }
  }
  popMatrix();
}*/
void draw() {
  fill(#202020, 190);
  noStroke();
  rect(width / 2, height / 2, width, height);
  //noFill();

  pushMatrix();
  translate(width / 2, height / 2);
  for (int deg = 0; deg < 360; deg += 4) {
    float angle = radians(deg);
    float radius = 200;
    float x = cos(angle) * radius;
    float y = sin(angle) * radius;
    float mouse = atan2(mouseY - height / 2 - y, mouseX - width / 2 - x);
    pushMatrix();
    translate(x, y);
    rotate(mouse);
    stroke(deg, 80, 80);
    triangle(0, 0, - 100, 40, - 100, -40);
    //triangle(x, y, x - 60 , y + 10, x - 60, y -10);
    stroke(#FF50BB);
    point(0, 0);
    popMatrix();
  }
  popMatrix();
}
