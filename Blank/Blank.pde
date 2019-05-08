PImage rock;

interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
}

class Rock extends Thing {
  Rock(float x, float y) {
    super(x, y);
  }

  void display() {
    image(rock, x, y);
  }
}

public class LivingRock extends Rock implements Moveable {
  int state;
  float iniX;
  float iniY;
  float maxX;
  float maxY;
  LivingRock(float x, float y) {
    super(x, y);
    state=(int)random(2);
    iniX=x;
    iniY=y;
    maxX=random(width);
    maxY=random(height);
  }
  void move() {
    if(state==0){
      x+=random(-10,10);
      y+=random(-10,10);
    }
    else if(state==1){
      x+=(maxX-x)/100;
      y+=(maxY-y)/100;
      
    }
    
    
    if(this.x>=width-20){
      this.x=width-20;
    }
    if(this.x<=0){
      this.x=0; 
    }
    if(this.y>=height-20){
      this.y=height-20;
    }
    if(this.y<=0){
      this.y=0; 
    }
  }
}

class Ball extends Thing implements Moveable {
  Ball(float x, float y) {

    super(x, y);
  }

  void display() {
    int x = 500;
    int y = 200;
    ellipse(x, y, 100, 100);
    ellipse(x-20, y-10, 30, 30);
    ellipse(x+20, y-10, 30, 30);
    
    
  }

  void move() {
    /* ONE PERSON WRITE THIS */
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);
  PImage img;
  img = loadImage("soccerball.jpeg");
  image(img, 0, 0);
  image(img, 0,0, width/2, height/2);
  rock = loadImage("Rockin.jpeg");
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(m);
    thingsToMove.add(m);
  }
}
void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
}
