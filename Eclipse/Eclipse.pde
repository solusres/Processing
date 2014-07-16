import gifAnimation.*;
GifMaker gifExport;
boolean EXPORT = true;

int SIZE = 500;

float POINTS = 18;
float RADIUS = 0;
int G_SIZE = 200;

PVector center;

PGraphics pg;
PVector pgCenter;

PGraphics preScreen;

void setup() {
  size(SIZE, SIZE);
  smooth(8);
  colorMode(HSB, 360, 100, 100);
//  imageMode(CENTER);

  pg = createGraphics(G_SIZE, G_SIZE);

  pg.beginDraw();
  pg.colorMode(HSB, 360, 100, 100);

  pg.noStroke();

  pg.fill(210, 76, 95);
  pg.ellipse(pg.width/2, pg.height/2, pg.width, pg.height);

  pg.fill(0);
  pg.ellipse(pg.width/2, pg.height/2, pg.width*.96, pg.height);

  pg.endDraw();

  center = new PVector(width/2, height/2);
  pgCenter = new PVector(pg.width/2, pg.height/2);
  
  preScreen = createGraphics(SIZE, SIZE);
  
  if (EXPORT) {
    gifExport = new GifMaker(this, "export.gif");
    gifExport.setRepeat(0);
    gifExport.setQuality(1);
  }
}

void draw() {
  background(0);
  RADIUS = map(sin(radians(frameCount)), -1, 1, 0, 100);
  preScreen.beginDraw();
  preScreen.background(0);

  float theta, x, y;
  PVector loc;
  for (int i=0; i < POINTS/2; i++) {
    theta = (float(i)/POINTS * TWO_PI) - HALF_PI;

    for (int j=0; j < 2; j++) {
      x = cos(theta + PI*j) * RADIUS;
      y = sin(theta + PI*j) * RADIUS;

      loc = new PVector(x, y);
      loc.add(center);   // translate to center of sketch
      loc.sub(pgCenter); // simulate imageMode(CENTER)

      preScreen.blend(pg, 0, 0, pg.width, pg.height, int(loc.x), int(loc.y), pg.width, pg.height, ADD);
      
//      preScreen.image(pg, loc.x, loc.y);
    }
    
//    preScreen.blend(0,0,width,height,-1,-1,width+1,height+1,BLEND);
    preScreen.endDraw();
    
    image(preScreen, 0, 0);
  }
  
//  POINTS = map(sin(radians(frameCount)), -1, 1, 1, 36);
  frame.setTitle("FPS : " + nf(frameRate, 2, 4));
  
  if (EXPORT) {
    gifExport.setDelay(1000/60);
    gifExport.addFrame();

    if (sin(radians(frameCount)) == -1) {
      gifExport.finish();
      exit();
    }
  }
}

