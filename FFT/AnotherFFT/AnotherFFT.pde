import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer song;
AudioMetaData meta;
FFT fft;
 
void setup() {
  size(1024, 768);
 
  minim = new Minim(this);
  song = minim.loadFile("spybreak.mp3");
  song.play();
  
  meta = song.getMetaData();
  
  fft = new FFT(song.bufferSize(), song.sampleRate());
  
  textFont( loadFont("SourceCodePro-Regular-18.vlw") );
}
 
void draw() {
 background(0);
  fft.forward(song.mix);
 
  stroke(255, 0, 0, 128);

  println(fft.specSize());
  for(int i = 0; i < fft.specSize(); i=i+2)
  {
    line(i, height, i, height - fft.getBand(i)*4);
  }
 
  stroke(255);
  
  for(int i = 0; i < song.left.size() - 1; i++)
  {
    line(i, 50 + song.left.get(i)*50, i+1, 50 + song.left.get(i+1)*50);
    line(i, 150 + song.right.get(i)*50, i+1, 150 + song.right.get(i+1)*50);
  }
}
 
void stop() {
  song.close();
  minim.stop();
  
  super.stop();
}
