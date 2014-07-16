/**
fun-with-the-frame-object taken from http://wiki.processing.org/index.php/Fun_with_the_frame_object
@author Manic
*/
//the mouse X&Y controls the brightness and hue shift of the icon image
//you can resize the frame by dragging its corners
 
PGraphics icon;
 
void setup() {
  size(400,200);
  icon = createGraphics(16,16,JAVA2D);
 
  frame.setResizable(true);
}
 
void draw(){
  frame.setTitle("Frame Number "+str(frameCount));
  icon.beginDraw();
  //icon.background(102);
  icon.colorMode(HSB);
  for(int x=0;x<icon.width;x++){
    for(int y=0;y<icon.width;y++){
      icon.stroke((mouseX+(x*icon.width))%255,y*icon.height,constrain(mouseY,0,255));
      icon.point(x,y);
    }
  }
  icon.endDraw();
  frame.setIconImage(icon.image);
  ellipseMode(CORNERS);
  ellipse(0,0,width,height);
}
