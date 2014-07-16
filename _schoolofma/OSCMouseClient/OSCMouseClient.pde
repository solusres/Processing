import oscP5.*;
import netP5.*;
import javax.swing.JOptionPane;

final int SIZE = 500;
final int RECV_PORT = 8001;
final int SEND_PORT = 8002;

String SERVER_IP;
String NAME;

OscP5 oscP5;
NetAddress server;

HashMap<String, Player> players;
ArrayList<Goal> goals;

void setup() {
  size(SIZE, SIZE);
  textFont(createFont("Verdana", 12));

  oscP5 = new OscP5(this, RECV_PORT);

  players = new HashMap<String, Player>();
  goals = new ArrayList<Goal>();

  // TODO: should probably check that the server IP is valid, but... eh
  //  SERVER_IP = JOptionPane.showInputDialog(null, "Please enter server IP", "YO", JOptionPane.QUESTION_MESSAGE);
  NAME = JOptionPane.showInputDialog(null, "Please enter your name", "YO", JOptionPane.QUESTION_MESSAGE);

  SERVER_IP = "192.168.0.29";
//  SERVER_IP = "127.0.0.1";
//  NAME = "Soma";

  server = new NetAddress(SERVER_IP, SEND_PORT);
}

void draw() {
  background(0);

  for (Goal goal : goals) {
    goal.draw();
  }

  for (Player player : players.values ()) {
    player.draw();
  }
}

////////////////
// OSC HANDLERS

void oscEvent(OscMessage msg) {
  String addr = msg.addrPattern();    
  String ip = msg.address();

//println("CLIENT RECV:", addr);

  //  println(addr);   // uncomment for seeing the raw message

  // address format: /mouse [x, y]
  if (addr.indexOf("/mouse") != -1) {
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
    players.put(name, p);
  } else if (addr.indexOf("/goalList") != -1) {
    ArrayList<Goal> newGoals = new ArrayList<Goal>();
    int number = msg.get(0).intValue();
    String[] s;
    for (int i = 0; i < number; i++) {
      s = msg.get(i+1).stringValue().split(",");
      newGoals.add(new Goal(int(s[0]), int(s[1]), int(s[2])));
    }
    goals = newGoals;
  } else if (addr.indexOf("/score") != -1) {
    String name = msg.get(0).stringValue();
    int score = msg.get(1).intValue();

    Player p = players.get(name);

    if (p != null) {
      p.score = score;
      players.put(name, p);
    }
  } else {
    println("UNKNOWN ADDRESS: ", addr);
  }
}

//////////////////
// LOCAL HANDLERS

void mouseMoved() {
  OscMessage msg = new OscMessage("/mouse");
  msg.add(mouseX);
  msg.add(mouseY);
  msg.add(NAME);

  //  println("CLIENT SEND:", msg.addrPattern());
  oscP5.send(msg, server);
}
