

import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioPlayer jingle;
FFT         fft;

void setup()
{
  size(1000, 1000, P3D);

  minim = new Minim(this);


  jingle = minim.loadFile("gangnam.mp3", 1024);


  jingle.loop();

  fft = new FFT( jingle.bufferSize(), jingle.sampleRate() );
}

void draw() {



  stroke(255);

  camera(800 * cos(frameCount/60.0), 600, 800 * sin(frameCount/60.0), 0, 0, 0, 0, -1, 0);

  float bass = fft.calcAvg(40, 400)*3;
  float mid = fft.calcAvg(400, 2000)*5;
  float high = fft.calcAvg(2000, 20000)*35;
  background(mid*1.5, bass, high*1.5);
  fft.forward( jingle.mix );
  for (int n = 0; n < 5; n = n + 1) {
    for (int m = 0; m < 5; m = m + 1) {
      for (int i = 0; i < 5; i = i + 1) {
        box(bass/2.5, mid/2, high/2);
        translate(100, 0);
      }
      translate(-500, 100);
    }
    translate(0, -500, -100);
  }
  translate(200, 200, 300);
  pushMatrix();
  noStroke();
  fill(high*1.5, mid*1.5, bass);
  sphere(mid*2);
  popMatrix();

  rotateX(bass);
  rotateY(mid);
  rotateZ(high);
  fill(bass, mid*1.5, high*1.5);
}
