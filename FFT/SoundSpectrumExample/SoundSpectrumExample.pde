/**
 * An FFT object is used to convert an audio signal into its frequency domain representation. This representation
 * lets you see how much of each frequency is contained in an audio signal. Sometimes you might not want to 
 * work with the entire spectrum, so it's possible to have the FFT object calculate average frequency bands by 
 * simply averaging the values of adjacent frequency bands in the full spectrum. There are two different ways 
 * these can be calculated: <b>Linearly</b>, by grouping equal numbers of adjacent frequency bands, or 
 * <b>Logarithmically</b>, by grouping frequency bands by <i>octave</i>, which is more akin to how humans hear sound.
 * <br/>
 * This sketch illustrates the difference between viewing the full spectrum, 
 * linearly spaced averaged bands, and logarithmically spaced averaged bands.
 * <p>
 * From top to bottom:
 * <ul>
 *  <li>The full spectrum.</li>
 *  <li>The spectrum grouped into 30 linearly spaced averages.</li>
 *  <li>The spectrum grouped logarithmically into 10 octaves, each split into 3 bands.</li>
 * </ul>
 *
 * Moving the mouse across the sketch will highlight a band in each spectrum and display what the center 
 * frequency of that band is. The averaged bands are drawn so that they line up with full spectrum bands they 
 * are averages of. In this way, you can clearly see how logarithmic averages differ from linear averages.
 * <p>
 * For more information about Minim and additional features, visit http://code.compartmental.net/minim/
 */

import ddf.minim.analysis.*;
import ddf.minim.*;

int FONT_SIZE = 12;
float SMOOTHING = 0.00007;
float SMOOTH_SCALE = 0.05;

Minim minim;  
AudioPlayer song;
FFT fft;

float spectrumScale = 20; // constant used to scale FFT magnitudes up
float logScaleFactor = 190; // constant used for spreading logarithmic graph values
PFont font;
boolean gammaCorrected;
float gamma = 2;
float[] powers;


void setup() {
  size(512, 480);

  minim = new Minim(this);
  song = minim.loadFile("subsystems_22.mp3", 1024);

  // loop the file
  song.loop();

  // create an FFT object that has a time-domain buffer the same size as song's sample buffer
  // note that this needs to be a power of two 
  // and that it means the size of the spectrum will be 1024. 
  // see the online tutorial for more info.
  fft = new FFT( song.bufferSize(), song.sampleRate() );
  
  powers = new float[fft.specSize()];

  rectMode(CORNERS);
  font = createFont("Verdana", FONT_SIZE);
}

void draw() {
  background(0);

  textFont(font);
  textSize( FONT_SIZE );

  float centerFrequency = 0;

  // perform a forward FFT on the samples in song's mix buffer
  // note that if song were a MONO file, this would be the same as using song.left or song.right
  fft.forward( song.mix );

  // draw the full spectrum
  {
    noFill();
    float x;
    int specSize = fft.specSize();
    float smoothing = pow(SMOOTHING, 41000/41000);

    for (int i = 0; i < specSize; i++) {
      if (gammaCorrected) {
        x = logScaleFactor*log10(i);
        int freqs = specSize;
        int f_start = 0;
        int f_end = int(pow(float(i)/specSize, gamma) * freqs);
        int f_width;
        float bin_power = 0.0f;
        if (f_end > freqs) {
          f_end = freqs;
        }

        f_width = f_end - f_start;
        if (f_width <= 0) {
          f_width = 1;
        }

        for (int j = 0; j < f_width; j++) {
          float re = fft.getSpectrumReal()[f_start+j];
          float im = fft.getSpectrumImaginary()[f_start+j];

          float p = re * re + im * im;

          if (p > bin_power) {
            bin_power = p;
          }

          bin_power = log(bin_power);

          if (bin_power < 0) {
            bin_power = 0;
          }
          
          powers[i] = powers[i] * smoothing + (bin_power * SMOOTH_SCALE * (1.0f - smoothing));

          f_start = f_end;
          
          line(x, height, x, height - powers[i]*spectrumScale);
        }
      } else {

        x = logScaleFactor*log10(i);
        // if the mouse is over the spectrum value we're about to draw
        // set the stroke color to red
        if ( int(x) == mouseX ) {
          centerFrequency = fft.indexToFreq(i);
          stroke(255, 0, 0);
        } else {
          stroke(255);
        }
        line(x, height, x, height - fft.getBand(i)*spectrumScale);
      }
    }
    fill(255, 128);
    text("Spectrum Center Frequency: " + centerFrequency, 5, textAscent());
    text("Graphing Method: " + (gammaCorrected?"GAMMA CORRECTED":"LOGARITHMIC"), 5, 2*textAscent());
  }
}

float log10 (int x) {
  return (log(x) / log(10));
}

void keyPressed() {
  if (key == ' ') {
    gammaCorrected = !gammaCorrected;
  }
}
