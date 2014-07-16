class FreqRange {
  int lo;
  int hi;
  
  public FreqRange(int lo, int hi) {
    this.lo = lo;
    this.hi = hi;
  }
  
  float getAvg(FFT fft) {
    return fft.calcAvg(this.lo, this.hi);
  }
  
  float getAvgWithMin(FFT fft, float min) {
    return max(min, getAvg(fft)); 
  }
}
