/*
 * #PLP
 */

int W = 192;
int H = 156; // (-1);

int CELL_SIZE = 4;
int CELL_WIDTH  = 48; // screen width  in cells
int CELL_HEIGHT = 39; // screen height in cells (-1)

PGraphics facade;

boolean[] visited;

void prepareFacade() {
  facade = createGraphics(width, height);

  facade.beginDraw();
  facade.noStroke();
  facade.fill(255);

  facade.beginShape();
  facade.vertex(  0, 0);
  facade.vertex(  0, 32);
  facade.vertex( 36, 32);
  facade.vertex( 36, 16);
  facade.vertex( 72, 16);
  facade.vertex( 72, 0);
  facade.endShape(CLOSE);

  facade.beginShape();
  facade.vertex(120, 0);
  facade.vertex(120, 16);
  facade.vertex(156, 16);
  facade.vertex(156, 32);
  facade.vertex(192, 32);
  facade.vertex(192, 0);
  facade.endShape(CLOSE);

  facade.endDraw();
}

void prepareVisited() {
  visited = new boolean[CELL_WIDTH * CELL_HEIGHT];
  
  for (int x=0; x < CELL_WIDTH; x++) {
    for (int y=0; y < CELL_HEIGHT; y++) {
      
      if ( ((0 <= x) && (x < 9)) || ((39 <= x) && (x < 48)) ) {
        if (y <= 8) {
          println("x : " + x + " y : " + y);
          println("   " + toIndex(x,y));
          visited[toIndex(x,y)] = true;
        }
      }
      
      if ( ((9 <= x) && (x < 18)) || ((30 <= x) && (x < 39)) ) {
        if (y <= 4) {
          visited[toIndex(x,y)] = true;
        }
      }
      
    } 
  }
}

int toIndex(int x, int y) {
  return x + (y * CELL_WIDTH); 
}

PVector fromIndex(int index) {
  return new PVector(index % CELL_WIDTH, index / CELL_WIDTH); 
}

void visit(int x, int y) {
  visited[toIndex(x, y)] = true;
}

void setup() {
  size(192, 157);
  background(0);
  frameRate(25);

  smooth(8);
  prepareFacade();
  
  prepareVisited();
}

void draw() {
  background(0);
  
  stroke(0,255,0);
  
  for (int i=0; i < visited.length; i++) {
    if (visited[i]) {
      fill(255,0,0);
    } else {
      fill(255,255,255);
    }
    
    PVector pos = fromIndex(i);
    println(pos.x * CELL_SIZE + " ");
    rect(pos.x * CELL_SIZE, pos.y * CELL_SIZE, CELL_SIZE, CELL_SIZE);
  }
  
  drawFacade();
//  drawFPS();
}

// masks out the unaddressable portion of the facade
void drawFacade() {
  image(facade, 0, 0);
}

void drawFPS() {
  pushStyle();
  fill(0);
  textSize(9);
  text(nf(frameRate, 2, 2), 0, 9);
  popStyle();
}


