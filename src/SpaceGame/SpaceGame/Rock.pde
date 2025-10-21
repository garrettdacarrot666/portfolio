class Rock{
  // Member Variables
  int x, y, w, speed;
  PImage r1;
  
  // Constructor
  Rock() {
    x = int(random(width));
    y = -100;
    w = int(random(50,300));
    speed = int(random(1,10) + score/4);
    if(random(100)>99) {
      r1 = loadImage("moon.png");
    } else if(random(10)>5) {
      r1 = loadImage("rock01.png");
    } else {
      r1 = loadImage("rock02.png");
    }
  }
  
  // Member Methods
  void display() {
    imageMode(CENTER);
    if(w<1){
      w = 10;
    }
    //r1.resize(w, w);
    image(r1,x,y,w,w);
  }
  
  void move() {
    y = y + speed;
  }
  
  boolean reachedBottom() {
    if(y>height+w) {
      return true;
    }else {
      return false;
    }
  }
  
  
}
