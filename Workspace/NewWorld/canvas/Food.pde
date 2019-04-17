class Food {
  PVector position;
  boolean eaten;
  float nutrition;
  float r;

  Food() {
    position = new PVector(floor(random(width)), floor(random(height)));
    eaten = false;
    nutrition = (random(0.0, 1.0));
    r = (map(random(0.0, nutrition ), 0.0, nutrition, 0.0, 50.0));
  }

  void run() {
    show();
  }

  void checkCollision(Vehicle vehicle) {
    PVector f = PVector.sub(position, vehicle.position);
    if (f.mag() < r) {
      eaten = true;
      vehicle.addHealth(nutrition);
    }
  }

  void show() {
    if (!eaten) {
      fill(78, 95);
      circle(position.x, position.y, r);
    }
  }
}
