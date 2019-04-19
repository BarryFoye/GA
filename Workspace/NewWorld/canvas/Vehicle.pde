class Vehicle {
  PVector position; // Where this Vehicle is in the world
  PVector velocity; // the velocity of the Vehicle
  PVector acceleration; // this Vehicles capacity to change speed at a certain rate
  Food food;
  float r; // a "radius" of this vehicle, used to draw a triangular representation
  float visionRadius; // represents how far this Vehicle can see 
  float maxForce; // a limit to the force that can be applied to this vehicle
  float maxSpeed; // a limit to the maximum speed this Vehicle can travel
  float health; // how healthy this Vehicle is
  float targetDistance;
  boolean alive; // this vehicle keeps 

  Vehicle() {
    position = new PVector(floor(random(width)), floor(random(height)));
    velocity = new PVector(width, height);
    acceleration = new PVector(floor(random(width)), floor(random(height)));
    r = 5;
    visionRadius = 60;
    maxForce = 0.3;
    maxSpeed = 1;
    health = MAX_HEALTH;
    alive = true;
    food = null;
    targetDistance = width*height;
  }

  void run() {
    update();
    borders();
    show();
  }

  void update() {
    seek();
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
    checkHealth();
  }

  void search(Food f) {
    PVector newTarget = PVector.sub(f.position, position);
    float d = newTarget.mag();
    if (d < visionRadius) { //if this Vehicle can see the food
      if (d < targetDistance) { // if the current food is further away from this Vehicle than th enew food 
        println("target aquired");
        food = f;
      }
    }
  }


  void seek() {
    // vehicle searches for food
    if (food != null) {
      PVector desired = PVector.sub(food.position, position);
      println("Food");
      desired.normalize();
      desired.mult(maxSpeed);
      PVector steeringForce = PVector.sub(desired, velocity);
      steeringForce.limit(maxForce);
      // apply
      applyForce(steeringForce);
    } else {
      // implement wander
      PVector cast = PVector.add(position, velocity);
      cast.normalize();
      cast.mult(floor(random(0, 10)));
      println("cast: " + cast + " position: " + position + " velocity: " + velocity);
      println("PI: " + PI + " PI/2: " + PI/2 + " PI/4: " + PI/4);
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
    food = null;
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
      pushMatrix();
      translate(position.x, position.y);
      rotate(theta);
      stroke(colourR, colourG, colourB);
      strokeWeight(3);
      line(0, visionRadius/2, 0, -visionRadius/2);
      arc(0, 0, visionRadius*2, visionRadius*2, PI, TWO_PI);
      strokeWeight(1);
      stroke(1);
      fill(colourR, colourG, colourB);
      beginShape();
      vertex(0, -r*2);
      vertex(-r, r*2);
      vertex(r, r*2);
      endShape(CLOSE);
      popMatrix();
    }
  }
}
