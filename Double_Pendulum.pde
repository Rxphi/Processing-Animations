//gravity
float g = 1;
//radiuses
float r1, r2;
//masses
float m1 = random(10, 100);
float m2 = random(10, 100);
//angles
float a1 = random(0, 2*PI);
float a2 = random(0, 2*PI);
//velocity of the angles
float da1 = 0;
float da2 = 0;
//acceleration of the angles
float dda1 = 0;
float dda2 = 0;

//position of static point
int px, py;
//position of end of pendulum
float prevx, prevy;


PGraphics canvas;

void setup() {
  println("Press ENTER to save the frame you are seeing");
  size(900, 900);
  colorMode(HSB);
  px = width/2;
  py = height/2;
  r1 = random(0, height/2);
  r2 = height/2 - r2;
  canvas = createGraphics(width, height);
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
  
}

float hue = 0;

void draw() {
  
  g = map(mouseY, 0, height, 0, 5);
  
  if (keyPressed){
    if (key == ENTER){
      println("KEY PRESSED");      
      save(str(year())+"."+str(month())+"."+str(day())+"."+str(minute())+"."+str(second())+".png");
    }
  }
  //calculate new acceleration of the angles
  float num1 = -g * (2 * m1 + m2) * sin(a1);
  float num2 = -m2 * g * sin(a1-2*a2);
  float num3 = -2*sin(a1-a2)*m2;
  float num4 = da2*da2*r2+da1*da1*r1*cos(a1-a2);
  float den = r1 * (2*m1+m2-m2*cos(2*a1-2*a2));
  dda1 = (num1 + num2 + num3*num4) / den;

  num1 = 2 * sin(a1-a2);
  num2 = (da1*da1*r1*(m1+m2));
  num3 = g * (m1 + m2) * cos(a1);
  num4 = da2*da2*r2*m2*cos(a1-a2);
  den = r2 * (2*m1+m2-m2*cos(2*a1-2*a2));
  dda2 = (num1*(num2+num3+num4)) / den;

  


  image(canvas, 0, 0);
  stroke(0);
  strokeWeight(2);

  translate(px, py);

  float x1 = r1 * sin(a1);
  float y1 = r1 * cos(a1);

  float x2 = x1 + r2 * sin(a2);
  float y2 = y1 + r2 * cos(a2);

  line(0, 0, x1, y1);
  fill(0);
  ellipse(x1, y1, m1, m1);

  line(x1, y1, x2, y2);
  ellipse(x2, y2, m2, m2);
  
  //add acceleration to velocity
  da1 += dda1;
  da2 += dda2;
  //add velocity to position
  a1 += da1;
  a2 += da2;
  
  //add drag
  //da1 *= 0.999;
  //da2 *= 0.999;

  //draw the trace line on the canvas
  
  //hue += 1;
  //if (hue > 255){
  //  hue = 0;
  //}
  //canvas.stroke(color(hue,255,255));
  hue = map(x2+y2, 0, width+height, 0, 255);
  
  canvas.beginDraw();
  canvas.translate(px, py);
  
  canvas.stroke(color(hue, 255, 255));
  
  if (frameCount > 1){
    canvas.line(prevx, prevy, x2, y2);
  }
  
  canvas.endDraw();
  
  prevx = x2;
  prevy = y2;
}
