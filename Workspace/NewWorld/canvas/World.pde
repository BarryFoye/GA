int BORDER = 20;
int MAX_FOOD = 10;
int MAX_POPULATION = 10;
float MAX_HEALTH = 100;

ArrayList<Vehicle> vehicle;
ArrayList<Food> food;


class World {
  World() {
    vehicle = new ArrayList<Vehicle>();
    food = new ArrayList<Food>();
    for (int i = 0; i < MAX_FOOD; i++) {
      food.add(new Food());
    }
    for (int i = 0; i < MAX_POPULATION; i++) {
      vehicle.add(new Vehicle());
    }
  }

  void run() {
    for (Vehicle v : vehicle) {
      v.run();
      for (Food f : food) {        
        f.checkCollision(v);
        f.run();
      }
    }
    for (int i = food.size() - 1; i >= 0; i--) {
      if (food.get(i).eaten == true) food.remove(i);
    }
    for (int i = vehicle.size() - 1; i >= 0; i--) {
      if (vehicle.get(i).alive == false) vehicle.remove(i);
    }
  }
}
