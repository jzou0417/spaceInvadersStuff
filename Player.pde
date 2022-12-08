class Player {
 PVector pos;
 int size,animationFrame;
 float speed;
 Player(PVector pos,float speed,int size){
   this.pos = pos;
   this.speed = speed;
   this.size = size;
 }
  
 void display(){
   fill(255);
   circle(pos.x,pos.y,size);
 }
 
 void move(){
  if(AHeld){
    pos.x -= speed;
  }
  if(DHeld){
    pos.x += speed;
  }
 }
  
}
