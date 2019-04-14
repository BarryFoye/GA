class Entity {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  Food target;
  color c;  
  float shapeSize;
  float distanceToCurrentTarget;

  Entity() {
    position = new PVector(floor(random(width)), floor(random(height))); 
    velocity = new PVector(1, 0);
    acceleration = new PVector(0, 0);
    mass = 1;
    target = null;
    c = color(255, 204, 0);
    shapeSize = 7;
    distanceToCurrentTarget = 0;
  }

  Entity(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(1, 0);
    acceleration = new PVector(0, 0);
    mass = 1;
    target = null;
    c = color(255, 204, 0);
    shapeSize = 7;
    distanceToCurrentTarget = 0;
  }

  //void applyForce(PVector force) {
  //  if(force != null){
  //    PVector f = PVector.div(force,mass);
  //    acceleration.add(f);
  //  } else {
  //    PVector f = PVector.sub(getTarget().position, position);   // Calculate direction of force
  //    distanceToCurrentTarget = f.mag();                              // Distance between objects
  //    distanceToCurrentTarget = constrain(distanceToCurrentTarget,5.0,25.0);                          // Limiting the distance to eliminate "extreme" results for very close or very far objects
  //    f.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
  //    float strength = (G * mass * getTarget().mass) / (distanceToCurrentTarget * distanceToCurrentTarget);     // Calculate gravitional force magnitude
  //    f.mult(strength);     // Get force vector --> magnitude * direction
  //    applyForce(f);
  //  }

  //}

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    fill(c);
    triangle(
      (getPosition().x), (getPosition().y), 
      (getPosition().x - shapeSize), (getPosition().y + shapeSize*3), 
      (getPosition().x + shapeSize), (getPosition().y + shapeSize*3));
  }

  PVector getPosition() {
    return this.position;
  }

  void setPosition(PVector newPosition) {
    this.position = newPosition;
  }

  Food getTarget() {
    return this.target;
  }

  void setTarget(Food newTarget, float distanceToCurrentTarget) {
    this.target = newTarget;
    this.distanceToCurrentTarget = distanceToCurrentTarget;
  }

  boolean isClosest(Food potentialTarget) {

    return true;
  }
}
