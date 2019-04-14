class Food {
  ArrayList<PVector> food;
  int arrayID;
  PVector position; 
  float size;
  float mass;
  color c;  


  Food() {
    position = new PVector(floor(random(width-20)), floor(random(height-20)));
    size = 0;
    mass = 1;
    c = color(150, 204, 0);
  }

  Food(int id, float x, float y) {
    arrayID = id;
    position = new PVector(x, y);
    size = 0;
    mass = 1;
    c = color(150, 204, 0);
  }
  
    Food(int quantity) {
    food = new ArrayList<PVector>();
    for(int i = 0; i < quantity; i++){
      food.add(new PVector(floor(random(BORDER, width-BORDER)), floor(random(BORDER, height-BORDER)))); 
    }
  }

  void display() {
    stroke(0);
    fill(c);
    ellipse(position.x, position.y, this.size, this.size);
  }
  
  void run(){
    
  }


  float getSize() {
    return this.size;
  }

  void setSize(float size) {
    this.size = size;
  }
  
  int getID(){
    return arrayID;
  }
}
