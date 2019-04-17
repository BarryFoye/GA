Vehicle vehicle;
Food food;

class World {
 World(){
   vehicle = new Vehicle();
   food = new Food();
 }
 
 void run(){
   vehicle.run();
   food.run();
 }
  
}
