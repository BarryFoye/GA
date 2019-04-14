class Vehicle {

  ArrayList<PVector> history;
  PVector location; // where I am
  PVector velocity; // Where I will be
  PVector acceleration; // How fast 

  //PVector[] orientation = {new PVector(), new PVector(), new PVector()};

  float mass;
  float maxForce;
  float maxSpeed;

  float r;

  Food target;
  float targetDistance;
  float consumeR;

  // Senses
  //int visionRadius = 10;

  Vehicle(float x, float y) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    location = new PVector(x, y);
    r = 5.0;
    maxForce = 0.01;
    maxSpeed = 1;
    target = null;
    history = new ArrayList<PVector>();
    consumeR = 1;
  }

  void run() {
    update();
    borders();
    display();
  }

  void eat(Food f) {
  }

  boolean dead() {
  }

  void setTarget(Food newTarget) {
    this.target = newTarget;
    PVector f = PVector.sub(location, this.target.position);   // Calculate direction of force
    this.targetDistance = f.mag();
  }

  Food getTarget() {
    return this.target;
  }

  void seek(Food f) {
    //2 modes: wander and charge
    
    
    //boolean consume = false;
    //PVector desired = PVector.sub(target, location);
    //if (desired.mag() < consumeR) {
    //  consume = true;
    //} else {
    //  consume = false;
    //  desired.normalize();
    //  desired.mult(maxSpeed);
    //  PVector steeringForce = PVector.sub(desired, velocity);
    //  steeringForce.limit(maxForce);
    //  // apply
    //  applyForce(steeringForce);
    //}
    //return consume;
  }

  boolean seek(PVector target) {
    boolean consume = false;
    PVector desired = PVector.sub(target, location);
    if (desired.mag() < consumeR) {
      consume = true;
    } else {
      consume = false;
      desired.normalize();
      desired.mult(maxSpeed);
      PVector steeringForce = PVector.sub(desired, velocity);
      steeringForce.limit(maxForce);
      // apply
      applyForce(steeringForce);
    }
    return consume;
  }

  void flee(PVector target) {
    PVector desired = PVector.sub(target, location);
    if (!borders()) {
      desired.normalize();
      desired.mult(maxSpeed);
      PVector steeringForce = PVector.sub(desired, velocity);
      steeringForce.limit(maxForce);
      // apply
      applyForce(steeringForce);
    }
  }

  void arrive(PVector target) {
    PVector desired = PVector.sub(target, location);
    float d = desired.mag();
    desired.normalize();
    if (d< 100) {
      float m = map(d, 0, 100, 0, maxSpeed);
      desired.mult(m);
    } else {
      desired.mult(maxSpeed);
    }
    PVector steeringForce = PVector.sub(desired, velocity);
    steeringForce.limit(maxForce);
    // apply
    applyForce(steeringForce);
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
    history.add(new PVector(location.x, location.y));
    if (history.size() > 500) {
      history.remove(0);
    }
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void updateClosest(Food food) {
    PVector f = PVector.sub(location, food.position);   // Calculate direction of force
    float closest = f.mag(); // Distance between objects                          
    if (closest < targetDistance) {
      setTarget(food);
    }
  }

  boolean borders() {
    PVector desired = null;
    boolean changed = false;
    if (location.x < BORDER) desired = new PVector(maxSpeed, velocity.y);
    if (location.x > width-BORDER) desired = new PVector(-maxSpeed, velocity.y);
    if (location.y < BORDER) desired = new PVector(velocity.x, maxSpeed);
    if (location.y > height-BORDER) desired = new PVector(velocity.x, -maxSpeed);
    if (desired != null) {
      changed = true;
      desired.normalize();
      desired.mult(maxSpeed);
      PVector steeringForce = PVector.sub(desired, velocity);
      steeringForce.limit(maxForce);
      // apply
      applyForce(steeringForce);
    }
    return changed;
  }

  void display() {
    //textMode(1);
    //textSize(20);
    //stroke(1);
    //text("velocityX = " + velocity.x + ";", 200, 185);
    //text("velocityY = " + velocity.y, 200, height - 200);
    beginShape();
    stroke(0);
    strokeWeight(1);
    noFill();
    for (PVector v : history) {
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    float theta = velocity.heading() + PI/2;
    fill(175);
    stroke(0);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
}
