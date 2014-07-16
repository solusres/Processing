void setup() {
  size(800, 800, P3D);
  perspective();
  textFont(createFont("Verdana", 9));
  smooth();
}

void draw() {
  background(0);
  
  stroke(0, 200, 50);
  for (int x=0; x <= width; x+=10) {
    for (int y=0; y <= height; y+=10) {
      for (int z=0; z >= -400; z-=10) { 
        pushMatrix();
//        translate(x, y, z);
        point(x,y,z);
//        text("("+x+","+y+","+z+")",x,y,z);
        popMatrix();
      }
    }
  }
}


