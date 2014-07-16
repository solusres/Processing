import org.dishevelled.processing.frames.*;


List<PImage> spriteFrames; 

void setup() {
  size(300, 300);

  frames = new Frames(this);  
  
  String uri = "https://dl.dropboxusercontent.com/u/1250543/assets/glowball_trim.png";

  List<PImage> spriteFrames = frames.createFrameList(uri, 0, 0, 40, 40, 24);
  
  for (int x=0; 
   hatRight = frames.createLoopedAnimation(hatFrames);

  imageMode(CENTER);
}

void draw() {
  background(0);
  s.setPos(mouseX, mouseY);
  s.draw();
}

