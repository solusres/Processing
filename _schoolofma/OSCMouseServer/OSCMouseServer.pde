import oscP5.*;
import netP5.*;
import java.net.*;
import java.util.Enumeration;
import java.util.*;

final int RECV_PORT = 8002;
final int SEND_PORT = 8001;
final int HOW_OFTEN = 120;

String SERVER_IP;
String NAME;

OscP5 oscP5;
NetAddress server;

HashMap<String, Player> players;
HashMap<String, NetAddress> clients;
LinkedList<Goal> goals;

void setup() {
  //  size(300, 60);
  size(500, 500);
  textFont(createFont("Verdana", 12));

  oscP5 = new OscP5(this, RECV_PORT);

  SERVER_IP = getIP();

  clients = new HashMap<String, NetAddress>();
  players = new HashMap<String, Player>();
  goals = new LinkedList<Goal>();

  println("Server IP: ", SERVER_IP);
}

void draw() {
  background(0);
  text("Server is running", 0, textAscent()*1);
  text("Server address: " + SERVER_IP + ":" + RECV_PORT, 0, textAscent()*2);
  text("Players connected: " + clients.size(), 0, textAscent()*3);

  if (frameCount % HOW_OFTEN == 0) {
    addGoal();
  }
}

void addGoal() {
  Goal g = new Goal(int(random(width)), int(random(height)), int(random(5, 60)));
  goals.add(g);
  OscMessage msg = new OscMessage("/goalList");
  msg.add(goals.size());
  for (Goal goal : goals) {
    msg.add(goal.x + "," + goal.y + "," + goal.radius);
  }

  broadcastMessage(msg);
}

////////////////
// OSC HANDLERS

void oscEvent(OscMessage msg) {
  String addr = msg.addrPattern();    
  String ip = msg.address();

  // WTF?  Thanks to aBe for finding this bug.
  if (ip.charAt(0) == '/') {
    ip = ip.substring(1);
  }

  //  println("SERVER RECV:", addr);

  // register new clients
  if (!clients.containsKey(ip) ) {
    clients.put(ip, new NetAddress(ip, SEND_PORT));
  }

  // address format: /mouse [x, y]
  if (addr.indexOf("/mouse") !=-1) {
    handleMouse(msg);
  } else {
    println("UNKNOWN ADDRESS: ", addr);
  }
}

void broadcastMessage(OscMessage msg) {
  for (NetAddress loc : clients.values ()) {
    //    println("SERVER SEND:", msg.addrPattern());
    //    println("         TO:", loc);
    oscP5.send(msg, loc);
  }
}

void handleMouse(OscMessage msg) {
  int x = msg.get(0).intValue();
  int y = msg.get(1).intValue();
  String name = msg.get(2).stringValue();

  Player p;
  if (!players.containsKey(name)) {
    p = new Player(x, y, name);
  } else {
    p = players.get(name);
    p.x = x;
    p.y = y;
  }
  Goal g;
  Iterator<Goal> iter = goals.iterator();
  while (iter.hasNext ()) {
    //  for (Goal g : goals) {
    g = iter.next();
    if (g.isInside(new PVector(p.x, p.y))) {
      //      goals.remove(g);
      iter.remove();
      p.score++;

      OscMessage goalMsg = new OscMessage("/goalList");
      goalMsg.add(goals.size());
      for (Goal goal : goals) {
        goalMsg.add(goal.x + "," + goal.y + "," + goal.radius);
      }

      broadcastMessage(goalMsg);

      OscMessage scoreMessage = new OscMessage("/score");
      scoreMessage.add(name);
      scoreMessage.add(p.score);
      broadcastMessage(scoreMessage);
    }
  }

  players.put(name, p);

  OscMessage mouseMessage = new OscMessage("/mouse");
  mouseMessage.add(x);
  mouseMessage.add(y);
  mouseMessage.add(name);

  broadcastMessage(mouseMessage);
}

String getIP() {
  Enumeration e = null;
  try {
    e=NetworkInterface.getNetworkInterfaces();
  } 
  catch(SocketException ex) {
    println(ex);
  }
  while (e.hasMoreElements ()) {
    NetworkInterface n=(NetworkInterface) e.nextElement();
    Enumeration ee = n.getInetAddresses();
    while (ee.hasMoreElements ()) {
      InetAddress i = (InetAddress) ee.nextElement();
      String host = i.getHostAddress();
      if (host.startsWith("192.168.")) {
        return host;
      }
    }
  }
  return null;
}

void mouseClicked() {
  goals = new LinkedList<Goal>();

  OscMessage goalMsg = new OscMessage("/goalList");
  goalMsg.add(goals.size());
  broadcastMessage(goalMsg);
}
