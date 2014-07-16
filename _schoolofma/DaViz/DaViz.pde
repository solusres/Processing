import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;  
AudioPlayer song;
FFT fft;

void setup() {
  size(600, 600);
  minim = new Minim(this);
  song = minim.loadFile("subsystems_22.mp3", 1024);
  song.loop();
  fft = new FFT( song.bufferSize(), song.sampleRate() );
}

void draw() {
  background(0);
  
  fft.forward( song.mix );

}

float log10 (int x) {
  return (log(x) / log(10));
}
