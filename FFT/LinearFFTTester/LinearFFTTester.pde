import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;

Minim minim;
FilePlayer song;
FilePlayer[] tones;
FFT fft;
String windowName;
AudioOutput out;
Gain gain;

String activeBins = "";

int[] toneFreqs = {
  27, 
  55, 
  110, 
  220, 
  440, 
  880, 
  1760, 
  3520, 
  7040, 
  14080
};

void setup() {
  size(1025, 200);
  minim = new Minim(this);  

  out = minim.getLineOut();
  
  fft = new FFT(1024, 44100);
  
  song = new FilePlayer(minim.loadFileStream("subsystems_22.mp3", 1024, true));
  //  fft = new FFT(song.bufferSize(), song.sampleRate());
  //  println("SONG:");
  //  println(" bufferSize : " + song.bufferSize());
  //  println(" sampleRate : " + song.sampleRate());
  song.patch(out);
  song.pause();
  song.rewind(); // this is ridiculous

  tones = new FilePlayer[10];
  int i = 0;
  for (int f : toneFreqs) {
    gain = new Gain(-30);
    gain.patch(out);
    tones[i] = new FilePlayer(minim.loadFileStream(f + ".wav", 1024, true));
    println("Loaded " + f + ".wav");
    tones[i].patch(gain);
//    println(" bufferSize : " + tones[i].bufferSize());
//    println(" sampleRate : " + tones[i].sampleRate());
    i++;
  }
}

void draw() {
  activeBins = "";
//  tones[4].loop();
  background(0);
  stroke(255);
  fft.forward(out.mix);
  int chunksize = 1;
  for (int i = 0; i < fft.specSize (); i+=chunksize)
  {
    float avg = 0;
    for (int j=0; j < chunksize; j++) {
      avg += fft.getBand(i);
    }
    if (avg > 1) {
      activeBins += " " + i;
    }
    avg = avg/chunksize;
    avg = avg * 4; //embiggening
    ellipse(i*2, height/2, 1+avg, 1+avg);
  }

  pushStyle();
  fill(255);
//  text(fft.specSize(), 0, height);
  text("Active Bins:" + activeBins, 0, height);
  popStyle();
}

void keyPressed() {
  int which;
  
  switch(key) {
    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      which = Character.getNumericValue(key)-1;
      tones[which].rewind();
      tones[which].play();
      break;
    case '0':
      which = 9;
      tones[which].rewind();
      tones[which].play();
      break;
    case ' ':
      song.loop();
    default:
      break;
  } 
}

void stop() {
  song.close();
  minim.stop(); 
  super.stop();
}
