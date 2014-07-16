PGraphics[] gs;  

float rotx = 0;
float roty = 0;
float rot_current = 0;
float rot_vel_max = 0.003;
float rot_vel = 0;
float rot_acc = 0;

float a = 100;
float b = 1.5*a;

Scroller scroller;

void setup() { 
  size(800, 500, P3D);
  //  stroke(180, 180, 180);
  noStroke();
  textureMode(NORMAL);
  smooth(8);
  hint(ENABLE_DEPTH_SORT);

  gs = new PGraphics[4];

  for (int i=0; i < gs.length; i++) {
    gs[i] = createGraphics( 500, 500, P3D );
  }

  scroller = new Scroller(0, 0, 0);
}

void draw()                                              
{ 
  //  background(252, 252, 229);
  background(0);

  pushMatrix();

  translate(width/2, height/2, -scroller.z);

  roty = scroller.ry - rot_current%TWO_PI;
  rotx = scroller.rx - (rot_current/3.0)%TWO_PI;

  rotateY(roty);
  rotateX(rotx);

  for (PGraphics g : gs) {
    doGraphics(g);
  }

  tetra2();

  popMatrix();

  if (frameCount == 2*30) {
    rot_acc = 0.00001;
  } 
  else if (frameCount > 5*60 && rot_vel >= rot_vel_max) {
    rot_acc = 0;
  }

  rot_current += rot_vel;
  rot_vel += rot_acc;

  scroller.update();
} 


/* technique using strips, which is likely more efficient... */
void tetra1() {
  int x = 0;
  int y = 0;

  beginShape(TRIANGLE_STRIP);
  vertex(x, y + 44, -44);  // vertex 1
  vertex(x, y - 44, 0);    // vertex 2
  vertex(x - 50, y + 44, 44);  // vertex 3

  vertex(x + 50, y + 44, 44);   // vertex 4
  vertex(x, y + 44, -44);  // vertex 1

  vertex(x, y - 44, 0);    // vertex 2
  vertex(x + 50, y + 44, 44); // vertex 4

    vertex(x - 50, y + 44, 44);  // vertex 3
  vertex(x, y - 44, 0);    // vertex 2
  endShape(CLOSE);
}

/* technique using separate triangles, which makes textures easier */
void tetra2() {
  beginShape(TRIANGLES);
  texture(gs[0]);
  vertex(0, a, b, 0.5, 0);     /*purple apex*/
  vertex(b, -a, -0, 1, 1);      /*green apex?*/
  vertex(0, a, -b, 0, 1);         /*blue apex*/
  endShape();

  beginShape(TRIANGLES);
  texture(gs[1]);
  vertex(b, -a, 0, 0.5, 0);      /*green apex*/
  vertex(-b, -a, 0, 1, 1);      /*orange apex*/
  vertex( 0, a, -b, 0, 1);    /*blue apex*/
  endShape();

  beginShape(TRIANGLES);
  texture(gs[2]);
  vertex(0, a, b, 0.5, 0);      /*purple apex*/
  vertex(-b, -a, 0, 0, 1);     /*orange apex*/
  vertex( 0, a, -b, 1, 1);     /*blue apex*/
  endShape();

  beginShape(TRIANGLES);
  texture(gs[3]);
  vertex(0, a, b, 0.5, 0);      /*purple apex*/
  vertex(b, -a, 0, 0, 1);        /*green apex?*/
  vertex(-b, -a, 0, 1, 1);        /* orange apex?*/
  endShape();
}

void doGraphics(PGraphics g) {
  int SIZE = 500;
  int ROWS = 20;
  int INC = SIZE/ROWS;

  g.beginDraw();
  g.background(0);
  g.colorMode(HSB, 360, 100, 100);

  float a = radians(frameCount*2);
  float size;
  float offset;

  for (int x=INC; x < SIZE; x+=INC) {
    for (int y=INC; y < SIZE; y+=INC) {
      g.pushMatrix();
      g.translate(x, y);

      offset = (pow(SIZE/2-x, 2)+pow(SIZE/2-y, 2))/pow((SIZE/2), 2);
      size = sin(a-offset) * INC;
      g.fill((frameCount/2)%360, 80, 80);
      g.ellipse(0, 0, size, size);
      g.popMatrix();
    }
  }

  g.endDraw();
}

