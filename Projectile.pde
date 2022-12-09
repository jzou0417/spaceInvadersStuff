ArrayList<Projectile> ProjectileStorage = new ArrayList<Projectile>();



class Projectile {
  PVector pos,size,dir;
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
  }
  
  void display(){
    fill(projColor);
    pushMatrix();
    translate(pos.x,pos.y);
    //TODO: rotate da projecitle, use tan/atan?
    switch(projType){
     case "Rect":
       rect(-size.x/2,-size.y/2,size.x,size.y);
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
      
    } else {
      
    }
    
  }
}
