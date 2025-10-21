class PowerUp {
  // Member Variables
  int x, y, w, speed;
  char type;
  color c1;
  //PImage r1;
  
  // Constructor
  PowerUp() {
    x = int(random(width));
    y = -100;
    w = 100;
    speed = 5;
    if(random(10)>6.6) {
      //r1 = loadImage("moon.png");
      type = 'H';
      c1 = color(20,255,22);
    } else if(random(10)>5) {
      //r1 = loadImage("rock01.png");
       type = 'T';
      c1 = color(234,33,22);
    } else {
      //r1 = loadImage("rock02.png");
       type = 'A';
      c1 = color(20,22,222);
    }
  }
  
  // Member Methods
  void display() {
    fill(c1);
    ellipse(x,y,w,w);
    fill(255);
    textSize(30);
    textAlign(CENTER);
    text(type,x,y);
    //imageMode(CENTER);
    //if(w<1){
    //  w = 10;
    //r1.resize(w, w);
   // image(r1,x,y,w,w);
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
  
    boolean intersect(Spaceship s) {
    float d = dist(x,y,s.x,s.y);
    if(d<50) {
      return true;
    } else {
      return false;
    }
  }
}
