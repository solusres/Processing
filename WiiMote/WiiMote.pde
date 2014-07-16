import codeanticode.syphon.SyphonServer;
import oscP5.*;
OscP5 oscP5;
SyphonServer syphon;
PImage wiimote, a, b, up, down, left, right, minus, plus, one, two, home;

boolean isA, isB, isUp, isDown, isLeft, isRight, isMinus, isPlus, is1, is2, isHome;

void setup() {
  size(235, 332, OPENGL);
  background(0);
  /* start oscP5, listening for incoming messages at port 8000 */
  oscP5 = new OscP5(this, 8001);

  wiimote = loadImage("wiimote.jpg");
  a = loadImage("a.png");
  b = loadImage("b.png");
  up = loadImage("up.png");
  down = loadImage("down.png");
  left = loadImage("left.png");
  right = loadImage("right.png");
  minus = loadImage("minus.png");
  plus = loadImage("plus.png");
  one = loadImage("1.png");
  two = loadImage("2.png");
  home = loadImage("home.png");
  syphon = new SyphonServer(this, "Processing Syphon");
}

void oscEvent(OscMessage msg) {
  String addr = msg.addrPattern();     
  //  println(addr);   // uncomment for seeing the raw message

  // address format: /wii/[conroller]/[type]/[qualifier]
  if (addr.indexOf("/wii") !=-1) {
    String[] address = split(addr, '/');
    String controller = address[2];
    String type = address[3];
    String qualifier = address[4];

//    println("Controller " + controller, type, qualifier, msg.get(0).floatValue());

    if (type.equals("button")) {
      if (qualifier.equals("A")) {
        float value = msg.get(0).floatValue();
        isA = (value==1.0);
      }
      if (qualifier.equals("B")) {
        float value = msg.get(0).floatValue();
        isB = (value==1.0);
      } 
      if (qualifier.equals("Up")) {
        float value = msg.get(0).floatValue();
        isUp = (value==1.0);
      } 
      if (qualifier.equals("Down")) {
        float value = msg.get(0).floatValue();
        isDown = (value==1.0);
      } 

      if (qualifier.equals("Left")) {
        float value = msg.get(0).floatValue();
        isLeft = (value==1.0);
      } 

      if (qualifier.equals("Right")) {
        float value = msg.get(0).floatValue();
        isRight = (value==1.0);
      }
      if (qualifier.equals("Minus")) {
        float value = msg.get(0).floatValue();
        isMinus = (value==1.0);
      }
      if (qualifier.equals("Plus")) {
        float value = msg.get(0).floatValue();
        isPlus = (value==1.0);
      }
      if (qualifier.equals("1")) {
        float value = msg.get(0).floatValue();
        is1 = (value==1.0);
      }
      if (qualifier.equals("2")) {
        float value = msg.get(0).floatValue();
        is2 = (value==1.0);
      }
      if (qualifier.equals("Home")) {
        float value = msg.get(0).floatValue();
        isHome = (value==1.0);
      }
    }
  }
}

void draw() {
  background(0);
  image(wiimote, 0, 0);
  if (isA) { image(a, 0, 0); }
  if (isB) { image(b, 0, 0); }
  if (isUp) { image(up, 0, 0); }
  if (isDown) { image(down, 0, 0); }
  if (isLeft) { image(left, 0, 0); }
  if (isRight) { image(right, 0, 0); }
  if (isMinus) { image(minus, 0, 0); }
  if (isPlus) { image(plus, 0, 0); }
  if (is1) { image(one, 0, 0); }
  if (is2) { image(two, 0, 0); }
  if (isHome) { image(home, 0, 0); }
  
  syphon.sendScreen();
}
