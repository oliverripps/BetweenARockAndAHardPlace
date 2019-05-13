
interface Displayable {
  void display();
}  

interface Moveable {
  void move();
}

interface Collideable{
  boolean isTouching(Thing other);
}
  
abstract class Thing implements Displayable, Collideable {
  float x, y;//Position of the Thing

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
  
  boolean isTouching(Thing other) {
    return other.y <= (this.y + 30) && other.y >= (this.y - 30) && other.x <= (this.x + 30) && other.x >= (this.x - 30);
  }

}

class Rock extends Thing {
  PImage rock;
  Rock(float x, float y) {
    super(x, y);
  }

  void display() {
    rock = loadImage("Rockin.jpeg");
    noTint();
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
  boolean tinted;
  
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
  
  PImage sballPic;
  
  SoccerBall(float x, float y, PImage bb) {
    super(x, y);
    iniX=x;
    iniY=y;
    xvector=random(30)-15;
    yvector=random(30)-15;
    sballPic = bb;
    
    tinted = false;
    
  }
  void display() {
      if (tinted) { 
      tint(250, 0, 0);   
    } else {
      noTint();
    }

    image(sballPic, x, y,50,50);
    square(x,y,10);
    square(x + 40,y,10);
    square(x,y + 40,10);
    square(x + 40,y + 40,10);
    
    tinted = false;
  }
  void move(){
    x+=xvector;
    y+=yvector;
    delay(1);
   if(y>height-50){
      yvector*=-1;
      //yvector+=(random(80)-40);
      xvector+=(random(15)-5);
   }
    if(x>width-50){
      xvector*=-1;
      //xvector+=(random(80)-40);
      yvector+=(random(15)-5);
    }
    if(y<0){
      yvector*=-1;
      //yvector+=(random(80)-40);
      xvector+=(random(15)-5);
    }
    if(x<0){
      xvector*=-1;
      //xvector+=(random(80)-40);
      yvector+=(random(15)-5);
    }
    
    for( Collideable c : thingsToCollide) {
       if (this !=c && c.isTouching(this)){
          this.tinted = true;
        }
    }
    
  }
}


class BasketBall extends Ball {
  PImage bballPic;
  float angle;
  float radius;
  float iniX;
  float iniY;
  float maxX;
  float maxY;

   BasketBall(float x, float y, PImage bb) {
    super(x, y);
    iniX=x;
    iniY=y;
    angle=random(2*PI);
    radius=random(5,30);
    maxX=random(width);
    maxY=random(height);
    bballPic = bb;
    
    tinted = false;

  }
  void display() {
    
    if (tinted) {
      
      tint(250, 0, 0);
      
    } else {
      noTint();
      
    }
    
    image(bballPic, x, y,50,50);
    circle(x,y,10.0);
    circle(x + 50,y,10.0);
    circle(x,y + 50,10.0);
    circle(x + 50,y + 50,10.0);
    
    tinted = false;
  }
  void move(){
    delay(1);
    
    x=iniX+100*sin(1*angle+PI/3);
    y=iniY+100*sin(2*angle);
    angle+=(0.1);
    if(y>height){
      if(angle>180){
        angle-=180;
      }
      else{
        angle+=180;
    }
    }
    if(x>width-20){
      if(angle>180){
        angle-=180;
      }
      else{
        angle+=180;
    }
    }
    if(y<0){
      if(angle>180){
        angle-=180;
      }
      else{
        angle+=180;
    }
    }
    if(x<0){
      if(angle>180){
        angle-=180;
      }
      else{
        angle+=180;
    }
    }
    
    for( Collideable c : thingsToCollide) {
       if (this !=c && c.isTouching(this)){
          this.tinted = true;
        }
    }
 

  }
}


/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> thingsToCollide;

void setup() {
  size(1000, 800);
  
  PImage sballPic = loadImage("soccerball.jpeg");
  PImage bballPic = loadImage("basketball.png");


  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  thingsToCollide = new ArrayList<Collideable>();

  for (int i = 0; i < 10; i++) {
    SoccerBall b = new SoccerBall(50+random(width-100), 50+random(height-100), sballPic);
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    thingsToCollide.add(b);
    BasketBall a = new BasketBall(50+random(width-100), 50+random(height-100), bballPic);
    thingsToDisplay.add(a);
    thingsToMove.add(a);
    thingsToCollide.add(a);
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
