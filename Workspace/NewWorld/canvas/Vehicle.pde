class Vehicle {
  PVector position; // Where this Vehicle is in the world
  PVector velocity; // the velocity of the Vehicle
  PVector acceleration; // this Vehicles capacity to change speed at a certain rate
  float r; // a "radius" of this vehicle, used to draw a triangular representation
  float visionRadius; // represents how far this Vehicle can see 
  float maxForce; // a limit to the force that can be applied to this vehicle
  float maxSpeed; // a limit to the maximum speed this Vehicle can travel
  float health; // how healthy this Vehicle is
  boolean alive; // this vehicle keeps 
  boolean targetAquired; // if food is in range then this Vehicle shoud steer towards it only

  Vehicle() {
    position = new PVector(floor(random(width)), floor(random(height)));
    velocity = new PVector(400, 400);
    acceleration = new PVector(floor(random(width)), floor(random(height)));
    r = 5;
    visionRadius = 60;
    maxForce = 0.3;
    maxSpeed = 1;
    health = MAX_HEALTH;
    alive = true;
    targetAquired = false;
  }

  void run() {
    update();
    borders();
    show();
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
    checkHealth();
  }

  void seek(Food food){
    // vehicle searches for food
    PVector desired = PVector.sub(position, food.position);
    if(desired.mag() < visionRadius){
      println("target aquired");
      targetAquired = true;
      desired.normalize();
      desired.mult(maxSpeed);
      PVector steeringForce = PVector.sub(desired, velocity);
      steeringForce.limit(maxForce);
      // apply
      applyForce(steeringForce);
    }
  }

  void checkHealth() {
    if (health <= 0) { 
      alive = false;
    } else {
      health -= 0.05;
    }
  }


  void borders() {    
    PVector desired = null;
    if (position.x < BORDER) desired = new PVector(maxSpeed, velocity.y);
    if (position.x > width-BORDER) desired = new PVector(-maxSpeed, velocity.y);
    if (position.y < BORDER) desired = new PVector(velocity.x, maxSpeed);
    if (position.y > height-BORDER) desired = new PVector(velocity.x, -maxSpeed);
    if (desired != null) {
      desired.normalize();
      desired.mult(maxSpeed);
      PVector steeringForce = PVector.sub(desired, velocity);
      steeringForce.limit(maxForce);
      // apply
      applyForce(steeringForce);
    }
  }

  void addHealth(float nutrition) {
    health += nutrition;
    if (health > MAX_HEALTH) health = MAX_HEALTH;
    targetAquired = false;
    //applyForce(new PVector(floor(random(-20.0, 20.0)), floor(random(-20.0, 20.0))));//###############
  }

  void applyForce(PVector force) {    
    acceleration.add(force);
  }

  void show() {
    if (alive) {
      float colourR = map(health, 0, MAX_HEALTH, 255, 0);
      float colourG = map(health, 0, MAX_HEALTH, 0, 255);
      float colourB = map(health, 0, MAX_HEALTH, 50, 150);
      float theta = velocity.heading() + PI/2;
      fill(colourR, colourG, colourB);
      noStroke();
      pushMatrix();
      translate(position.x, position.y);
      rotate(theta);
      beginShape();
      vertex(0, -r*2);
      vertex(-r, r*2);
      vertex(r, r*2);
      endShape(CLOSE);
      popMatrix();
    }
  }
}
