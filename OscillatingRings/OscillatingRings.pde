float theta=0;
boolean col=true;
int SIZE = 500;
float RADIUS = 100;
int INC = 10;

void setup()
{
  size(SIZE, SIZE);
  background(0);
  strokeWeight(3);
  stroke(255);
}

void draw()
{
  background(0);
  //  fill(0, 50);
  rect(0, 0, SIZE, SIZE);

  theta+=0.01;

  noFill();
  float x=theta;

  for (int i=0; i <= SIZE; i+=INC) {
    float y=sin(x)*height/2;
    ellipse(i, y+height/2, cos(x)*RADIUS, sin(x)*RADIUS);

    pushStyle();
    stroke(180, 0, 0);
    ellipse(i, y+height/2, 1, 1);
    popStyle();
    x+=2;
  }


  frame.setTitle(int(frameRate) + " fps");
}

