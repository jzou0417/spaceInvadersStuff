Projectile[] ProjectileStorage = new Projectile[] {};



class Projectile {
  PVector pos,size,dir,offset;
  float damage,speed;
  color projColor;
  String projType;
  boolean friendly;
  Projectile(boolean friendly,PVector pos, PVector size, PVector dir, float damage, float speed, String projType,color projColor){
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
           println(invader.getType());
           int[][] invaderArray = interpretFromStringToArray(invader.getType().substring(12,invader.getType().indexOf("&d")));
           for(int ii=0;ii<invaderArray.length;ii++){
             String invaderRow="";
             for(int iii=0;iii<invaderArray[ii].length;iii++){
               invaderRow+=str(invaderArray[ii][iii]);
             }
             println(invaderRow);
           }
           
          // println(invader.getType());
          /* InvaderGrunt[][] InvadersInGroup = invader.InvadersInGroup;
           for(int row = 0; row < InvadersInGroup.length; row++){
             for(int cell = 0; cell < InvadersInGroup[row].length;cell++){
               if(InvadersInGroup[row][cell] != null){
                 //hitreg stuff
               }
             }
           }*/
         } else {
           
         }
        }
      }
      
      
    } else {
      if(RectRectCollision(new PVector(pos.x + offset.x,pos.y + offset.y),size,curPlr.pos,new PVector(curPlr.size,curPlr.size)) == true){
        fill(255,255,0);
        rect(50,50,width-100, 100);
      }
    }

  }
}
