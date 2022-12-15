Projectile[] ProjectileStorage = new Projectile[] {};



class Projectile {
  PVector pos,size,dir,offset;
  float damage,speed;
  color projColor;
  String projType;
  boolean friendly;
  boolean canHit = true;
  int pierce;
  Projectile(boolean friendly,PVector pos, PVector size, PVector dir, float damage, float speed, String projType,color projColor,int pierce){
    this.friendly = friendly;
    this.pos = pos;
    this.size = size;
    this.dir = dir;
    this.dir.normalize(); //unit
    this.damage = damage;
    this.speed = speed;
    this.projType = projType;
    this.projColor = projColor;
    this.offset = new PVector(-size.x/2, -size.y/2);
    this.pierce = pierce;
  }
  
  void display(){
    fill(projColor);
    pushMatrix();
    translate(pos.x,pos.y);
    //TODO: rotate da projecitle, use tan/atan?
    switch(projType){
     case "Rect":
       rect(offset.x,offset.y,size.x,size.y);
       break;
     case "Ellipse":
       ellipse(pos.x,pos.y,size.x,size.y);
       break;
    }
    popMatrix();
  }
  
  void move(){
    pos.add(new PVector(dir.x * speed, dir.y * speed));
    
  }
  
  void checkCollisions(){
    if(friendly == true){
      for(int i = 0; i < InvaderStorage.length;i++){
        if(InvaderStorage[i] != null){
         Invader invader = InvaderStorage[i];

         if(invader.getType().substring(0,12).equals("InvaderGroup")){
           int[][] invaderArray = interpretFromStringToArray(invader.getType().substring(12,invader.getType().indexOf("&d")));
           String invaderStats = invader.getType().substring(invader.getType().indexOf("&d") + 2);
           int cellSize = int(invaderStats.substring(invaderStats.indexOf("&CS=")+4,invaderStats.indexOf("&SPx=")));
           PVector cellSpacing = new PVector(
           int(invaderStats.substring(invaderStats.indexOf("&SPx=")+5,invaderStats.indexOf("&SPy="))),
           int(invaderStats.substring(invaderStats.indexOf("&SPy=")+5,invaderStats.indexOf("&end"))));

            for(int row = 0; row < invaderArray.length; row++){
             for(int cell = 0; cell < invaderArray[row].length;cell++){
               if(invaderArray[row][cell] != 0){
                   PVector hitboxVector = new PVector(invader.getPos().x + (cellSize + cellSpacing.x) * cell - cellSize/2, invader.getPos().y + (cellSize + cellSpacing.y) * row  - cellSize/2);
                   if(RectRectCollision(hitboxVector,new PVector(cellSize,cellSize),new PVector(pos.x + offset.x,pos.y + offset.y),size) == true){
                     if(pierce > 0){
                        pierce--;
                        invader.takeDamage(damage,"[" + str(row) + "," + str(cell) + "]");
                     }
                   }
               }
              }
            }
            
    
         
         } else {
           
         }
        }
      }
      
      
    } else {
      if(RectRectCollision(new PVector(pos.x + offset.x,pos.y + offset.y),size,new PVector(curPlr.pos.x - curPlr.size/2, curPlr.pos.y - curPlr.size/2),new PVector(curPlr.size,curPlr.size)) == true){
        fill(255,255,0);
        rect(50,50,width-100, 100);
      }
    }

  }
}
