import codeanticode.syphon.*;

int W = 700, 
H = 700, 
maxDis = 25, 
minRadius = 5, 
maxRadius = 25, 
bufferSize = 200, 
bufferRadius = bufferSize/8, 
c = bufferSize/2, 
shadowCol = #cccccc, 
x, y, 
radius;

PGraphics dropShadow;
PImage image;

SyphonServer syphon;

static final PVector triangleLUT[] = new PVector[] {
  new PVector(cos(TWO_PI/3), sin(TWO_PI/3)), 
  new PVector(cos(.666 * TWO_PI), sin(.666 * TWO_PI)), 
  new PVector(cos(TWO_PI), sin(TWO_PI))
  };

  void setup() {
    size(W, H, OPENGL);
    noStroke();
    imageMode(CENTER);

    //Shadow buffer
    dropShadow = createGraphics(bufferSize, bufferSize, OPENGL);
    dropShadow.beginDraw();
    dropShadow.smooth();
    dropShadow.noStroke();
    dropShadow.endDraw();
    drawTriangle(dropShadow, c, c, shadowCol, bufferRadius);
    dropShadow.beginDraw();
    dropShadow.filter(BLUR, 1);
    dropShadow.endDraw();

//    syphon = new SyphonServer(this, "Processing Syphon");
  }

void draw() {
  background(#EEEEEE);

  radius = 200;
  x = width/2;
  y = height/2;

  int INC = 20;
  int real_radius;
  for (radius = 200; radius > 0; radius-=INC) {
    real_radius = radius + (frameCount % INC);
    image = dropShadow.get();
//    image.resize(real_radius<<3, 0);
    image(image, x, y, real_radius<<3, real_radius<<3);
//    drawTriangle(g, x, y, #EE0000, real_radius);
  }


  if (frameCount % 30 == 0) {
    frame.setTitle(int(frameRate) + " fps");
  }

//  syphon.sendScreen();
}

static void drawTriangle(PGraphics canvas, int x, int y, int c, float r) {  
  if (x<0 || x>canvas.width || y<0 || y > canvas.height) return;
  canvas.beginDraw();
  canvas.fill(c);
  canvas.beginShape();
  for (int i = 0; i < 3; i++) canvas.vertex(x + triangleLUT[i].x * r, y + triangleLUT[i].y * r);    
  canvas.endShape(CLOSE);
  canvas.endDraw();
}
