// Garrett Nelson | 18 Sept 2025 | SpaceGame
Spaceship s1;
ArrayList<PowerUp> powups = new ArrayList<PowerUp>();
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<Star> stars = new ArrayList<Star>();
Timer rockTimer, puTimer;
int score, rocksPassed, level, rtime;
PImage start;
boolean play;
import processing.sound.*;
SoundFile blast;

void setup() {
  size(750, 750);
  rtime = 2000;
  background(22);
  s1 = new Spaceship();
  puTimer = new Timer(5000);
  puTimer.start();
  rockTimer = new Timer(rtime);
  rockTimer.start();
  score = 0;
  rocksPassed = 0;
  start = loadImage("start.png");
  level = 1;
  blast = new SoundFile(this, "laser.wav");
}

void draw() {
  background(22);
  if (!play) {
    startScreen ();
  } else {

    //Distributes powerup on timer
    if (puTimer.isFinished()) {
      powups.add(new PowerUp());
      puTimer.start();
    }

    //Display and moves all powerups
    for (int p = 0; p < powups.size(); p++) {
      PowerUp pu = powups.get(p);
      pu.display();
      pu.move();

      if (pu.intersect(s1)) {
        // Remove PowerUp
        powups.remove(pu);
        //Based on type, benefit player
        if (pu.type == 'H') {
          s1.health += 20;
        } else if (pu.type == 'T') {
          s1.turretCount +=1;
          if (s1.turretCount>5) {
            s1.turretCount = 5;
          }
        } else if (pu.type == 'A') {
          s1.laserCount += 100;
        }
      }
      if (pu.reachedBottom()==true) {
        powups.remove(pu);
        p--;
      }
    }
    // Adding stars
    stars.add(new Star());

    //Distributing Rocks on timer
    if (rockTimer.isFinished()) {
      rocks.add(new Rock());
      rockTimer.start();
    }

    //Display of Stars
    for (int s = 0; s < stars.size(); s++) {
      Star star = stars.get(s);
      star.display();
      star.move();
      if (star.reachedBottom()) {
        stars.remove(star);
      }
    }

    //Display of Rocks
    for (int i = 0; i < rocks.size(); i++) {
      Rock rock = rocks.get(i);
      rock.display();
      rock.move();

      if (s1.intersect(rock)) {
        rocks.remove(rock);
        score = score + 1;
        s1.health-= rock.w/10;
      }
      if (rock.reachedBottom()==true) {
        rocks.remove(rock);
        i--;
        rocksPassed++;
      }
    }

    //Display of Lasers
    for (int i = 0; i < lasers.size(); i++) {
      Laser laser = lasers.get(i);
      for (int j = 0; j<rocks.size(); j++) {
        Rock r = rocks.get(j);
        if (laser.intersect(r)) {
          // Reduce hit points on rock
          r.w = r.w -50;
          if (r.w< 50) {
            rocks.remove(r);
          }
          //Remove the laser
          lasers.remove(laser);
          // Do something to score
          score = score + 1;
          //Provide animate gif and explosion sound
        }
      }
      laser.display();
      laser.move();
      if (laser.reachedTop()) {
        lasers.remove(laser);
      }
      println(lasers.size());
    }

    s1.display();
    s1.move(mouseX, mouseY);

    //level advanced
    if (rocksPassed>10) {
      level++;
      rtime-=10;
    } else if (rocksPassed>20) {
      level++;
    }

    infoPanel();
    if (rocksPassed>10 || s1.health<0) {
      gameOver();
    }
  }
}


void mousePressed() {
  // laser.play();
  if (s1.turretCount == 1) {
    lasers.add(new Laser(s1.x, s1.y));
  } else if (s1.turretCount == 2) {
    lasers.add(new Laser(s1.x-10, s1.y));
    lasers.add(new Laser(s1.x+10, s1.y));
  } else if (s1.turretCount == 3) {
    lasers.add(new Laser(s1.x, s1.y));
    lasers.add(new Laser(s1.x-10, s1.y));
    lasers.add(new Laser(s1.x+10, s1.y));
  } else if (s1.turretCount == 4) {
    lasers.add(new Laser(s1.x-20, s1.y));
    lasers.add(new Laser(s1.x-10, s1.y));
    lasers.add(new Laser(s1.x+10, s1.y));
    lasers.add(new Laser(s1.x+20, s1.y));
  }
  if (s1.turretCount>4) {
    s1.turretCount=4;
  }
  if (blast.isPlaying()) {
    blast.stop();
    blast.play();
  } else
    blast.play();
  s1.laserCount--;
}

void infoPanel() {
  rectMode(CENTER);
  fill(127, 127);
  rect(width/2, 25, width, 50);
  fill(220);
  textSize(25);
  text("Score:" + score, 50, 40);
  text("Rocks Passed: " + rocksPassed, width-100, 40);
  text("Health: " + s1.health, width-250, 40);
  text("Ammo: " + s1.laserCount, 230, 40);
  text("Turrets: " + s1.turretCount, 350, 40);
  fill(255);
  if (s1.health<100) {
    rect(this.s1.x +75, this.s1.y, 15, 105);
  } else {
    rect(this.s1.x +75, this.s1.y, 15, s1.health+5);
  }
  fill(255, 0, 0);
  rect(this.s1.x +75, this.s1.y, 10, s1.health);
  fill(255);
  text("Level:" + level, width -700, height -50 );
}

void gameOver () {
  background(0);
  fill(255);
  textAlign(CENTER);
  text("I make you go boom L", width/2, height/2);
}

void startScreen () {
  imageMode(CENTER);
  image(start, height/2, width/2);
  text("Press enter", width/2, height/2);
  if (keyPressed) {
    if (key == ENTER) {
      play = true;
    }
  }
}
