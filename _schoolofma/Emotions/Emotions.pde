int SIZE = 500;

Emotion[] emos;
int index = 2;

void setup() {
  size(SIZE, SIZE);
  smooth(8);
  noCursor(); // not working...
  
  emos = new Emotion[]{ new Anger(), new Fear(), new Love() };
}

void draw() {
  background(0);

  emos[index].draw();

  frame.setTitle("FPS : " + nf(frameRate, 2, 4));
}

void keyPressed() {
  index++;
  index = index % emos.length;
}
