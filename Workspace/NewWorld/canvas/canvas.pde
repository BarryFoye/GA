/** Canvas on which the world is based **/
World world;
void setup(){
  size(800, 400);
  
  world = new World();
  //noLoop();
}

void draw(){
  background(255);
  world.run();
  //noLoop();
}
