/* @pjs preload="img/i1.jpg, img/i2.jpg, img/i3.jpg, img/i4.jpg"; */
PImage[] imgs;  

float rotx = 0;
float roty = 0;
float rot_current = 0;
float rot_vel_max = 0.003;
float rot_vel = 0;
float rot_acc = 0;

float a = 100;
float b = 1.5*a;

Scroller scroller;

boolean lightsOn = true;

void setup() { 
  size(800, 500, P3D);
  //  stroke(180, 180, 180);
  noStroke();
  textureMode(NORMAL);
  smooth(8);
  hint(ENABLE_DEPTH_SORT);

  imgs = new PImage[4];

  for (int i=0; i < imgs.length; i++) {
    imgs[i] = loadImage("img/i" + (i+1) + ".jpg");
  }

  scroller = new Scroller(0, 0, 0);
}

void draw()                                              
{ 
  //  background(252, 252, 229);
  background(0);

  if (lightsOn) {
    pushMatrix();
    //    translate(width/2, height/2, 0);
    //    directionalLight(51, 102, 126, 0, 1, 0);
    //    directionalLight(51, 102, 126, 0, -1, 0);
    //    directionalLight(91, 142, 166, 0, 0, -1);
    //    shininess(60.0);
    popMatrix();
  }

  pushMatrix();

  translate(width/2, height/2, -scroller.z);

  roty = scroller.ry - rot_current%TWO_PI;
  rotx = scroller.rx - (rot_current/3.0)%TWO_PI;

  rotateY(roty);
  rotateX(rotx);

  tetra2();

  popMatrix();
  
  if (frameCount == 5*60) {
     rot_acc = 0.00001;
  } else if (frameCount > 5*60 && rot_vel >= rot_vel_max) {
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
  texture(imgs[0]);
  vertex(0, a, b, 0.5, 0);     /*purple apex*/
  vertex(b, -a, -0, 1, 1);      /*green apex?*/
  vertex(0, a, -b, 0, 1);         /*blue apex*/
  endShape();

  beginShape(TRIANGLES);
  texture(imgs[1]);
  vertex(b, -a, 0, 0.5, 0);      /*green apex*/
  vertex(-b, -a, 0, 1, 1);      /*orange apex*/
  vertex( 0, a, -b, 0, 1);    /*blue apex*/
  endShape();

  beginShape(TRIANGLES);
  texture(imgs[2]);
  vertex(0, a, b, 0.5, 0);      /*purple apex*/
  vertex(-b, -a, 0, 0, 1);     /*orange apex*/
  vertex( 0, a, -b, 1, 1);     /*blue apex*/
  endShape();

  beginShape(TRIANGLES);
  texture(imgs[3]);
  vertex(0, a, b, 0.5, 0);      /*purple apex*/
  vertex(b, -a, 0, 0, 1);        /*green apex?*/
  vertex(-b, -a, 0, 1, 1);        /* orange apex?*/
  endShape();
}

void keyPressed() {
  lightsOn = !lightsOn;
//  println(lightsOn?"lights ON":"lights off");
}

