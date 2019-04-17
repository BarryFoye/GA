int BORDER = 20;
int MAX_FOOD = 10;
int MAX_POPULATION = 1;
float MAX_HEALTH = 100;

Vehicle vehicle;
ArrayList<Food> food;


class World {
  World() {
    vehicle = new Vehicle();
    food = new ArrayList<Food>();
    for (int i = 0; i < MAX_FOOD; i++) {
      food.add(new Food());
    }
  }

  void run() {
    vehicle.run();
    for (Food f : food) {
      f.run();
      f.checkCollision(vehicle);
    }
  }
}
