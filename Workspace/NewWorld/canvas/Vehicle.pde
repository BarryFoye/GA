class Vehicle{
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  
  Vehicle(){
    position = new PVector(floor(random(width)), floor(random(height)));
    velocity = new PVector(400, 400);
    r = 5;
  }
  
  void run(){
    update();
    borders();
    show();
    
  }
  
  void update(){
    
  }
  
  void borders(){
    
  }
  
  void show(){
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
