class Minion{
  float x;
  float y;
  PImage img;
  float easing;
  Minion(float xCoord, float yCoord, PImage i){
    x = xCoord;
    y = yCoord;
    img = i;
    easing = 0.005;
  }
  void update(){
    x = (1-easing) * x + easing * (width/2);
    y = (1-easing) * y + easing * (height/2);
  }
}