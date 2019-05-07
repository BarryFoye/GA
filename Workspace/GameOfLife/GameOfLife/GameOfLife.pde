Automata[][] grid;
Automata[][] gridCopy;
int resolution = 100;

void setup() {
  size(800, 800);
  frameRate(4);
  grid = new Automata[resolution][resolution];
  gridCopy = new Automata[resolution][resolution];
  int x = 0;
  int y = 0;
  boolean odd = false;
  for (int i = 0; i < grid.length; i++) {
    for ( int j = 0; j < grid.length; j++) {
      if(random(0, 1) < 0.07) odd = true;
      grid[i][j] = new Automata(new PVector(x, y), odd, resolution);
      x += width/resolution;
      odd = false;
    }
    x = 0;
    y += height/resolution;
  }
  arrayCopy(grid, gridCopy);
  //noLoop();
}

void draw() {
  background(255);  
  //new Silly().show();
  for (int i = 0; i < grid.length; i++) {
    for ( int j = 0; j < grid.length; j++) {
      gridCopy[i][j].show(false);
      //new Silly().show();
    }
  }
  for (int i = 0; i < grid.length; i++) {
    for ( int j = 0; j < grid.length; j++) {
      grid[i][j].checkLiveCells(grid, i, j);
    }
  }
  for (int i = 0; i < grid.length; i++) {
    for ( int j = 0; j < grid.length; j++) {
      grid[i][j].determineLife();
    }
  }  
  arrayCopy(grid, gridCopy);
}

//void mousePressed() {
//  loop();  // Holding down the mouse activates looping
//}

//void mouseReleased() {
//  noLoop();  // Releasing the mouse stops looping draw()
//}
