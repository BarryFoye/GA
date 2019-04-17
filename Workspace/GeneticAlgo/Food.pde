class Food {
  ArrayList<Food> foods;
  PVector position; 
  float size;
  float mass;
  color c; 
  boolean eaten = false; // TODO: // Each food should keep a flag to say if it is eaten
  // If true it should be removed


  Food() {
    position = new PVector(floor(random(width-20)), floor(random(height-20)));
    size = 0;
    mass = 1;
    c = color(150, 204, 0);
  }

  Food(float x, float y) {
    position = new PVector(x, y);
    size = 10;
    eaten = false;
    c = color(150, 204, 0);
  }

  Food(int quantity) {
    foods = new ArrayList<Food>();
    for (int i = 0; i < quantity; i++) {
      //foods.add(new Food(floor(random(BORDER, width-BORDER)), floor(random(BORDER, height-BORDER))));
      foods.add(new Food(width/2, height/2));
    }
  }

  void display() {
    stroke(0);
    fill(50);
    ellipse(position.x, position.y, this.size, this.size);
  }

  void run() {
    for(int i = foods.size() - 1; i >= 0; i--){
      if(foods.get(i).isEaten()){
        foods.remove(i);
      }      
    }
    for(Food food : foods){
      food.display();
    }
    // food replenishment 
    if(random(0.0, 1.0) < 0.1){
      foods.add(new Food(floor(random(BORDER, width-BORDER)), floor(random(BORDER, height-BORDER))));
    }
  }


  float getSize() {
    return this.size;
  }

  void setSize(float size) {
    this.size = size;
  }

  boolean isEaten() {
    return eaten;
  }
  
    void setEaten(boolean isEaten) {
    this.eaten = isEaten;
  }
}
