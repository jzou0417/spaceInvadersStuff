ArrayList<Star> StarStorage = new ArrayList<Star>();
int STAR_COUNT = 40;

class Star {
 int xPos,yPos,size;

 Star(){
  xPos = int(random(0,width));
  yPos = int(random(0,height));
  size = int(random(2,5));
 }
  
 void display(){
  fill(255);
  circle(xPos,yPos,size);
 }
  
  
}
