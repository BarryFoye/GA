// food
int foodQuantity = 10;
int foodSize = 5;
ArrayList<Food> food;
// species - Might add in different species with different evolving abilities (could we get harmony) 

// entity
int populationSize = 1;
ArrayList<Vehicle> population;

int BORDER = 20;

// Input/debug
PVector mouse;
int gridX;
int gridY;

//World
World world;


void setup() {
  size(1920, 1080);
  world = new World(foodQuantity, populationSize);
  initFood(foodQuantity);//move to world
  initVehicle(populationSize);//move to world
  initFood();//move to world
  gridX = floor(width/20);//Debug
  gridY = floor(height/20);//Debug
  mouse = new PVector(height/2, width/2);//Debug
}

void initFood(int foodNum) {
  //food = new ArrayList<Food>(foodNum);
  //for (int i = 0; i < foodNum; i++) {
  //  food.add(new Food(i, floor(random(width)), floor(random(height))));
  //  food.get(i).setSize(foodSize);
  //}
  
}

void initVehicle(int vehicleQuantity) {
  //population = new ArrayList<Vehicle>(vehicleQuantity);
  //for (int i = 0; i < vehicleQuantity; i++) {
  //  population.add(new Vehicle(floor(random(width)), floor(random(height))));
  //}
  //  for(int i = 0; i < v; i++){
  //    population.get(i).c = color(i * 20, i * 5, i * 3);
  //  }
}

void initFood() {
  Vehicle v = null;
  for (int i = 0; i < population.size(); i++) {
    v = population.get(i);
    v.setTarget(food.get(floor(random(food.size() -1))));
  }
}

void draw() {
  background(255);
  //stroke(10);

  //for (int i = gridX; i < width; i+=gridX) {
  //  line(i,0, i, height);
  //}
  //for (int i = gridY; i < height; i+=gridY) {
  //  line(0,i, width, i);
  //}

  fill(0);
  //food
  for (int i = 0; i < food.size(); i++) {    
    food.get(i).display();
  }
  stroke(50);
  // population
  Vehicle v = null;
  PVector target;
  boolean eaten = false;
  mouse.x = mouseX;
  mouse.y = mouseY;
  for (int i = 0; i < population.size(); i++) {  
    v = population.get(i);
    target = v.getTarget().position;    
    eaten = v.seek(mouse);

    if (eaten) {
      food.remove(v.getTarget().getID());
      for (int j = 0; j < food.size(); j++) {
        food.get(j).arrayID = j;
      }
    }
    //v.arrive(target);
    //v.flee(mouse);
    v.update();
    v.display();
    PVector fo = PVector.sub(v.location, v.getTarget().position);   // Calculate direction of force
    float distanceToCurrentTarget = fo.mag(); // Distance between objects
    for (int j = 0; j < food.size(); j++) {
      v.updateClosest(food.get(j));
    }
  }
}
