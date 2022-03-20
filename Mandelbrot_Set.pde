

void setup(){
  println("Drag around your mouse on the x-axis to change the maxiterations variable and on the y-axis to add some red :)");
  size(640, 480);
  colorMode(RGB, 1);
}

void draw(){
  background(255);
  
  float w = 5;
  float h = (w * height) / width;
  
  float xmin = -w/2;
  float ymin = -h/2;
  float xmax = xmin + w;
  float ymax = ymin + h;
  float dx = (xmax - xmin) / (width);
  float dy = (ymax - ymin) / (height);
  
  loadPixels();
  
  int maxiterations = int(map(mouseX, 0, width, 0, 200));
  
  float y = ymin;
  for (int j = 0; j < height; j++){
    float x = xmin;
    for (int i = 0; i < width; i++){
      
      float a = x;
      float b = y;
      
      int iteration = 0;
      
      while (iteration < maxiterations){
        float aa = a * a;
        float bb = b * b;
        float twoab = 2.0 * a * b;

        
        a = aa - bb + x;
        b = twoab + y;
        
        if (aa + bb > 16.0){
          break;
        }
         
        iteration++;   
      }
      
      if (iteration == maxiterations){
        pixels[i+j*width] = color(0);
      } else{
        float rgb_r = map(mouseY, 0, height, 0, 1);
        float rgb_g = sqrt((float(iteration) / float(maxiterations)));
        float rgb_b = 0;//map(mouseY, 0, height, 0, 1);
        pixels[i+j*width] = color(rgb_r, rgb_g, rgb_b);
      }
      
      x += dx;
    }
    
    y += dy;
    
  }
  updatePixels();
}
