PGraphics pg;
PGraphics pgAux;
float Rad;

void setup() {
  size (800, 450, P2D);
  pg = createGraphics (width, height, P2D);
  pgAux = createGraphics (width, height, P2D);
  background(0);
}


void draw() {
  pg.beginDraw();
  pg.background(0);
  pg.image(pgAux, 0, 0, width, height);
  pg.stroke(255, 5);
  pg.fill(255, 0, 0, 150);
  Rad = random(15)+width*noise(mouseX)/10;
  pg.ellipse(mouseX, mouseY, Rad, Rad);
  pg.endDraw();

  image (pg, 0, 0);

  pgAux.beginDraw();
  pgAux.background(0);
  pgAux.image (pg, 5, 5, width-10, height-10);
  pgAux.endDraw();
}

