
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;
SpringChain s;

void setup() {
  size(640, 480); 

  physics = new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0, 0.5)));
  physics.setDrag(0.05f);

  //World Boundaries
  physics.setWorldBounds(new Rect(0, 0, width, height));
  s = new SpringChain(new Vec2D(width/2, 20));
}

void draw() {

  // Updating physics world
  physics.update();

  background(255);
  
  s.display();
  if (mousePressed) {
    s.dragAction();
  }
}