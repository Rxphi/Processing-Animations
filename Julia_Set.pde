void setup(){
  print("Drag around your mouse on to change the constant imaginary variable of the Julia Set :)");
  size(640, 480);
  colorMode(HSB, 1);
}

void draw(){
  
  float ca = map(mouseX, 0, width, -1, 1);
  float cb = map(mouseY, 0, height, -1, 1);
  
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
  
  //int maxiterations = int(map(mouseX, 0, width, 0, 200));
  int maxiterations = 100;
  
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
        
        if (aa + bb > 4.0){
          break;
        }
        
        float twoab = 2.0 * a * b;

        a = aa - bb + ca;
        b = twoab + cb;
        
        
         
        iteration++;   
      }
      
      if (iteration == maxiterations){
        pixels[i+j*width] = color(0);
      } else{
        float hue = sqrt((float(iteration) / float(maxiterations)));
        pixels[i+j*width] = color(hue, 255, 255);
      }
      
      x += dx;
    }
    
    y += dy;
    
  }
  print("FPS: ");
  print(frameRate);
  print("\n");
  updatePixels();
}
