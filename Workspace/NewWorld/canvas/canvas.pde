World world;


void setup(){
  size(400, 400);
  
  world = new World();
  //noLoop();
}

void draw(){
  background(50);
  world.run();
  
}
