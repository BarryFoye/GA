/** Constants **/
int BORDER = 20;
int MAX_FOOD = 200;
int MAX_POPULATION = 10;
float MAX_HEALTH = 100;
/** Things **/
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
      vehicle.add(new Vehicle(i));
    }
  }

  void run() {

    for (Food f : food) {   
      f.show();
    }
    for (Vehicle v : vehicle) { 
      for (Food f : food) {
        if (!f.eaten) {
          v.seek(f);        
          v.checkCollision(f);
        }
      }
      v.run();
    }    
    for (int i = food.size() - 1; i >= 0; i--) {
      if (food.get(i).eaten == true) food.remove(i);
    }
    for (int i = vehicle.size() - 1; i >= 0; i--) {
      if (vehicle.get(i).alive == false) vehicle.remove(i);
    }
    addFood();
  }


  //void run() {
  //  for (Food f : food) {   
  //    f.show();
  //  }
  //  for (Vehicle v : vehicle) { 

  //    for (Food f : food) {
  //      if (!f.eaten) {
  //        v.search(f);        
  //        v.checkCollision(f);
  //      }
  //    }
  //    v.run();
  //  }
  //  for (int i = food.size() - 1; i >= 0; i--) {
  //    if (food.get(i).eaten == true) food.remove(i);
  //  }
  //  for (int i = vehicle.size() - 1; i >= 0; i--) {
  //    if (vehicle.get(i).alive == false) vehicle.remove(i);
  //  }
  //  addFood();
  //}

  void addFood() {
    if (random(0.0, 1.0) < 0.01) {
      food.add(new Food());
    }
  }
}
