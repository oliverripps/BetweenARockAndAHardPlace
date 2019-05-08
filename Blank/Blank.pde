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
  float angle;
  float radius;
  LivingRock(float x, float y) {
    super(x, y);
    state=0;
    iniX=x;
    iniY=y;
    maxX=random(width);
    maxY=random(height);
    angle=random(2*PI);
    radius=random(5,30);
  }
  void move() {
    if(state==0){
      x=iniX+10*sin(3*angle+PI/2);
      y=iniY+10*cos(2*angle);
      angle+=(0.1);
    }
    else if(state==1){
      x+=(maxX-x)/100;
      y+=(maxY-y)/100;
      if(abs(maxX-x)<2*rock.width&&abs(maxY-y)<2*rock.height){
        state=3;
      }
    }
    else if(state==2){
      x+=radius*cos(angle);
      y+=radius*sin(angle);
      angle+=(0.1);
    }
    else if(state==3){
      x+=(iniX-x)/100;
      y+=(iniY-y)/100;
      if(abs(iniX-x)<2*rock.width&&abs(iniY-y)<2*rock.height){
        state=1;
      }
    }
    if(this.x>=width-rock.width){
      this.x=width-rock.width;
    }
    if(this.x<=0){
      this.x=0; 
    }
    if(this.y>=height-rock.height){
      this.y=height-rock.height;
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
    PImage img;
    img = loadImage("soccerball.jpeg");
    image(img, x, y,50,50);
  }

  void move() {
    x+=10;
    y+=10;
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);
  PImage img;
  img = loadImage("soccerball.jpeg");
  //image(img, 0, 0);
  ///image(img, 0,0, width/2, height/2);
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
