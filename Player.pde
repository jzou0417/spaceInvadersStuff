class Player {
 PVector pos,moveDir;
 int size,animationFrame;
 float speed;
 
  //ProjectileData
  boolean canShoot = false;
  int cd,rs = 20;
  PVector pSize = new PVector(3,10);
  int pierce = 1;
  float pSpeed = 10;
  float pDamage = 30;
 
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
      
      ProjectileStorage = (Projectile[]) append(ProjectileStorage,new Projectile(
      true                        //friendly/enemy projectile, don't touch
      ,new PVector(pos.x,pos.y)   //shot pos, don't touch
      ,pSize                      //shot size
      ,new PVector(0,-1)          //shot dir
      ,pDamage                    //shot damage
      ,pSpeed                     //shot speed
      ,"Rect"                     //shot type (circle or rect)
      ,color(255,200,200,200)     //shot color
      ,pierce                     //shot pierce
      ));
      canShoot = false;
      cd = rs;
      break;
     
   }
 }
 
 void move(){
   moveDir = new PVector(0,0);
  if(AHeld){
    moveDir.x -= 1;
  }
  if(DHeld){
    moveDir.x += 1;
  }
  if(WHeld){
   moveDir.y -= 1;
  }
  if(SHeld){
   moveDir.y += 1;
  }
  
  moveDir.normalize();
  pos.add(new PVector(moveDir.x * speed, moveDir.y * speed));
  
  pos.y = max(min(pos.y,height-100),height/2);
  if(pos.x < 0){
    pos.x = width;
  } else if(pos.x > width){
   pos.x = 0; 
  }
 }
  
}
