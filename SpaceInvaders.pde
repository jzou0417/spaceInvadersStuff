

boolean AHeld,DHeld,WHeld,SHeld,spaceHeld = false;
int score = 0;
int PLR_HEALTHMAX = 50;
int loseFrame = -1;
String gameState = "Game"; //"Menu", "Game", "Lose"

Player curPlr;
void setup(){
 size(500,800); 
 frameRate(60);
 
  
 resetGame();


}

void draw(){
  switch(gameState){
    case "Game":
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
      
       for(int i = 0; i < ProjectileStorage.length; i++){
         if(ProjectileStorage[i] != null){
           Projectile proj = ProjectileStorage[i];
           if(proj.pierce > 0){
             proj.move(); 
             proj.checkCollisions(); 
             proj.display(); 
             if(proj.pos.y > height*2 || proj.pos.y < -height*2 || proj.pos.x > width*2 || proj.pos.x < -width*2){
                ProjectileStorage[i] = null;
             }
           } else {
            ProjectileStorage[i] = null; 
           }
         
         }
       }
      
        for(int i = 0; i < InvaderStorage.length; i++){
          if(InvaderStorage[i] != null){
            Invader invader = InvaderStorage[i];
            invader.show();
            invader.move(); 
            if(invader.getState() == false){
              InvaderStorage[i] = null;
            }
          }
         
          
       }
       
       for(int i = 0; i < ExplosionStorage.length; i++){
         if(ExplosionStorage[i] != null){
             ExplosionStorage[i].update();
             if(ExplosionStorage[i].curFrame > ExplosionStorage[i].explosionFrames){
              ExplosionStorage[i] = null;
             }
         }
       }
       
       
       
       
       
       if(curPlr != null) {
         curPlr.display();
         curPlr.move();
         if(curPlr.canShoot == true && spaceHeld == true){
          curPlr.shoot("Projectile"); 
         }
         updateInfoBar();
         if(curPlr.alive == false){
          curPlr = null; 
          loseFrame = frameCount;
         }
       }
       
       
       
       if(loseFrame != -1){
         fill(0,0,0,lerp(0,255,float(frameCount - loseFrame)/120));
         rect(0,0,width,height);
         if(frameCount > loseFrame + 120){
          gameState = "Lose"; 
         }
       }
      
       break;
     case "Lose":
       background(0);
       textAlign(CENTER,CENTER);
       fill(255,255,255,lerp(0,255,float(frameCount - (loseFrame + 120))/120));
       textSize(25);
       text("you lost (placeholder!)",width/2,height/2 - 
         lerp(0,300,smoothTween(

             float(frameCount - (loseFrame + 240)),60,1.25

         ))
       );
       
 
 
 }
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
  rect(width-50,height-50,lerp(0,50,float(curPlr.cd)/curPlr.rs),50);

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
  float healthPercentage = curPlr.health/PLR_HEALTHMAX;
  fill(lerp(255,200,healthPercentage),lerp(200,255,healthPercentage),200);
  rect(100,height - 40, 200 * healthPercentage, 20);
}



void keyPressed(){
    
  if(keyCode == 65){ //A
    AHeld = true;
  } else if(keyCode == 68){ //D
    DHeld = true;
  } else if(keyCode == 87){ //W
    WHeld = true;
  } else if(keyCode == 83){ //S
    SHeld = true;
  } else if(keyCode == 32){ //Space
    spaceHeld = true;
  } else if(keyCode == 82){ //R, for debugging
    resetGame();
  }
  
}

void keyReleased(){
  if(keyCode == 65){ //A
    AHeld = false;
  } else if(keyCode == 68){ //D
    DHeld = false;
  } else if(keyCode == 87){ //W
    WHeld = false;
  } else if(keyCode == 83){ //S
    SHeld = false;

  } else if(keyCode == 32){ //Space
    spaceHeld = false;
  } 
  
}
