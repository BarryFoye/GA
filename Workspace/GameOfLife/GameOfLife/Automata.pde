class Automata {
  PVector position;
  boolean alive;
  int resolution;
  int liveCells;

  Automata(PVector pos, boolean isAlive, int res) {
    position = pos;
    alive = isAlive;
    resolution = res;
    liveCells = 0;
  }

  void show(boolean c) {
    if (alive) {
      fill(255, 0, 0, 100);
      square(position.x, position.y, width/resolution);
    }
    if (alive && c) {
      fill(0, 255, 0, 100);
      square(position.x, position.y, width/resolution);
    }
  }

  void checkLiveCells(Automata[][] grid, int y, int x) {
    if (y == 0 && x == 0) { 
      if (grid[y    ]  [x + 1].alive) liveCells++; // right
      if (grid[y + 1]  [x + 1].alive) liveCells++; // down right
      if (grid[y + 1]  [x    ].alive) liveCells++; // down
      if (grid[y + 1]  [grid.length - 1].alive) liveCells++; // down left
      if (grid[y    ]  [grid.length - 1].alive) liveCells++; // left
      if (grid[grid.length - 1]  [grid.length - 1].alive) liveCells++; // up left
      if (grid[grid.length - 1]  [x    ].alive) liveCells++; // up
      if (grid[grid.length - 1]  [x + 1].alive) liveCells++; // up right
    } else if (y == grid.length - 1 && x == grid.length - 1) {
      if (grid[y    ]  [x - 1].alive) liveCells++; // left
      if (grid[y - 1]  [x - 1].alive) liveCells++; // up left
      if (grid[y - 1]  [x    ].alive) liveCells++; // up
      if (grid[y - 1]  [0].alive) liveCells++; // up right
      if (grid[y    ]  [0].alive) liveCells++; // right
      if (grid[0]  [0].alive) liveCells++; // down right
      if (grid[0]  [x    ].alive) liveCells++; // down
      if (grid[0]  [x - 1].alive) liveCells++; // down left
    } else if (y > 0 && y < grid.length - 1 && x == 0) { 
      if (grid[y - 1]  [x    ].alive) liveCells++; // up
      if (grid[y - 1]  [x + 1].alive) liveCells++; // up right
      if (grid[y    ]  [x + 1].alive) liveCells++; // right
      if (grid[y + 1]  [x + 1].alive) liveCells++; // down right
      if (grid[y + 1]  [x    ].alive) liveCells++; // down
      if (grid[y + 1]  [grid.length - 1].alive) liveCells++; // down left
      if (grid[y    ]  [grid.length - 1].alive) liveCells++; // left
      if (grid[y - 1]  [grid.length - 1].alive) liveCells++; // up left
    } else if (y == 0 && x > 0 && x < grid.length - 1) {
      if (grid[y    ]  [x + 1].alive) liveCells++; // right
      if (grid[y + 1]  [x + 1].alive) liveCells++; // down right
      if (grid[y + 1]  [x    ].alive) liveCells++; // down
      if (grid[y + 1]  [x - 1].alive) liveCells++; // down left
      if (grid[y    ]  [x - 1].alive) liveCells++; // left
      if (grid[grid.length - 1]  [x - 1].alive) liveCells++; // up left
      if (grid[grid.length - 1]  [x    ].alive) liveCells++; // up
      if (grid[grid.length - 1]  [x + 1].alive) liveCells++; // up right
    } else if (y > 0 && y < grid.length - 1 && x == grid.length - 1) {
      if (grid[y + 1]  [x    ].alive) liveCells++; // down
      if (grid[y + 1]  [x - 1].alive) liveCells++; // down left
      if (grid[y    ]  [x - 1].alive) liveCells++; // left
      if (grid[y - 1]  [x - 1].alive) liveCells++; // up left
      if (grid[y - 1]  [x    ].alive) liveCells++; // up
      if (grid[y - 1]  [0].alive) liveCells++; // up right
      if (grid[y    ]  [0].alive) liveCells++; // right
      if (grid[y + 1]  [0].alive) liveCells++; // down right
    } else if (y == grid.length - 1 && x > 0 && x < grid.length - 1) {
      if (grid[y    ]  [x - 1].alive) liveCells++; // left
      if (grid[y - 1]  [x - 1].alive) liveCells++; // up left
      if (grid[y - 1]  [x    ].alive) liveCells++; // up
      if (grid[y - 1]  [x + 1].alive) liveCells++; // up right
      if (grid[y    ]  [x + 1].alive) liveCells++; // right
      if (grid[0    ]  [x + 1].alive) liveCells++; // down right
      if (grid[0    ]  [x    ].alive) liveCells++; // down
      if (grid[0    ]  [x - 1].alive) liveCells++; // down left
    } else if (y > 0 && x > 0 && y < grid.length - 1 && x < grid.length - 1) { 
      if (grid[y - 1]  [x    ].alive) liveCells++; // up
      if (grid[y - 1]  [x + 1].alive) liveCells++; // up right
      if (grid[y    ]  [x + 1].alive) liveCells++; // right
      if (grid[y + 1]  [x + 1].alive) liveCells++; // down right
      if (grid[y + 1]  [x    ].alive) liveCells++; // down 
      if (grid[y + 1]  [x - 1].alive) liveCells++; // down left
      if (grid[y    ]  [x - 1].alive) liveCells++; // left
      if (grid[y - 1]  [x - 1].alive) liveCells++; // up left
    }
  }


  void determineLife() {
    if (alive && liveCells < 2) {
      alive = false;
    } 
    if (alive && (liveCells == 2 || liveCells == 3)) {
      alive = true;
    }
    if (alive && liveCells > 3) {
      alive = false;
    }
    if (!alive && liveCells == 3) {
      alive = true;
    }
    liveCells = 0;
  }
}
