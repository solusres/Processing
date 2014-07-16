HColorPool colors;

/* My first Hype sketch */

void setup() {
  size(640, 640);
  H.init(this).background(#000000);
  smooth();

  colors = new HColorPool(#3333FF, #6666FF);

  int starScale = 800;
  int starOffest = 40;

  for (int i=0; i<starScale/starOffest; ++i) {
    
    HPath d = (HPath) H.add( new HPath().star(6, 0.95) )
      .size(starScale-(i*starOffest), starScale-(i*starOffest))
      .noStroke()
      .fill( i%2==0 ? #3333C3 : #6666C6)
      .anchorAt(H.CENTER)
      .locAt(H.CENTER)
    ;

    new HOscillator()
      .target(d)
      .property(H.ROTATION)
      .range(-30, 30)
      .speed(0.2)
      .freq(5)
      .currentStep(i)
    ;
  }
}

void draw() {
  H.drawStage();
}

