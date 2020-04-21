

import oscP5.*;

OscP5 oscP5;
float[] rms = new float[426]; 

int numPrograms = 3;
int currentProgram = 0;

ParticleSystem ps;

void settings()
{
  size (1000, 600, P2D);
}

void setup() 
{
  frameRate (50);
  noStroke();

  ps = new ParticleSystem();
  
  surface.setTitle ("EnergyVisualizer OSC Demo");
  surface.setResizable (true);
  
  OscProperties myProperties = new OscProperties();
  myProperties.setDatagramSize (10000); 
  myProperties.setListeningPort (9001);
  oscP5 = new OscP5(this,myProperties);
}


void draw()
{
  background (0);  

  switch (currentProgram)
  {
    case 0: drawTriangles(); break;
    case 1: drawDots(); break;
    default: drawParticles();
  }
  
}

void drawTriangles()
{
  for (int i = 0; i < nTris; ++i)
  {
    int a = tri[i][0];
    int b = tri[i][1];
    int c = tri[i][2];
    float va = rms[rmsIdx[a]] * 20;
    float vb = rms[rmsIdx[b]] * 20;
    float vc = rms[rmsIdx[c]] * 20;
    
    
    color from = color (0, 0, 0);
    color to = color (50, 255, 255);
    color ca = lerpColor (from, to, va);
    color cb = lerpColor (from, to, vb);
    color cc = lerpColor (from, to, vc);
    
    
    beginShape();
    fill (ca);
    vertex (width * x[a], height * y[a]);
    fill (cb);
    vertex (width * x[b], height * y[b]);
    fill (cc);
    vertex (width * x[c], height * y[c]);
    endShape();
  }
}

void drawDots()
{
   for (int i = 0; i < 426; ++i)
  {
    float v = rms[i] * 100;
    color from = color (25, 255, 255);
    color to = color (255, 102, 153);
    color col = lerpColor (from, to, v);
    
    fill (col, 120);
    circle (width * x[i], height * y[i], v * 6 + 5);
    fill (col);
    circle (width * x[i], height * y[i], v * 5 + 1);
  }
}

void drawParticles()
{
  for (int i = 0; i < nTris; ++i)
  {
    int a = tri[i][0];
    int b = tri[i][1];
    int c = tri[i][2];
    float v = rms[rmsIdx[a]] + rms[rmsIdx[b]] + rms[rmsIdx[c]];
   
   if (v > 0.05)
   {
    PVector pos = new PVector();
    pos.x = width * (x[a] + x[b] + x[c]) / 3;
    pos.y = height * (y[a] + y[b] + y[c]) / 3;

    ps.addParticle (pos);
   }
  }
  
  
  ps.run();
}

void mouseClicked()
{
  currentProgram = (currentProgram + 1) % numPrograms;
}

// Update RMS values
void oscEvent (OscMessage message)
{
  Object data[] = message.arguments();
  for (int i = 0; i < 426; ++i)
    rms[i] = (float) data[i];
}
