int order = 5;
int N = int(pow(2, order));
int total = N * N;
int speed = 1;

PVector[] path = new PVector[total];

void setup(){
  frameRate(240);
  size(512,512);
  colorMode(HSB,360,255,255);
  background(0);
  
  for(int i = 0; i < total; i++){
    path[i] = hilbert(i);
    float len = width/N;
    path[i].mult(len);
    path[i].add(len/2, len/2);
  }
}

int counter = 0;

void draw(){
  //int counter = int(map(mouseX, 0, width, 0, path.length));
  
   background(0);
   
   stroke(255);
   noFill();
   
   beginShape();
   for(int i = 1; i <= counter; i++){
   //for(int i = 1; i < path.length; i++){
     float h = map(i,0,path.length,0,360);
     stroke(h, 255, 255);
     line(path[i].x, path[i].y, path[i-1].x, path[i-1].y);
   }
   endShape();
   

   
   if (counter + speed >= path.length){
     speed = 1;
   }
   
   counter += speed;

   if (counter >= path.length){
     print("Programm finished successfully! Start the programm again and play with the order and speed parameter :)");
     //save("HilbertCurve.jpg");
     noLoop();
   }
 
}

PVector hilbert(int i){
  PVector[] points = {
    new PVector(0,0),
    new PVector(0,1),
    new PVector(1,1),
    new PVector(1,0),
  };
  
  int index = i & 3;
  PVector v = points[index];
  
  for (int j = 1; j < order; j++){
    i = i >>> 2;
    index = i & 3;
    float len = pow(2,j);
    
    if (index == 0){
      float temp = v.x;
      v.x = v.y;
      v.y = temp;
    }else if (index == 1){
      v.y += len;
    }else if (index == 2){
      v.x += len;
      v.y += len;
    }else if (index == 3){
      float temp = len-1-v.x;
      v.x = len-1-v.y;
      v.y = temp;
      v.x += len;
    }
  }
  return v;

}
