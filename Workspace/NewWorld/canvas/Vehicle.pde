class Vehicle {
  PVector position; // Where this Vehicle is in the world
  PVector velocity; // the velocity of the Vehicle
  PVector acceleration; // this Vehicles capacity to change speed at a certain rate
  Food food; // target food
  float r; // a "radius" of this vehicle, used to draw a triangular representation
  float visionRadius; // represents how far this Vehicle can see 
  float maxForce; // a limit to the force that can be applied to this vehicle
  float maxSpeed; // a limit to the maximum speed this Vehicle can travel
  float health; // how healthy this Vehicle is
  float targetDistance;
  boolean alive; // this vehicle keeps 
  int count; // used to control the wandering frequency
  int wanderFrequency; // used to control the number of frames per update
  int vID; // vehicle ID for test purposes
  ArrayList<PVector> history;

  Vehicle(int id) {
    position = new PVector(floor(random(width)), floor(random(height)));
    velocity = new PVector(width, height);
    acceleration = new PVector(floor(random(width)), floor(random(height)));
    history = new ArrayList<PVector>();
    history.add(position);
    r = 5;
    visionRadius = 60;
    maxForce = 0.3;
    maxSpeed = 1;
    health = MAX_HEALTH;
    alive = true;
    food = null;
    targetDistance = width*height;
    count = 0;
    vID = id;
    wanderFrequency = floor(random(30, 120));
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
    if (history.size() > 50) {
      history.remove(0);
      history.add(position);
    } else {
      history.add(position);
    }
    acceleration.mult(0);
    checkHealth();
  }

  void search(Food f) {
    PVector newTarget = PVector.sub(f.position, position);
    float d = newTarget.mag();
    if (d < visionRadius) { //if this Vehicle can see the food
      if (d < targetDistance) { // if the current food is further away from this Vehicle than th enew food 
        food = f;
      }
    }
  }

  void checkCollision(Food f) {
    // Food keeps track of whether it has been eaten
    PVector fNew = PVector.sub(position, f.position);
    if (fNew.mag() < f.r * 0.85) {      
      f.eaten = true;
      // Vehicles health is replenished 
      addHealth(f.nutrition);
    }
  }

  void seek() {
    // vehicle searches for food
    if (food != null && !food.eaten) {
      PVector desired = PVector.sub(food.position, position);
      desired.normalize();
      desired.mult(maxSpeed);
      PVector steeringForce = PVector.sub(desired, velocity);
      steeringForce.limit(maxForce);
      // apply
      applyForce(steeringForce);
    } else {
      // implement wander
      if (count == 0 || count % wanderFrequency == 0) {
        PVector wander = new PVector(random(-1, 1), random(-1, 1));
        wander.normalize();
        wander.mult(maxSpeed);
        PVector steeringForce = PVector.sub(wander, velocity);
        steeringForce.limit(maxForce);
        // apply
        applyForce(steeringForce);
      }
      if (count == wanderFrequency+1) {
        count = 0;
      } else {
        count++;
      }
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
      stroke(1);
      //beginShape();
      //for (int i = 0; i < history.size(); i++) {
      //  curveVertex(history.get(i).x, history.get(i).y);
      //  println(history.get(i).x + "    " + history.get(i).y);
      //}
      //endShape();
      translate(position.x, position.y);
      rotate(theta);
      stroke(colourR, colourG, colourB);
      //strokeWeight(3);
      //line(0, visionRadius/2, 0, -visionRadius/2);      
      //noFill();
      //arc(0, 0, visionRadius*2, visionRadius*2, PI, TWO_PI);
      //strokeWeight(1);
      //stroke(1);
      //fill(colourR, colourG, colourB);
      //text("id: " + vID, 10, 10);      
      beginShape();
      vertex(0, -r*2);
      vertex(-r, r*2);
      vertex(r, r*2);
      endShape(CLOSE);
      //beginShape();
      //for (int i = 0; i < history.size(); i++) {
      //  curveVertex(history.get(i).x, history.get(i).y);
      //  println(history.get(i).x + "    " + history.get(i).y);
      //}
      //endShape();
      popMatrix();
    }
  }
}
