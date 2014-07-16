Guides guides;
ArcDisc[] discs;

final color hCOLOR = color(255,0,0);
final color mCOLOR = color(156,0,0);
final color sCOLOR = color(64,0,0);

void setup() {
  size(600,600); 
  textFont(createFont("Verdana", 12));
  smooth();
  guides = new Guides(color(255));
  discs  = new ArcDisc[] {
    new ArcDiscHour(hCOLOR, width),
    new ArcDiscMinute(mCOLOR, (int)((2.0/3.0)*width)),
    new ArcDiscSecond(sCOLOR, (int)((1.0/3.0)*width))
  };
}

void draw() {
  background(0);
  drawTime();
  
  for (int i=0; i<discs.length; i++) {
    discs[i].paint();
  }
  guides.paint();
}

void drawTime() {
  fill(255);
  text(strify(hour()<=12?hour():hour()%12) + strify(minute()) + strify(second()), 0, textAscent());
}

String strify(int n) {
  return n<10?"0"+n:n+"";
}
