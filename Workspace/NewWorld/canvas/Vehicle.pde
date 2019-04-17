class Vehicle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxForce;
  float maxSpeed;
  float health;

  Vehicle() {
    position = new PVector(floor(random(width)), floor(random(height)));
    velocity = new PVector(400, 400);
    acceleration = new PVector(floor(random(width)), floor(random(height)));
    println(acceleration);
    r = 5;
    maxForce = 0.03;
    maxSpeed = 1;
    health = MAX_HEALTH;
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
    health -= 0.01;
    println(health);
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
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void show() {
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
