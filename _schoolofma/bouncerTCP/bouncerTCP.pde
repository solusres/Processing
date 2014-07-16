//import maxlink.*;

// Bounce
// by REAS <http://www.groupc.net>

// Modified by jkriss for MaxLink ~ 31 july 2004
// updated 21 april 2005 for Processing 0085

// When the shape hits the edge of the window, the sketch
// sends a "boing" message to Max.  Open "bouncer.pat" in
// the MaxLink examples folder to see the output.

int r = 60;       // Width of the shape
float xpos, ypos;    // Starting position of shape    

float xspeed = 2.8;  // Speed of the shape
float yspeed = 2.2;  // Speed of the shape

int xdirection = 1;  // Left or Right
int ydirection = 1;  // Top to Bottom

import processing.net.*;

int port = 7777;    // incoming TCP port
Client myClient;

void setup() 
{
  myClient = new Client(this, "127.0.0.1", port); // Replace with your server's IP and port
  size(200, 200);
  noStroke();
  frameRate(30);
  // Set the starting position of the shape
  xpos = width/2;
  ypos = height/2;
  
  ellipseMode(CORNER);
}

void draw() 
{
  background(102);
  
  // Update the position of the shape
  xpos = xpos + ( xspeed * xdirection );
  ypos = ypos + ( yspeed * ydirection );
  
  // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
  if (xpos > width-r || xpos < 0) {
    xdirection *= -1;
      myClient.write("boing" + "\n");
  }
  if (ypos > height-r || ypos < 0) {
    ydirection *= -1;
      myClient.write("bing" + "\n");
  }

  // Draw the shape
  ellipse(xpos, ypos, r, r);
}
