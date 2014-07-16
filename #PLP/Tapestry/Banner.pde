class Banner
{
  ArrayList<Particle> particles;  

  // Dimensions for our curtain. These are number of particles for each direction, not actual widths and heights
  // the true width and height can be calculated by multiplying restingDistances by the curtain dimensions
  final int curtainHeight;
  final int curtainWidth;
  final int x;
  final int y;
  final float restingDistances;
  final float stiffnesses = 1;
  
  boolean wireframe = false;

  // These variables are used to keep track of how much time is elapsed between each frame
  // they're used in the physics to maintain a certain level of accuracy and consistency
  // this program should run the at the same rate whether it's running at 30 FPS or 300,000 FPS
  long previousTime;
  long currentTime;
  // Delta means change. It's actually a triangular symbol, to label variables in equations
  // some programmers like to call it elapsedTime, or changeInTime. It's all a matter of preference
  // To keep the simulation accurate, we use a fixed time step.
  final int fixedDeltaTime = 15;
  float fixedDeltaTimeSeconds = (float)fixedDeltaTime / 1000;

  // the leftOverDeltaTime carries over change in time that isn't accounted for over to the next frame
  int leftOverDeltaTime = 0;

  // How many times are the constraints solved for per frame:
  int constraintAccuracy = 3;

  PImage textureImage;

  public Banner(int x, int y, int width, int height, float cellSize) {
    this.x = x;
    this.y = y;
    this.curtainWidth = width;
    this.curtainHeight = height;
    this.restingDistances = cellSize;

    // create the curtain
    createCurtain();

    textureImage = loadImage("test.jpg");

    noStroke();
  }

  void draw () {
    /******** Physics ********/
    currentTime = millis();
    long deltaTimeMS = currentTime - previousTime;
    previousTime = currentTime; // reset previousTime
    // timeStepAmt will be how many of our fixedDeltaTime's can fit in the physics for this frame. 
    int timeStepAmt = (int)((float)(deltaTimeMS + leftOverDeltaTime) / (float)fixedDeltaTime);
    leftOverDeltaTime += (int)deltaTimeMS - (timeStepAmt * fixedDeltaTime); // reset leftOverDeltaTime.

    // update physics

    for (int iteration = 1; iteration <= timeStepAmt; iteration++) {
      // solve the constraints multiple times
      // the more it's solved, the more accurate.
      for (int n = 0; n < constraintAccuracy; n++) {
        for (int i = 0; i < particles.size(); i++) {
          Particle particle = (Particle) particles.get(i);
          particle.solveConstraints();
        }
      }

      // update each particle's position
      for (int i = 0; i < particles.size(); i++) {
        Particle particle = (Particle) particles.get(i);
        particle.updateInteractions();
        particle.updatePhysics(fixedDeltaTimeSeconds);
      }
    }

    // RENDERING

    if (wireframe) {
      for (Particle particle : particles) {
        particle.draw();
      }
    }

    for (int x = 0; x < curtainWidth; x++) {
      for (int y = 0; y < curtainHeight; y++) {
        Particle topLeft = (Particle) particles.get(y * (curtainWidth+1) + x);
        Particle topRight = (Particle) particles.get(y * (curtainWidth+1) + x+1);
        Particle bottomRight = (Particle) particles.get((y+1) * (curtainWidth+1) + (x+1));
        Particle bottomLeft = (Particle) particles.get((y+1) * (curtainWidth+1) + x);
        textureMode(NORMAL);
        beginShape();
        texture(textureImage);

        float normX0 = float(x)/curtainWidth;
        float normX1 = float(x+1)/curtainWidth;
        float normY0 = float(y)/curtainHeight;
        float normY1 = float(y+1)/curtainHeight;

        vertex(topLeft.position.x, topLeft.position.y, normX0, normY0);
        vertex(topRight.position.x, topRight.position.y, normX1, normY0);
        vertex(bottomRight.position.x, bottomRight.position.y, normX1, normY1);
        vertex(bottomLeft.position.x, bottomLeft.position.y, normX0, normY1);
        endShape(CLOSE);
      }
    }
  }

  void createCurtain () {
    particles = new ArrayList();
    // (curtainWidth * restingDistances) = curtain's pixel width
    for (int y = 0; y <= curtainHeight; y++) { // due to the way particles are attached, we need the y loop on the outside
      for (int x = 0; x <= curtainWidth; x++) { 
        Particle particle = new Particle(new PVector(this.x + x * restingDistances, this.y + y * restingDistances));

        // attach to x - 1  and y - 1  
        // - attachTo parameters: Particle particle, float restingDistance, float stiffness
        
        // try disabling the next 2 lines (the if statement and attachTo part) to create a hairy effect
        if (x != 0) 
          particle.attachTo((Particle)(particles.get(particles.size()-1)), restingDistances, stiffnesses);
        
        // the index for the particles are one dimensions, 
        // so we convert x,y coordinates to 1 dimension using the formula y*width+x  
        if (y != 0)
          particle.attachTo((Particle)(particles.get((y - 1) * (curtainWidth+1) + x)), restingDistances, stiffnesses);

        // we pin the very top particles to where they are
        if (y == 0) {
          particle.pinTo(particle.position);
        }


        // add to particle array  
        particles.add(particle);
      }
    }
  }  
  
}

