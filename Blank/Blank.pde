
interface Displayable {
  void display();
}  

interface Moveable {
  void move();
}
interface Hittable{
  boolean isTouching(Thing other);
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
  PImage rock;
  Rock(float x, float y) {
    super(x, y);
  }

  void display() {
    rock = loadImage("Rockin.jpeg");
    image(rock, x, y);
  }
  boolean hashit(Thing o) {
    return x == o.x && y == o.y;
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
    state=(int)random(3);
    iniX=x;
    iniY=y;
    maxX=random(width);
    maxY=random(height);
    angle=random(2*PI);
    radius=random(5,30);
  }
  void move() {
    if(state==0){
      x=iniX+100*sin(1*angle+PI/2);
      y=iniY+100*sin(2*angle);
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
  PImage img;
  float iniX;
  float iniY;
  float xvector;
  float yvector;
  
  Ball(float x, float y) {
    super(x, y);
    iniX=x;
    iniY=y;
    xvector=random(30)-15;
    yvector=random(30)-15;
  }
boolean istouching(Thing rock){
    return this.x == rock.x && this.y == rock.y;
  }
 void move(){
 }
 void display(){
 }
}

class SoccerBall extends Ball {
  SoccerBall(float x, float y) {
    super(x, y);
    iniX=x;
    iniY=y;
    xvector=random(30)-15;
    yvector=random(30)-15;
  }
  void display() {
    img = loadImage("soccerball.jpeg");
    image(img, x, y,50,50);
  }
  void move(){
    x+=xvector;
    y+=yvector;
    delay(1);
   if(y>height-70){
      yvector*=-1;
      yvector+=(random(80)-40);
      xvector+=(random(10)-5);
   }
    if(x>width-70){
      xvector*=-1;
      xvector+=(random(80)-40);
      yvector+=(random(10)-5);
    }
    if(y<0){
      yvector*=-1;
      yvector+=(random(80)-40);
      xvector+=(random(10)-5);
    }
    if(x<0){
      xvector*=-1;
      xvector+=(random(80)-40);
      yvector+=(random(10)-5);
    }
    
  }
}



/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    SoccerBall b = new SoccerBall(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    //BasketBall a = new BasketBall(50+random(width-100), 50+random(height-100));
    //thingsToDisplay.add(a);
    //thingsToMove.add(a);
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
