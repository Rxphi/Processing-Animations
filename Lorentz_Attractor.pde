import peasy.*;


PeasyCam cam;

float x = 0.01;
float y = 0;
float z = 0;

float sigma = 10;
float rho = 28;
float beta = 8/3;

float dt = 0.01;

int scl = 4;

ArrayList<PVector> points = new ArrayList<PVector>();



void setup(){
  println("Click and drag the screen to change the field of view to find the figure. To zoom a bit, roll your mouse wheel.");
  println("Open the programm to change the variables sigma, rho and beta to change the parameters of the differential equation behind the lorentz attractor.\nLG Raphaël Larisch :)");
  size(640, 400, P3D);
  colorMode(HSB);
  cam = new PeasyCam(this, 0, 0, 0, 20);
  noFill();
}  

float dx, dy, dz;

void draw(){
  background(0);
  translate(width/2, height/2);
  scale(scl);
  stroke(255);
  
  points.add(new PVector(x, y, z));
  
  // calculate new point
  dx = sigma * (y - x) * dt;
  dy = (x * (rho - z) - y) * dt;
  dz = (x * y - beta * z) * dt;
  
  x += dx;
  y += dy;
  z += dz;
  
  // draw the shape
  float hue = 0;
  beginShape();
  for (PVector v1 : points){
    
    stroke(hue, 255, 255);
    vertex(v1.x, v1.y, v1.z);
    //vertex(v2.x, v2.y, v2.z);
    hue += 0.1;
    if (hue > 255){
      hue = 0;
    }
  }
  endShape();
}
