class Particle extends VerletParticle2D {
 
  Particle(Vec2D loc) {
    super(loc);
  }
 
 //Ezzzz
  void display() {
    fill(175);
    stroke(0);
    ellipse(x,y,16,16);
  }
}