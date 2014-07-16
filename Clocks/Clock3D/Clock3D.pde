int h,m,s,s_old = -1;
int di = -1;
int millisOffset;

final int RATE = 10;
final color hCOLOR = color(255,0,0);
final color mCOLOR = color(0,255,0);
final color sCOLOR = color(0,0,255);
final color pulseCOLOR = color(128);

void setup() {
  size(600,600, P3D); // guides get messed up by rounding errors if this is not divisible by 3
  textFont(createFont("Verdana", 12));
  translate(width/2, height/2, 0);
  sphereDetail(50, 1);
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
  for(int x=dist; x < width; x+=interval*SPACE) {
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
  translate(width/2, height/2, 0);
  sphere(di/2);
  translate(0,0,0);
}

void drawSecond() {
  noFill();
  stroke(sCOLOR);
  int dist = width/2;
  int interval = dist/60;
  int dm = s * interval;
  sphere(dm);
}

void drawMinute() {
  noFill();
  stroke(mCOLOR);
//  float dm = (float)(width) * norm(m*60+s, 0, 60*60);
  int dist = width/2;
  int interval = dist/60;
  int dm = m * interval;
  sphere(dm);
}

void drawHour() {
  noFill();
  stroke(hCOLOR);
  int dist = width/2;
  int interval = dist/12;
  int dm = h * interval;
  sphere(dm);
}

void drawTime() {
  text(strify(h) + strify(m) + strify(s), 0, textAscent());
}

String strify(int n) {
  return n<10?"0"+n:n+"";
}
