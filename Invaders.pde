interface Invader {
 void show();
 void move();
 void shoot();
 void takeDamage(float damageTaken);
  
}

class InvaderGroup implements Invader {
  PVector pos;
  float speed, xDir;
  InvaderGrunt[][] InvadersInGroup = new InvaderGrunt[][] {};
   

  InvaderGroup(PVector pos, float speed, float xDir, int invaderRows, int invaderColumns){
    this.pos = pos;
    this.speed = speed;
    this.xDir = xDir;
    for(int row = 0; row < invaderRows; row++){
     for(int column = 0; column < invaderColumns;column++){
       
     }
    }
  }
  
  
  
  
  void show(){
    
  }
  void move(){
    if(frameCount % 30 == 0){
       
    }
  }
  void shoot(){
    
  }
  
  void takeDamage(float damageTaken){
    //HOLDER: you don't need this
  }
  
}

class InvaderGrunt {
  PVector pos;
  
  
  //ProjectileData
  boolean canShootProjectile = false;
  int projectileCooldown,projectileReloadSpeed;
  PVector projectileSize = new PVector(3,10);
  float projectileSpeed = 10;
  float projectileDamage = 10;
   

  InvaderGrunt(PVector pos,int projectileReloadSpeed){
    this.pos = pos;
    this.projectileReloadSpeed = int(random(0,projectileReloadSpeed));
    this.projectileCooldown = projectileReloadSpeed;
    
  }
  
  
  
  
  void show(){
    
  }
  void move(){
   
  }
  void shoot(){
    
  }
  
  void takeDamage(float damageTaken){
    
  }
  
  
  
}
