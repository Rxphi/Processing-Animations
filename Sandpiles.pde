
int[][] sandpiles;

void setup() {
  size(200, 200);
  sandpiles = new int[width][height];
  sandpiles[width/2][height/2] = int(pow(2, 12));
}

void topple() {
  int[][] nextpiles = new int[width][height];

  for (int i = 0; i < height; i++) {
    for (int j = 0; j < width; j++) {

      int num = sandpiles[j][i];

      if (num < 4) {
        nextpiles[j][i] = num;
      }
    }
  }

  for (int i = 0; i < height; i++) {
    for (int j = 0; j < width; j++) {

      int num = sandpiles[j][i];

      if (num >= 4) {
        nextpiles[j][i] += num - 4;
        if (j + 1 < width)
          nextpiles[j+1][i]++;
        if (j - 1 >= 0)
          nextpiles[j-1][i]++;
        if (i + 1 < height)
          nextpiles[j][i+1]++;
        if (i - 1 >= 0)
          nextpiles[j][i-1]++;
      }
    }
  }
  
  sandpiles = nextpiles;
}
void render() {
  loadPixels();

  for (int i = 0; i < height; i++) {
    for (int j = 0; j < width; j++) {

      int num = sandpiles[j][i];
      color col = color(255, 0, 0);
      if (num == 0) {
        col = color(255, 255, 0);
      } else if (num == 1) {
        col = color(0, 185, 63);
      } else if (num == 2) {
        col = color(0, 104, 255);
      } else if (num == 3) {
        col = color(122, 0, 229);
      }

      pixels[i * width + j] = col;
    }
  }
  updatePixels();
}

void draw() {
  render();
  
  for (int i = 0; i < 10; i++){
    topple();
  }
}
