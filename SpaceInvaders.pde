

boolean AHeld,DHeld,WHeld,SHeld,spaceHeld = false;
int score = 0;
int PLR_HEALTHMAX = 50;
int loseFrame = -1;
int menuFrame = -1;
String gameState = "Game"; //"Menu", "Game", "Lose"


//Stats
int enemiesKilled;
float timeSurvived;
int hitFrame = -1;

Player curPlr;
void setup(){
 size(500,800); 
 frameRate(60);
 
  for(int i = 0; i < STAR_COUNT; i++){
     StarStorage = (Star[]) append(StarStorage,new Star());
  }
 resetGame();


}

void draw(){
  switch(gameState){
    case "Game":
     timeSurvived += 1.0/frameRate;
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
       if(hitFrame != -1){
         fill(255,100,100,lerp(150,0,float(frameCount - hitFrame)/30));
         rect(0,0,width,height);
       }
       break;
     case "Lose":
       background(0);
       textAlign(CENTER,CENTER);
       fill(255,255,255,lerp(0,255,float(frameCount - (loseFrame + 120))/120));
       textSize(25);
       text("you died! (biden says youre a hero)",width/2,height/2 - 
         lerp(0,300,smoothTween(
             float(frameCount - (loseFrame + 240)),60,1.25
         ))
       );
       fill(255,255,255,lerp(0,255,float(frameCount - (loseFrame + 280))/60));
       text("kills: " + str(enemiesKilled),
       width/2 - lerp(300,0,smoothTween(float(frameCount - (loseFrame + 280)),60,1.25)),
       height/2 - 250);
       
       fill(255,255,255,lerp(0,255,float(frameCount - (loseFrame + 340))/60));
       text("time survived: " + str(round(timeSurvived*10)/10.0) + "s",
       width/2 - lerp(300,0,smoothTween(float(frameCount - (loseFrame + 340)),60,1.25)),
       height/2 - 200);
 
       fill(255,255,255,lerp(0,255,float(frameCount - (loseFrame + 400))/60));
       text("press R to restart",
       width/2 - lerp(300,0,smoothTween(float(frameCount - (loseFrame + 400)),60,1.25)),
       height/2 - 150);
       
       fill(255,255,255,lerp(0,255,float(frameCount - (loseFrame + 460))/60));
       text("press M to return to menu",
       width/2 - lerp(300,0,smoothTween(float(frameCount - (loseFrame + 460)),60,1.25)),
       height/2 - 100);
       break;
     case "Menu":
       background(0);
       textAlign(CENTER,CENTER);
       fill(255,255,255,lerp(0,255,float(frameCount - menuFrame)/120));
       textSize(50);
       text("SPACE INVADERS\n(gluten free)",width/2,height/2 - 
         lerp(0,300,smoothTween(
             float(frameCount - menuFrame),60,1.25
         ))
       );
       
       
       
       
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
       break;
 }
}


void updateInfoBar(){
  noStroke();
  textAlign(LEFT);
  fill(255);
  textSize(20);
  text("SCORE: " + score,25,height-25);
  float healthPercentage = curPlr.health/PLR_HEALTHMAX;
  fill(lerp(255,200,healthPercentage),lerp(200,255,healthPercentage),200);
  rect(120,height - 40, 200 * healthPercentage, 20);
}



void keyPressed(){
  println(keyCode);
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
  } else if(keyCode == 82 && gameState == "Lose"){
    resetGame();
  } else if(keyCode == 77 && gameState == "Lose"){
    gameState = "Menu"; 
    menuFrame = frameCount;
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

void mousePressed(){
   for(int i = 0; i < ButtonStorage.length; i++){
      Button button = ButtonStorage[i];
      if(RectRectCollision(button.pos,button.size,new PVector(mouseX,mouseY),new PVector(1,1)) == true){
        button.onClick();
      }
   }
}
