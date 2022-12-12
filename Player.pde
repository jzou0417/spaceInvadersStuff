class Player {
 PVector pos;
 int size,animationFrame;
 float speed;
 
 //ProjectileData
 boolean canShootProjectile = true;
 int projectileCooldown = 0;
 int projectileReloadSpeed = 100;
 PVector projectileSize = new PVector(3,10);
 float projectileSpeed = 10;
 float projectileDamage = 10;
 
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
   
   projectileCooldown = max(0,projectileCooldown - 1);
   if(projectileCooldown == 0){
    canShootProjectile = true; 
   }
 }
 
 void shoot(String type){
   switch(type){
    case "Projectile":
      
      ProjectileStorage = (Projectile[]) append(ProjectileStorage,new Projectile(true,new PVector(pos.x,pos.y),projectileSize,new PVector(0,-10),projectileDamage,projectileSpeed,"Rect",color(255,200,200,200)));
      canShootProjectile = false;
      projectileCooldown = projectileReloadSpeed;
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
  println(pos.x);
 }
  
}
