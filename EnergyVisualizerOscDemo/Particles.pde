class ParticleSystem 
{
  ArrayList<Particle> particles;

  ParticleSystem() 
  {
    particles = new ArrayList<Particle>();
  }

  void addParticle (PVector pos) 
  {
    particles.add (new Particle (pos));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}


// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector (0, 0.2);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = l.copy();
    lifespan = 100.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add (acceleration);
    position.add (velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    fill (255, lifespan);
    ellipse (position.x, position.y, 8, 8);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
