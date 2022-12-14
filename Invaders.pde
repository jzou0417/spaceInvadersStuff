Invader[] InvaderStorage = new Invader[] {};


interface Invader {
 boolean getState();
 String getType();
 void show();
 void move();
 void shoot();
 void takeDamage(float damageTaken);
 
}

class InvaderGroup implements Invader {
  PVector pos,spacing;
  float speed, xDir;
  boolean alive = true;
  InvaderGrunt[][] InvadersInGroup;
  int furthestCell, cellSize = 0;
   

  InvaderGroup(PVector pos, float speed, int shotSpeed, float xDir, int invaderRows, int invaderColumns, int cellSize){
    InvadersInGroup = new InvaderGrunt[invaderRows][invaderColumns];

    this.pos = pos;
    this.speed = speed;
    this.xDir = xDir;
    this.spacing = new PVector(10,10);
    this.cellSize = cellSize;
    for(int row = 0; row < invaderRows; row++){
     for(int cell = 0; cell < invaderColumns;cell++){

       InvadersInGroup[row][cell] = new InvaderGrunt(shotSpeed,10,10,cellSize);
       furthestCell = max(furthestCell,cell); 
     }
    }
  }
  
  
  void show(){
    
  }
  void move(){
    
    for(int row = 0; row < InvadersInGroup.length; row++){
     for(int cell = 0; cell < InvadersInGroup[row].length;cell++){
       if(InvadersInGroup[row][cell] != null){
         furthestCell = max(furthestCell,cell); 
         InvadersInGroup[row][cell].update(new PVector(pos.x + (cellSize + spacing.x) * cell, pos.y + (cellSize + spacing.y) * row)); 
       }
     }
    }
    
    float rightBound = pos.x + (cellSize + spacing.x) * furthestCell + cellSize/2;
 

    if(frameCount % speed == 0){
      
      if((rightBound < width && xDir == 1) || (pos.x - cellSize/2.0 > 0 && xDir == -1)){
        pos.x += (cellSize + spacing.x) * xDir;
      } else {
        pos.y += 20 + spacing.y;
        xDir *= -1;
      }
       
       
    }
  }
  
  void shoot(){
    
  }
  
  void takeDamage(float damageTaken){
    
  }
  
  boolean getState(){
   return alive; 
  }
  
  String getType(){ //since processing doesnt let me return multiple datatypes in a method (and i dont want to make another object GRR!!)
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
   strToReturn += "]&d" + str(cellSize) + "," + str(spacing.x) + "," + str(spacing.y);
   return strToReturn;
  }
  
  InvaderGrunt[][] GetInvaderGroup(){
   return InvadersInGroup; 
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
   

  InvaderGrunt(int rs, float pSpeed, float pDamage,int size){
    this.rs = int(random(rs*0.75,rs*1.5));
    this.cd = int(random(0,this.rs));
    this.pSpeed = pSpeed;
    this.pDamage = pDamage;
    this.size = size;
  }

  
  void update(PVector pos){
    fill(255,255,255,255);
    circle(pos.x,pos.y,size);
    
    cd--;
    if(cd == 0){
      ProjectileStorage = (Projectile[]) append(ProjectileStorage,new Projectile(false,new PVector(pos.x,pos.y),pSize,new PVector(0,1),pDamage,pSpeed,"Rect",color(255,255,255,200)));
      cd = int(random(rs*0.75,rs*1.5));
    }
     
  }

  void takeDamage(float damageTaken){
    health -= damageTaken;
    if(health <= 0){
     alive = false; 
    }
  }
  
  
  
}
