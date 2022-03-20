float w = 4;
float h;
int maxiterations = 50;

void setup(){
  size(1000, 800);
  colorMode(HSB);
  h = w * height/ width;
}

void draw(){
  
  loadPixels();
  
  ArrayList<PVector> points = new ArrayList<PVector>();
  float mouseA = map(mouseX, 0, width, -w/2, w/2);
  float mouseB = map(mouseY, 0, height, -h/2, h/2);
  
  //draw the mandelbrot set
  for (int i = 0; i < height; i++){
    for (int j = 0; j < width; j++){

      int iteration = 0;
      
      float ca = map(j, 0, width, -w/2, w/2);
      float cb = map(i, 0, height, -h/2, h/2);
      
      float a = ca;
      float b = cb;
      
      boolean addPoints = (mouseA == a) & (mouseB == b);
      
      while (iteration < maxiterations){
        if (addPoints){
          points.add(new PVector(map(a, -w/2, w/2, 0, width), map(b, -h/2, h/2, 0, height)));
        }
        
        float aa = a * a;
        float bb = b * b;
        float twoab = 2 * a * b;
        
        a = aa - bb + ca;
        b = twoab + cb;
        
        if (aa + bb > 16){
          break;
        }
        
        iteration++;
      }
      
      if (iteration == maxiterations){
        pixels[i * width + j] = color(0, 0, 0);
      }else{
        pixels[i * width + j] = color(map(iteration, 0, maxiterations, 0, 255), 255, 255);
      }
    }
  }
  
  updatePixels();
  
  //draw the iteration of the point at the mouse position
  int hue = 0;
  for (int x = 0; x < points.size() - 2; x++){
    PVector p1 = points.get(x);
    PVector p2 = points.get(x+1);
    stroke(hue, 255, 255);
    strokeWeight(1);
    line(p1.x, p1.y, p2.x, p2.y);
    hue += 30;
    if (hue > 255){
      hue = 0;
    }
    
  }
}
