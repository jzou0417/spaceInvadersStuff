
float getAngle(float[] pos1, float[] pos2) {
  return atan2(pos2[1] - pos1[1], pos2[0] - pos1[0]) * 180 / PI;
}

void updateStars(){
  for (int i = 0; i < StarStorage.length; i++) {
      if (StarStorage[i] != null) {
        Star curStar = StarStorage[i];
        curStar.display();
        if (curStar.yPos - curStar.size > height) {
          StarStorage[i] = null;
          StarStorage = (Star[]) append(StarStorage, new Star(-curStar.size));

        }
      }
    } 
}

void updateButtons(){
  for (int i = 0; i < ButtonStorage.length; i++) {
      if (ButtonStorage[i] != null) {
     
        ButtonStorage[i].show();
       
      }
    } 
}

void updateExplosions(){
   for (int i = 0; i < ExplosionStorage.length; i++) {
    if (ExplosionStorage[i] != null) {
      ExplosionStorage[i].update();
      if (ExplosionStorage[i].curFrame > ExplosionStorage[i].explosionFrames) {
        ExplosionStorage[i] = null;
      }
    }
  } 
}
void updateTags(){
  for (int i = 0; i < TagStorage.length; i++) {
      if (TagStorage[i] != null) {
     
        TagStorage[i].update();
       
      }
    } 
}

void updateInvaders(){
  enemiesAlive = false;
   for (int i = 0; i < InvaderStorage.length; i++) {
      if (InvaderStorage[i] != null) {
        enemiesAlive = true;
        Invader invader = InvaderStorage[i];
        invader.show();
        invader.move();
        if (invader.getState() == false) {
          InvaderStorage[i] = null;
        }
      }

    } 
}

void updateProjectiles(){
 for (int i = 0; i < ProjectileStorage.length; i++) {
      if (ProjectileStorage[i] != null) {
        Projectile proj = ProjectileStorage[i];
        if (proj.pierce > 0) {
          proj.move();
          proj.checkCollisions();
          proj.display();
          if (proj.pos.y > height || proj.pos.y < -10 || proj.pos.x > width + 10 || proj.pos.x < -10) {
            ProjectileStorage[i] = null;
          }
        } else {
          ProjectileStorage[i] = null;
        }

      }
    } 
}


void displayShopReqs(float[][] levels, int n, String prefix){
  if(upgradeStats[n] == levels.length-1) {
            fill(255,255,200);
            text("[MAX]",width/2, height/2 + 120);
          } else {
            if(PLR_CASH < levels[upgradeStats[n]][1]){
              fill(255,200,200);
            }
            text(prefix + str(levels[upgradeStats[n]][0]) +  " > " + str(levels[upgradeStats[n] + 1][0]) + " [$" + str(levels[upgradeStats[n]][1]) + "]",width/2, height/2 + 120);

          } 
}

float calculateScoreMult(){
  float mult = 1;
  for(int i = 0; i < mods.length; i++){
   if(mods[i][0] == 1){
    mult += mods[i][1] - 1; 
   }
  }
  return max(0,mult);
}



void changeGameState(String state) {
  ButtonStorage = new Button[] {};
  gameState = state;
  switch (state) {
  case "Menu":
    tabFrame = frameCount;
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 - 100, height / 2 + 150), new PVector(200, 50), "MissionSelect", "START", 25, 10, color(255,255,255),50,true));
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 - 100, height / 2 + 250), new PVector(200, 50), "OpenShop", "SHOP", 25, 10, color(255,255,255),50,true));

    break;
  case "Lose":
  //nothing here
    break;
  case "Win":
    
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 - 100, height / 2 + 200), new PVector(200, 50), "OpenMenu", "MENU", 25, 10, color(255,255,255),50,true));

    break;
  case "Shop":
    tabFrame = frameCount;
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 - 100, height / 2 + 200), new PVector(200, 50), "OpenMenu", "MENU", 25, 10, color(255,255,255),50,true));
   
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 + 75, height / 2 - 200), new PVector(50, 50), "UpgradeSpeed", "+", 25, 0, color(255,255,255),50,true));
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 + 75, height / 2 - 150), new PVector(50, 50), "UpgradeROF", "+", 25, 0, color(255,255,255),50,true));
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 + 75, height / 2 - 100), new PVector(50, 50), "UpgradeHull", "+", 25, 0, color(255,255,255),50,true));
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 + 75, height / 2 - 50), new PVector(50, 50), "UpgradeDamage", "+", 25, 0, color(255,255,255),50,true));
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 + 75, height / 2), new PVector(50, 50), "UpgradePen", "+", 25, 0, color(255,255,255),50,true));
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 + 75, height / 2 + 50), new PVector(50, 50), "UpgradeVel", "+", 25, 0, color(255,255,255),50,true));




    break;
  case "Game":
    if(readTutorial == true){
       resetGame();

    } else {
      readTutorial = true;
      changeGameState("Tutorial");
    }
    
    break;
  case "Missions":
    tabFrame = frameCount;
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 - 100, height / 2 + 150), new PVector(200, 50), "StartGame", "DEPLOY", 25, 10, color(255,255,255),50,true));

    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 - 100, height / 2 + 250), new PVector(200, 50), "OpenMenu", "MENU", 25, 10, color(255,255,255),50,true));

    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 + 75, height / 2 - 200), new PVector(50, 50), "ModHidden", "+", 25, 0, color(255,255,255),0,true));
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 + 75, height / 2 - 150), new PVector(50, 50), "ModSD", "+", 25, 0, color(255,255,255),0,true));
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 + 75, height / 2 - 100), new PVector(50, 50), "ModFlashlight", "+", 25, 0, color(255,255,255),0,true));
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 + 75, height / 2 - 50), new PVector(50, 50), "ModBaby", "+", 25, 0, color(255,255,255),0,true));
    break;
  case "Tutorial":
    tabFrame = frameCount;
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 - 100, height / 2 + 250), new PVector(200, 50), "StartGame", "OK", 25, 10, color(255,255,255),50,true));


  break;
  }
}

boolean CircleCircleCollision(PVector pos1, PVector pos2, float c1Size, float c2Size) {
  float maxDist = min(c1Size, c2Size);
  if (pos1.dist(pos2) < maxDist) {
    return true;
  }
  return false;
}

boolean RectRectCollision(PVector rect1, PVector size1, PVector rect2, PVector size2) {
  if (rect1.x < rect2.x + size2.x && rect1.x + size1.x > rect2.x && rect1.y < rect2.y + size2.y && size1.y + rect1.y > rect2.y) {
    return true;
  }
  return false;
}

int[][] interpretFromStringToArray(String arr) {
  int row = 0;
  int col = 0;
  for (int i = 0; i < arr.length(); i++) {
    if (arr.charAt(i) == '|') {
      row++;
    }
  }
  int[][] array = new int[row + 1][];
  row = 0;
  for (int i = 1; i < arr.length(); i++) {
    if (arr.charAt(i) == ',') {
      col++;
    }
    if (arr.charAt(i) == '|' | arr.charAt(i) == ']') {
      array[row] = new int[col + 1];
      col = 0;
      row++;
    }
  }
  row = 0;
  for (int i = 1; i < arr.length() - 1; i++) {
    String entry = str(arr.charAt(i));
    if (arr.charAt(i) == ',') {
      col++;
    }
    if (arr.charAt(i) == '|') {
      row++;
      col = 0;
    } else {
      array[row][col] = int(entry);
    }
  }
  return array;
}

void makeBorders(int posX, int posY, int sizeX, int sizeY, int lineSize, color lineColor) {
  stroke(lineColor);
  line(posX, posY, posX + lineSize, posY);
  line(posX, posY, posX, posY + lineSize);
  line(posX + sizeX - 1, posY, posX + sizeX - 1 - lineSize, posY);
  line(posX + sizeX - 1, posY, posX + sizeX - 1, posY + lineSize);

  line(posX, posY + sizeY - 1, posX + lineSize, posY + sizeY - 1);
  line(posX, posY + sizeY - 1, posX, posY + sizeY - lineSize - 1);
  line(posX + sizeX - 1, posY + sizeY - 1, posX + sizeX - 1 - lineSize, posY + sizeY - 1);
  line(posX + sizeX - 1, posY + sizeY - 1, posX + sizeX - 1, posY + sizeY - lineSize - 1);
}

void resetGame() {
  //Resetting Stuff
  ExplosionStorage = new ExplosionFX[] {};
  InvaderStorage = new Invader[] {};
  ProjectileStorage = new Projectile[] {};

  enemiesKilled = 0;
  timeSurvived = 0;
  loseFrame = -1;
  hitFrame = -1;

  //Player Creation
  curPlr = new Player(new PVector(width / 2, height - 80));

  gameState = "Game";
  tabFrame = -1;
  //Temp



}

float constrainFloat(float num) {
  return min(1, max(0, num));
}

float smoothTween(float value, float time, float intensity) { //the one time i will ever use trig for like anything ever
  return pow(sin(radians(90 * (constrainFloat(value / time)))), 1.0 / intensity);
}


void spawnInvader(String type,PVector pos,int dir,int frameSpawn){
  if(frameSpawn >= tabFrame){
   waveComplete = false; 
  }
  if(frameSpawn == tabFrame){
    
    switch(type){
      case "8x5 norm":
       InvaderStorage = (Invader[]) append(InvaderStorage, new InvaderGroup(
        pos //Position of the TOP LEFT corner
        , 60 //Framecount per move logic
        , 300 //Framecount per average shot per enemy within group
        , 4 //Shot velocity
        , 50 //Health per invader
        , dir //X direction
        , 5 //Number of rows
        , 8 //Number of columns
        , 20 //Size of each invader's hitbox
      ));
      break;
      case "4x4 easy":
         InvaderStorage = (Invader[]) append(InvaderStorage, new InvaderGroup(
          pos //Position of the TOP LEFT corner
          , 120 //Framecount per move logic
          , 400 //Framecount per average shot per enemy within group
          , 4 //Shot velocity
          , 20 //Health per invader
          , dir //X direction
          , 4 //Number of rows
          , 4 //Number of columns
          , 20 //Size of each invader's hitbox
        ));
        break;
      case "10x1 blitz":
         InvaderStorage = (Invader[]) append(InvaderStorage, new InvaderGroup(
          pos //Position of the TOP LEFT corner
          , 30 //Framecount per move logic
          , 80 //Framecount per average shot per enemy within group
          , 2 //Shot velocity
          , 20 //Health per invader
          , dir //X direction
          , 1 //Number of rows
          , 10 //Number of columns
          , 20 //Size of each invader's hitbox
        ));
        break;
        
       case "15x1 blitz":
         InvaderStorage = (Invader[]) append(InvaderStorage, new InvaderGroup(
          pos //Position of the TOP LEFT corner
          , 30 //Framecount per move logic
          , 160 //Framecount per average shot per enemy within group
          , 2 //Shot velocity
          , 20 //Health per invader
          , dir //X direction
          , 1 //Number of rows
          , 15 //Number of columns
          , 20 //Size of each invader's hitbox
        ));
        break;
      case "zigzag":
         InvaderStorage = (Invader[]) append(InvaderStorage, new InvaderGroup(
          pos //Position of the TOP LEFT corner
          , 10 //Framecount per move logic
          , 20 //Framecount per average shot per enemy within group
          , 1 //Shot velocity
          , 10 //Health per invader
          , dir //X direction
          , 1 //Number of rows
          , 1 //Number of columns
          , 20 //Size of each invader's hitbox
        ));
        break;
      
    }
  }
  
 
}
