import toxi.audio.*;
import toxi.color.*;
import toxi.color.theory.*;
import toxi.data.csv.*;
import toxi.data.feeds.*;
import toxi.data.feeds.util.*;
import toxi.doap.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh2d.*;
import toxi.geom.nurbs.*;
import toxi.image.util.*;
import toxi.math.*;
import toxi.math.conversion.*;
import toxi.math.noise.*;
import toxi.math.waves.*;
import toxi.music.*;
import toxi.music.scale.*;
import toxi.net.*;
import toxi.newmesh.*;
import toxi.nio.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;
import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;
import toxi.processing.*;
import toxi.sim.automata.*;
import toxi.sim.dla.*;
import toxi.sim.erosion.*;
import toxi.sim.fluids.*;
import toxi.sim.grayscott.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;
import toxi.volume.*;

VerletPhysics2D physics; 

Particle[][] p;
ArrayList<Spring> s;

AttractionBehavior2D mouseAttractor;
GravityBehavior2D wind;

int w=10, cols =40, rows=40;
float t=0;

void setup() {
  size(1280, 720, P2D);

  p = new Particle[cols][rows];
  s = new ArrayList<Spring>();

  physics = new VerletPhysics2D();

  //Gravity
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0, 0.5)));
  //World Boundaries
  physics.setWorldBounds(new Rect(0, 0, width, height));
  int x=100, y=50;
  for (int i=0; i<cols; i++) {
    y=50;
    for (int j=0; j<rows; j++) {
      p[i][j] = new Particle(x, y);

      y+=w;
      physics.addParticle(p[i][j]);
    }
    x+=w;
  }
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      if (i<cols-1) {
        Particle p1 = p[i][j];
        Particle p2 = p[i+1][j];  

        Spring s1 = new Spring(p1, p2); 
        s.add(s1);
        physics.addSpring(s1);
      }

      if (j<rows-1) {
        Particle p1 = p[i][j];
        Particle p2 = p[i][j+1];  

        Spring s1 = new Spring(p1, p2); 
        s.add(s1);
        physics.addSpring(s1);
      }
    }
  }

  p[0][0].lock();
  p[cols/2][0].lock();
  p[cols-1][0].lock();
}

void draw() {

  // Updating physics world
  physics.update();
  background(0);

  //for (int i=0; i<cols; i++) {
  //  for (int j=0; j<rows; j++) {
  //    p[i][j].display();
  //  }
  //}
  for (Spring s : s) {
    s.display();
  }
  t+=0.01;
}

void mousePressed() {
  wind = new GravityBehavior2D(new Vec2D(map(noise(t), 0, 1, -2, 2), 0));
  physics.addBehavior(wind);
}

//void mouseDragged() {
//  // update mouse attraction focal point

//  mousePos.set(mouseX, mouseY);
//}

void mouseReleased() {
  // remove the mouse attraction when button has been released
  physics.removeBehavior(wind);
}