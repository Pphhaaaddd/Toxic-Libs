class SpringChain extends VerletParticle2D {

  int num=10, len = 300;
  float sLen = len/num;
  
  ArrayList<Particle> p;
  ArrayList<VerletSpring2D> spring;

  SpringChain(Vec2D loc) {
    super(loc);
    
    // The particles in the connection
    p = new ArrayList<Particle>();
    p.add(new Particle(loc));
    //Lock First Particle
    p.get(0).lock();
    for(int i=1;i<num;i++)
      p.add(new Particle(loc.add(new Vec2D(i*5, 1.5*i*sLen))));
    

    // Spring connection
    spring = new ArrayList<VerletSpring2D>();
    for(int i=1;i<num;i++)
      spring.add(new VerletSpring2D(p.get(i-1), p.get(i), sLen, 0.05));

    //Add the particles to the physics world
    for (Particle p : p)
      physics.addParticle(p);
    for (VerletSpring2D spring : spring)
      physics.addSpring(spring);
  }

  void display() {
    //Show Particle/Ball
    for (Particle p : p) {
      p.display();
    }
    
    // Draw a line for the string
    stroke(0);
    strokeWeight(2);
    for(int i=1;i<p.size();i++)
      line(p.get(i-1).x, p.get(i-1).y, p.get(i).x, p.get(i).y);
  }
  
  void dragAction() {
    //First lock the particle, then set the x and y, then unlock() it.
    p.get(p.size()-1).lock();
    p.get(p.size()-1).x = mouseX;
    p.get(p.size()-1).y = mouseY;
    p.get(p.size()-1).unlock();
  }
}