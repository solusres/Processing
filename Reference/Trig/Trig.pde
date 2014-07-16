int NOTCH_HEIGHT = 10;

void setup() {
  size(500,500);
  smooth();
  fill(255);
  noStroke();
}

void draw() {
  pushMatrix();
  translate(0, height/2);
  background(0);
  
  stroke(255); 
  line(0,0,width,0); // x-axis
  for(float x_notch = 0; x_notch <= width; x_notch += width/4) {
    line(x_notch, NOTCH_HEIGHT, x_notch, -NOTCH_HEIGHT); 
  }
  noStroke();
  
  float mag = 50;
  float y;
  float x_0;
  
  for (int x=0; x < width; x++) {
    x_0 = map(x,0,width,0,TWO_PI);
    fill(255,0,0);
    y = sin(x_0) * mag;
    rect(x, y, 2, 2);
    
    fill(0,255,0);
    y = cos(x_0) * mag;
    rect(x, y, 2, 2);
    
    fill(0,0,255);
    y = tan(x_0) * mag;
    rect(x, y, 2, 2);
    
    fill(0,255,255);
    y = ( (0.5*sin(x_0 * 5)) + (0.5*sin(x_0 * 3)) ) * mag;
    rect(x, y, 2, 2);
  }
  popMatrix();
}


