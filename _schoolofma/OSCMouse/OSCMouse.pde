import oscP5.*;
import netP5.*;

OscP5 oscP5;
String vaishali = "192.168.100.76";
String esteban = "192.168.100.208";

String NAME = "Soma";
int SIZE = 500;
int PORT = 8001;

HashMap<String, PVector> mice;
HashMap<String, NetAddress> remotes;

void setup() {
  size(SIZE, SIZE);
  textFont(createFont("Verdana", 12));

  oscP5 = new OscP5(this, PORT);

  mice = new HashMap<String, PVector>();
  remotes = new HashMap<String, NetAddress>();

  remotes.put(vaishali, new NetAddress(vaishali, PORT));
  remotes.put(esteban, new NetAddress(esteban, PORT));
}

void draw() {
  background(0);

  PVector p;
  for (String name : mice.keySet ()) {
    p = mice.get(name);
    ellipse(p.x, p.y, 5, 5);
    text(name, p.x+2, p.y+2);
  }

  p = new PVector(mouseX, mouseY);

  ellipse(p.x, p.y, 5, 5);
  text(NAME, p.x+2, p.y+2);
}

void oscEvent(OscMessage msg) {
  String addr = msg.addrPattern();    
  String ip = msg.address();

  //  println(addr);   // uncomment for seeing the raw message

  // address format: /mouse [x, y]
  if (addr.indexOf("/mouse") !=-1) {

    if (!remotes.containsKey(ip) ) {
      remotes.put(ip, new NetAddress(ip, PORT));
    }

    int x = msg.get(0).intValue();
    int y = msg.get(1).intValue();
    String name = msg.get(2).stringValue();

    mice.put(name, new PVector(x, y));
    //    println(name, ":", x, y);
  } else {
    println("UNKNOWN ADDRESS: ", addr);
  }
}

void mouseMoved() {
  OscMessage myMessage = new OscMessage("/mouse");
  myMessage.add(mouseX);
  myMessage.add(mouseY); 
  myMessage.add(NAME);

  // send the message
  for (NetAddress loc : remotes.values ()) {
    oscP5.send(myMessage, loc);
  }
}
