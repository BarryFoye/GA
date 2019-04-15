class World {
  // food
  int foodQuantity = 10;
  int foodSize = 5;
  Food food;
  // species - Might add in different species with different evolving abilities (could we get harmony) 

  // entity
  int populationSize = 1;
  ArrayList<Vehicle> population;

  World(int foodQuantity, int vehicleQuantity) {
    food = new Food(foodQuantity);
    population = new ArrayList<Vehicle>();
    for (int i = 0; i < vehicleQuantity; i++) {
      population.add(new Vehicle(floor(random(width)), floor(random(height))));
    }
  }

  void run() {
    food.run();

    for (int i = population.size()- 1; i >= 0; i--) {
      Vehicle v = population.get(i);
      v.run();
      v.seek(food);
      //v.eat(food);

      if (v.dead()) {
      }
    }
    //reproduce
  }
}
