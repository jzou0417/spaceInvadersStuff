class Projectile {
  PVector pos,size,dir;
  float damage,speed;
  color projColor;
  String projType;
  Projectile(PVector pos, PVector size, PVector dir){
    this.pos = pos;
    this.size = size;
    this.dir = dir;
    this.dir.normalize(); //unit
  }
  
  void display(){
    pushMatrix();
    translate(pos.x,pos.y);
    //TODO: rotate da projecitle, use tan/atan?
    switch(projType){
     case "Rect":
       break;
     case "Ellipse":
       break;
    }
    popMatrix();
  }
  
  void move(){
    pos.add(new PVector(dir.x * speed, dir.y * speed));
  }
  
  void checkCollisions(){
    
  }
}
