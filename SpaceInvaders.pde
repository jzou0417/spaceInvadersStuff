boolean AHeld,DHeld,spaceHeld = false;
int score = 0;
Player curPlr;
void setup(){
 size(500,800); 
 frameRate(60);
 curPlr = new Player(new PVector(width/2,height - 80),5,20);
  for(int i = 0; i < STAR_COUNT; i++){
     StarStorage = (Star[]) append(StarStorage,new Star());
  }
}

void draw(){
 background(0);
 //background stuf
 for(int i = 0; i < StarStorage.length; i++){
   if(StarStorage[i] != null){
     Star curStar = StarStorage[i];
      curStar.display(); 
      if(curStar.yPos - curStar.size > height){
       StarStorage[i] = null; 
       StarStorage = (Star[]) append(StarStorage,new Star(-curStar.size));
    
      }
   }
  
 }
 
 fill(255);
  rect(50,50,width-100, 100);
 for(int i = 0; i < ProjectileStorage.length; i++){
   ProjectileStorage[i].move(); 
   ProjectileStorage[i].checkCollisions(); 
   ProjectileStorage[i].display(); 
 }

 
 

 curPlr.display();
 curPlr.move();
 if(curPlr.canShootProjectile == true && spaceHeld == true){
  curPlr.shoot("Projectile"); 
 }
 updateInfoBar();
}


void updateInfoBar(){
  
  //Laser
  textSize(10);
  textAlign(RIGHT);
  text("LASER",width-3,height-5);
  textAlign(LEFT);
  textSize(15);
  text("∞",width-47,height-3);
  makeBorders(width-50,height - 50,50,50,10,color(255,255,255)); 
  noStroke();

  fill(200,255,200,50);
  rect(width-50,height-50,lerp(0,50,float(curPlr.projectileCooldown)/curPlr.projectileReloadSpeed),50);

  fill(255,200,200,150);
  pushMatrix();
  translate(width-18,height-42);
  rotate(radians(45));
  rect(0,0,3,25);
  rect(-5,0,3,25);
  rect(5,0,3,25);
  popMatrix();
  
  textAlign(LEFT);
  fill(255);
  text("SCORE: " + score,25,height-25);
}



void keyPressed(){
    
  if(keyCode == 65){ //A
    AHeld = true;
  } else if(keyCode == 68){ //D
    DHeld = true;
  } else if(keyCode == 32){ //Space
    spaceHeld = true;
  }
  
}

void keyReleased(){
    
  if(keyCode == 65){ //A
    AHeld = false;
  } else if(keyCode == 68){ //D
    DHeld = false;
  } else if(keyCode == 32){ //Space
    spaceHeld = false;
  }
  
}