int w = 300;
int h = 2000;
int cols, rows;
int scl = 20;

float angleX, angleZ;

float flying = 0;

float[][] terrain;

void setup() {
  println("Just a small programm, that generates some 3d vertices with some perlin noise to get the z-value of each point :)");
  size(800, 800, P3D);
  colorMode(HSB);
  cols = w / scl;
  rows = h / scl;
  
  terrain = new float[cols][rows];
}

void draw() {
  // create z positions of the terrain with perlin noise
  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.2;
    }
    yoff += 0.2;
  }
  
  flying -= 0.1;
  
  //actually drawing the vertices
  background(0);
  noFill();

  float hue;
  
  translate(width / 2, height / 2);
  angleX = map(mouseY, 0, height, PI / 2, 0);
  angleZ = map(mouseX, 0, width, PI/2, -PI / 2);
  rotateX(angleX);
  rotateZ(angleZ);
  translate(-w/2, -h/2);

  for (int y = 0; y < rows - 1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      hue = map(terrain[x][y], -100, 100, 0, 255);
      stroke(hue, 255, 255);
      vertex(x * scl, y * scl, terrain[x][y]);
      vertex(x * scl, (y + 1) * scl, terrain[x][y+1]);
    }
    endShape();
  }
}
