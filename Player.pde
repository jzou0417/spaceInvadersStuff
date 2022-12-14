class Player {
 PVector pos;
 int size,animationFrame;
 float speed;
 
  //ProjectileData
  boolean canShoot = false;
  int cd,rs = 100;
  PVector pSize = new PVector(3,10);
  float pSpeed = 10;
  float pDamage = 10;
 
 Player(PVector pos,float speed,int size){
   this.pos = pos;
   this.speed = speed;
   this.size = size;
 }
  
 void display(){
   fill(255);
   circle(pos.x,pos.y,size);
   circle(pos.x - width,pos.y,size);
   circle(pos.x + width,pos.y,size);
   
   cd = max(0,cd - 1);
   if(cd == 0){
    canShoot = true; 
   }
 }
 
 void shoot(String type){
   switch(type){
    case "Projectile":
      
      ProjectileStorage = (Projectile[]) append(ProjectileStorage,new Projectile(true,new PVector(pos.x,pos.y),pSize,new PVector(0,-1),pDamage,pSpeed,"Rect",color(255,200,200,200)));
      canShoot = false;
      cd = rs;
      break;
     
   }
 }
 
 void move(){
  if(AHeld){
    pos.x -= speed;
  }
  if(DHeld){
    pos.x += speed;
  }
  if(pos.x < 0){
    pos.x = width;
  } else if(pos.x > width){
   pos.x = 0; 
  }
 }
  
}
