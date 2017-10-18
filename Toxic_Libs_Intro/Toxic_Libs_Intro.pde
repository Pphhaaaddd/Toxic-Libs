
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;

Particle p1;
Particle p2;

void setup() {
  size(640, 480); 

  physics = new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0,0.5)));
  physics.setDrag(0.05f);

  //World Boundaries
  physics.setWorldBounds(new Rect(0, 0, width, height));

  //2 Particles
  p1=new Particle(new Vec2D(width/2, 20));
  p2=new Particle(new Vec2D(width/2+80, 20));
  //Locking p1 in place
  p1.lock();

  // Spring connection
  VerletSpring2D spring = new VerletSpring2D(p1, p2, 100, 0.05);


  //Add the particles to the physics world
  physics.addParticle(p1);
  physics.addParticle(p2);
  physics.addSpring(spring);
}

void draw() {

  // Updating physics world
  physics.update();

  background(255);

  // Dar a line for the string
  stroke(0);
  strokeWeight(2);
  line(p1.x, p1.y, p2.x, p2.y);

  //Show them
  p1.display();
  p2.display();

  if (mousePressed) {
    //First lock the particle, then set the x and y, then unlock() it.
    p2.lock();
    p2.x = mouseX;
    p2.y = mouseY;
    p2.unlock();
  }
}