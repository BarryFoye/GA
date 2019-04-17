Vehicle vehicle;
Food food;
int BORDER = 20;

class World {
 World(){
   vehicle = new Vehicle();
   food = new Food();
 }
 
 void run(){
   vehicle.run();
   food.run();
   food.checkCollision(vehicle.position);
 }
  
}
