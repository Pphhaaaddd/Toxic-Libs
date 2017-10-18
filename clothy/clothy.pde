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

int w=10, cols =40, rows=10;

void setup() {
  size(640, 480, P2D);

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

      //if (j != 0) {
      //  s.add(new Spring(p.get(j-1), p.get(j)));
      //  physics.addSpring(s.get(j-1));
      //}

      y+=w;
      physics.addParticle(p[i][j]);
    }
    x+=w;
  }
  for (int i=0; i<cols-1; i++) {
    for (int j=0; j<rows; j++) {
      Particle p1 = p[i][j];
      Particle p2 = p[i+1][j];  
      
      Spring s1 = new Spring(p1,p2); 
      s.add(s1);
      physics.addSpring(s1);
    }
  }
  p[0][0].lock();
  p[0][rows-1].lock();
}

void draw() {

  // Updating physics world
  physics.update();
  background(0);

  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      p[i][j].display();
    }
  }
  for (Spring s : s) {
    s.display();
  }
}