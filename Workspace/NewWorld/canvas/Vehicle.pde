class Vehicle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxForce;
  float maxSpeed;
  float health;
  boolean alive;

  Vehicle() {
    position = new PVector(floor(random(width)), floor(random(height)));
    velocity = new PVector(400, 400);
    acceleration = new PVector(floor(random(width)), floor(random(height)));
    r = 5;
    maxForce = 0.3;
    maxSpeed = 1;
    health = MAX_HEALTH;
    alive = true;
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
    println(health);
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
      println("borders");
      desired.normalize();
      desired.mult(maxSpeed);
      PVector steeringForce = PVector.sub(desired, velocity);
      steeringForce.limit(maxForce);
      // apply
      applyForce(steeringForce);
    }
  }

  void addHealth(float nutrition) {
    println(nutrition);
    health += nutrition;
    if (health > MAX_HEALTH) health = MAX_HEALTH;
  }

  void applyForce(PVector force) {
    
    acceleration.add(force);
  }

  void show() {
    if (alive) {
      stroke(1);
      fill(255);
      float theta = velocity.heading() + PI/2;
      fill(175);
      stroke(0);
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
