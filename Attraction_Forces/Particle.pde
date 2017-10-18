class Particle extends VerletParticle2D {

  int size = 10;
  color c = color(127);

  Particle(Vec2D loc) {
    super(loc);
    
    physics.addParticle(this);
    //physics.addBehavior(new AttractionBehavior2D(this,width,0.1));
    physics.addBehavior(new AttractionBehavior2D(this,size*2,-1));
  }
  
  Particle(Vec2D loc,int size_) {
    super(loc);
    
    physics.addParticle(this);
    physics.addBehavior(new AttractionBehavior2D(this,width/1.5,1));
    physics.addBehavior(new AttractionBehavior2D(this,size,-5));
    size = size_;
    this.lock();
    c = color (200,15,15);
  }

  void display() {
    fill(c);
    stroke(0);
    ellipse(x, y, size, size);
  }
}