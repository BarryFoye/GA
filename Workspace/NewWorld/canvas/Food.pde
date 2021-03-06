/** Food the giver of life **/

class Food {
  PVector position; // Where in the world is this food located
  boolean eaten; // Used to determine if this food has been eaten
  float nutrition; // life or fule value. When consumed it will be combined with the vehicles current health
  float r; // radius of this food. 

  Food() {
    // Each food gets a default, random new position
    position = new PVector(floor(random(width)), floor(random(height)));
    eaten = false;
    nutrition = (random(0.0, 20.0));
    r = (map(random(0.0, nutrition ), 0.0, nutrition, 0.0, 50.0));
  }

  void show() {
    if (!eaten ) {
      noStroke();
      fill(170, 95);
      circle(position.x, position.y, r);
    }
  }
}
