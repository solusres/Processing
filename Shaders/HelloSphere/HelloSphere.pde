float angle;
PShader colorShader;

void setup() {
  size(640, 360, P3D);
  
  colorShader = loadShader("colorfrag.glsl", "colorvert.glsl");
}

void draw() {
  shader(colorShader);
//  shader(AnothercolorShader);
  colorShader.set("displacement", 0.5);
  background(0);
  fill(255,0,0);
  translate(width/2, height/2);
  rotateY(angle);  
  sphere(100);
  angle += 0.01;
}
