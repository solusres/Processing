import codeanticode.syphon.SyphonServer;
import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioPlayer song;
FFT fft;
String windowName;

SyphonServer syphon;

void setup()
{
  size(512, 200, OPENGL);
  minim = new Minim(this);
  song = minim.loadFile("DJ_Mix_Macarena_2002.mp3", 2048);
//  song = minim.loadFile("jingle.mp3", 2048);
  song.loop();
  fft = new FFT(song.bufferSize(), song.sampleRate());
  
  syphon = new SyphonServer(this, "Processing Syphon");
}

void draw()
{
  background(0);
  stroke(255);
  fft.forward(song.mix);
  int chunksize = 4;
  for(int i = 0; i < fft.specSize(); i+=chunksize)
  {
    float avg = 0;
    for (int j=0; j < chunksize; j++) {
      avg += fft.getBand(i);
    }
    avg = avg/chunksize;
    avg = avg * 4; //embiggening
    ellipse(i, height/2, avg, avg);
  }
  syphon.sendScreen();
}

void stop()
{
  song.close();
  minim.stop(); 
  super.stop();
}
