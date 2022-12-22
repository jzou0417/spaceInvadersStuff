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

void changeGameState(String state) {
  ButtonStorage = new Button[] {};
  gameState = state;
  switch (state) {
  case "Menu":
    menuFrame = frameCount;
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 - 100, height / 2 + 150), new PVector(200, 50), "MissionSelect", "START", 25, 10, color(255,255,255),50,true));
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 - 100, height / 2 + 250), new PVector(200, 50), "OpenShop", "SHOP", 25, 10, color(255,255,255),50,true));

    break;
  case "Shop":
    menuFrame = frameCount;
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 - 100, height / 2 + 200), new PVector(200, 50), "OpenMenu", "MENU", 25, 10, color(255,255,255),50,true));
   
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 + 75, height / 2 - 200), new PVector(50, 50), "UpgradeSpeed", "+", 25, 0, color(255,255,255),50,true));
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 + 75, height / 2 - 150), new PVector(50, 50), "UpgradeROF", "+", 25, 0, color(255,255,255),50,true));
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 + 75, height / 2 - 100), new PVector(50, 50), "UpgradeHull", "+", 25, 0, color(255,255,255),50,true));
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 + 75, height / 2 - 50), new PVector(50, 50), "UpgradeDamage", "+", 25, 0, color(255,255,255),50,true));
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 + 75, height / 2), new PVector(50, 50), "UpgradePen", "+", 25, 0, color(255,255,255),50,true));
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 + 75, height / 2 + 50), new PVector(50, 50), "UpgradeVel", "+", 25, 0, color(255,255,255),50,true));




    break;
  case "Game":
    resetGame();
    break;
  case "Missions":
    menuFrame = frameCount;
    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 - 100, height / 2 + 150), new PVector(200, 50), "StartGame", "DEPLOY", 25, 10, color(255,255,255),50,true));

    ButtonStorage = (Button[]) append(ButtonStorage, new Button(new PVector(width / 2 - 100, height / 2 + 250), new PVector(200, 50), "OpenMenu", "MENU", 25, 10, color(255,255,255),50,true));

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
  //Temp
  InvaderStorage = (Invader[]) append(InvaderStorage, new InvaderGroup(
    new PVector(10, 20) //Position of the TOP LEFT corner
    , 60 //Framecount per move logic
    , 300 //Framecount per average shot per enemy within group
    , 4 //Shot velocity
    , 50 //Health per invader
    , 1 //X direction
    , 5 //Number of rows
    , 8 //Number of columns
    , 20 //Size of each invader's hitbox
  ));

}

float constrainFloat(float num) {
  return min(1, max(0, num));
}

float smoothTween(float value, float time, float intensity) { //the one time i will ever use trig for like anything ever
  return pow(sin(radians(90 * (constrainFloat(value / time)))), 1.0 / intensity);
}
