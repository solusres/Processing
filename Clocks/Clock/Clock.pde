int h,m,s,s_old = -1;
int di = -1;
int millisOffset;

final int RATE = 10;
final color hCOLOR = color(255,0,0);
final color mCOLOR = color(156,0,0);
final color sCOLOR = color(64,0,0);
final color pulseCOLOR = color(32,0,0);

void setup() {
  size(600,600); // guides get messed up by rounding errors if this is not divisible by 3
  textFont(createFont("Verdana", 12));
  smooth();
}

void draw() {
  background(0);
  
  getTime();
  drawTime();
  
  drawGuides();
    
  if (s_old != s) {
    millisOffset = millis()%1000;
    di=0;
    s_old = s;
  }
  if (di == -1) return;
  
  drawPulse();
  drawSecond();
  drawMinute();
  drawHour();
  di+=RATE;
}

void getTime() {
  h = hour()<=12?hour():hour()%12;
  m = minute();
  s = second();
  if (s_old == -1) {
    s_old = s; 
  }
}

void drawGuides() {
  stroke(255);
  
  int dist = width/2;
  int interval = dist/60;
  int minuteMark = 0;
  final int SPACE = 5;
  for(int x=dist; x <= width; x+=interval*SPACE) {
    if (minuteMark == 15 || minuteMark == 45) {
      for (int i=0; i<5; i++) {
        point(x, height/2 - i);
      }
    } else if (minuteMark == 30) {
      for (int i=0; i<10; i++) {
        point(x, height/2 - i);
      }
    }
    point(x, height/2);
//    text(minuteMark, x, height/2);
    minuteMark += SPACE;
  }
}

void drawPulse() {
  noFill();
  stroke(pulseCOLOR);
  ellipse(width/2, height/2, di, di);
}

void drawSecond() {
  noFill();
  stroke(sCOLOR);
  int dist = width/2;
  int interval = dist/60;
  int dm = 2 * s * interval;
  ellipse(width/2, height/2, dm, dm);
}

void drawMinute() {
  noFill();
  stroke(mCOLOR);
//  float dm = (float)(width) * norm(m*60+s, 0, 60*60);
  int dist = width/2;
  int interval = dist/60;
  int dm = 2 * m * interval;
  ellipse(width/2, height/2, dm, dm);
}

void drawHour() {
  noFill();
  stroke(hCOLOR);
  int dist = width/2;
  int interval = dist/12;
  int hm = 2 * h * interval;
  ellipse(width/2, height/2, hm, hm);
}

void drawTime() {
  text(strify(h) + strify(m) + strify(s), 0, textAscent());
}

String strify(int n) {
  return n<10?"0"+n:n+"";
}
