
Invader[] InvaderStorage = new Invader[] {};


interface Invader {
 boolean getState();
 String getType();
 PVector getPos();
 
 void show();
 void move();
 void shoot();
 void takeDamage(float damageTaken, String type);
 
}

class InvaderGroup implements Invader {
  PVector pos,spacing;
  float speed, xDir;
  boolean alive = true;
  InvaderGrunt[][] InvadersInGroup;
  int furthestCell, cellSize = 0;
  int closestCell = 1000;
   

  InvaderGroup(PVector pos, float speed, int shotSpeed, int shotVelocity, int health, float xDir, int invaderRows, int invaderColumns, int cellSize){
    InvadersInGroup = new InvaderGrunt[invaderRows][invaderColumns];

    this.pos = pos;
    this.speed = speed;
    this.xDir = xDir;
    this.spacing = new PVector(10,10);
    this.cellSize = cellSize;
    for(int row = 0; row < invaderRows; row++){
     for(int cell = 0; cell < invaderColumns;cell++){

       InvadersInGroup[row][cell] = new InvaderGrunt(shotSpeed,shotVelocity,10,cellSize,health);
       furthestCell = max(furthestCell,cell); 
     }
    }
  }
  
  
  void show(){
    
  }
  void move(){
    alive = false;
    furthestCell = 0;
    closestCell = 1000;
    for(int row = 0; row < InvadersInGroup.length; row++){
     for(int cell = 0; cell < InvadersInGroup[row].length;cell++){
       if(InvadersInGroup[row][cell] != null){
         if(InvadersInGroup[row][cell].alive == false){
           InvadersInGroup[row][cell] = null; 
         } else {
           alive = true;
           furthestCell = max(furthestCell,cell); 
           closestCell = min(closestCell,cell);
           InvadersInGroup[row][cell].update(new PVector(pos.x + (cellSize + spacing.x) * cell, pos.y + (cellSize + spacing.y) * row)); 
         }
        
       }
      
     }
    }
    
    float rightBound = pos.x + (cellSize + spacing.x) * furthestCell + cellSize/2;
    float leftBound = pos.x + (cellSize + spacing.x) * closestCell - cellSize/2;

    if(frameCount % speed == 0){
      
      if((rightBound < width && xDir == 1) || (leftBound > 0 && xDir == -1)){
        pos.x += (cellSize + spacing.x) * xDir;
      } else {
        pos.y += 20 + spacing.y;
        xDir *= -1;
      }
       
       
    }
  }
  
  void shoot(){
    
  }
  
  void takeDamage(float damageTaken, String type){
    PVector invaderPos = new PVector(
    int(type.substring(1,type.indexOf(","))),
    int(type.substring(type.indexOf(",") + 1, type.indexOf("]")))
    );
    
    InvadersInGroup[int(invaderPos.x)][int(invaderPos.y)].takeDamage(damageTaken);
  }
  
  boolean getState(){
   return alive; 
  }
  
  String getType(){ //since processing doesnt let me return multiple datatypes in a method
   String strToReturn = "InvaderGroup[";
   for(int row = 0; row < InvadersInGroup.length; row++){
     for(int cell = 0; cell < InvadersInGroup[row].length;cell++){
       if(InvadersInGroup[row][cell] != null){
         strToReturn += "1";
       } else {
        strToReturn += "0"; 
       }
       strToReturn += ",";
     }
     strToReturn = strToReturn.substring(0,strToReturn.length()-1);
     strToReturn += "|";
    }
   strToReturn = strToReturn.substring(0,strToReturn.length()-1);
   strToReturn += "]&d&CS=" + str(cellSize) + "&SPx=" + str(spacing.x) + "&SPy=" + str(spacing.y) + "&end";
   return strToReturn;
  }
  
  PVector getPos(){
   return pos; 
  }
  
  
}


class InvaderGrunt {
  PVector pos;
  boolean alive = true;
  int health;
  
  //ProjectileData
  int cd,rs,size;
  PVector pSize = new PVector(3,10);
  float pSpeed = 10;
  float pDamage = 10;
   

  InvaderGrunt(int rs, float pSpeed, float pDamage,int size,int health){
    this.rs = int(random(rs*0.75,rs*1.5));
    this.cd = int(random(0,this.rs));
    this.pSpeed = pSpeed;
    this.pDamage = pDamage;
    this.size = size;
    this.health = health;
  }

  
  void update(PVector movePos){
    fill(255,255,255,255);
    this.pos = new PVector(movePos.x,movePos.y);
    circle(movePos.x,movePos.y,size);
    
    cd--;
    if(cd == 0){
      ProjectileStorage = (Projectile[]) append(ProjectileStorage,new Projectile(false,new PVector(movePos.x,movePos.y),pSize,new PVector(0,1),pDamage,pSpeed,"Rect",color(255,255,255,200),1));
      cd = int(random(rs*0.75,rs*1.5));
    }
     
  }

  void takeDamage(float damageTaken){
    health -= damageTaken;
    if(health <= 0){
     alive = false; 
     enemiesKilled++;
     ExplosionStorage = (ExplosionFX[]) append(ExplosionStorage,new ExplosionFX(pos,50,60));

    }
  }
  
  
  
}






class InvaderBeam implements Invader {
   PVector pos,dir;
   boolean alive = true;
   int health,wFrames;
   float speed;
    
   //ProjectileData
   int cd,rs,size;
   PVector pSize = new PVector(3,10);
   float pSpeed = 10;
   float pDamage = 10;
   

  InvaderBeam(PVector pos, float speed, int cd, int health, int wFrames, PVector dir, int size){
    this.pos = pos;
    this.speed = speed;
    this.dir = dir;
    this.health = health;
    this.wFrames = wFrames;
    this.cd = cd;
    this.rs = cd;
    this.size = size;
    
  }
  
  
  void show(){
    
  }
  void move(){
   
  }
  
  void shoot(){
    
  }
  
  void takeDamage(float damageTaken, String type){
 
    
  }
  
  boolean getState(){
   return alive; 
  }
  
  String getType(){
    return "InvaderBeam";
  }
  
  PVector getPos(){
   return pos; 
  }
  
  
}
