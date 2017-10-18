import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;
ArrayList<Particle> p;
ArrayList<Particle> attractor;

void setup() {
  size(640, 480);

  physics = new VerletPhysics2D();
  //physics.addBehavior(new GravityBehavior2D(new Vec2D(0, 0.5)));
  physics.setDrag(0.05f);

  //World Boundaries
  physics.setWorldBounds(new Rect(0, 0, width, height));
  attractor = new ArrayList<Particle>();
  attractor.add(new Particle(new Vec2D(width*1/4, height*3/4), 40));
  attractor.add(new Particle(new Vec2D(width*3/4, height*1/4), 40));
  attractor.add(new Particle(new Vec2D(width*1/4, height*1/4), 40));
  attractor.add(new Particle(new Vec2D(width*3/4, height*3/4), 40));

  p=new ArrayList<Particle>();
}

void draw() {

  // Updating physics world
  physics.update();
  background(255);
  for (Particle a : attractor)
    a.display();
  for (Particle p : p) {
    p.display();
  }

  if (mousePressed)
    p.add(new Particle(new Vec2D(mouseX, mouseY)));
}