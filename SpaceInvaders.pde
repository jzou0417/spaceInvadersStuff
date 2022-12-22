boolean AHeld, DHeld, WHeld, SHeld, spaceHeld = false;
int score = 0;
int loseFrame = -1;
int menuFrame = -1;
String gameState = "Menu";

int PLR_CASH = 50000;

//Player Stats
int[] upgradeStats = new int[] {0,0,0,0,0,0}; //Health, Speed, ROF, Pierce, ProjSpeed, Damage
//Upgrade Stats {stat, cost to NEXT LEVEL, not the current level}
float[][] HealthLevels = new float[][] {
  {20,200},//baseline
  {30,600},
  {40,1200},
  {50,0}, //last upgrade
};
float[][] SpeedLevels = new float[][] {
  {3,350},//baseline
  {5,600},
  {7,2000}, //last upgrade
};

float[][] ROFLevels = new float[][] {
  {30,500},//baseline
  {20,1500},
  {15,3000},
  {10,0}, //last upgrade
};

float[][] PierceLevels = new float[][] {
  {1,3000},//baseline
  {2,5500},
  {3,0}, //last upgrade
};

float[][] ProjSpeedLevels = new float[][] {
  {8,300},//baseline
  {10,800},
  {15,2500},//last upgrade
};

float[][] DamageLevels = new float[][] {
  {30,200},//baseline
  {50,1200},
  {80,2500},
  {120,0}, //last upgrade
};


//Stats
int enemiesKilled;
float timeSurvived;
int hitFrame = -1;

Player curPlr;
void setup() {
  size(500, 800);
  frameRate(60);

  for (int i = 0; i < STAR_COUNT; i++) {
    StarStorage = (Star[]) append(StarStorage, new Star());
  }
  changeGameState("Menu");

}

void draw() {
  switch (gameState) {
  case "Game":
    timeSurvived += 1.0 / frameRate;
    background(0);
    //background stuf
    updateStars();

    for (int i = 0; i < ProjectileStorage.length; i++) {
      if (ProjectileStorage[i] != null) {
        Projectile proj = ProjectileStorage[i];
        if (proj.pierce > 0) {
          proj.move();
          proj.checkCollisions();
          proj.display();
          if (proj.pos.y > height * 2 || proj.pos.y < -height * 2 || proj.pos.x > width * 2 || proj.pos.x < -width * 2) {
            ProjectileStorage[i] = null;
          }
        } else {
          ProjectileStorage[i] = null;
        }

      }
    }

    for (int i = 0; i < InvaderStorage.length; i++) {
      if (InvaderStorage[i] != null) {
        Invader invader = InvaderStorage[i];
        invader.show();
        invader.move();
        if (invader.getState() == false) {
          InvaderStorage[i] = null;
        }
      }

    }

    for (int i = 0; i < ExplosionStorage.length; i++) {
      if (ExplosionStorage[i] != null) {
        ExplosionStorage[i].update();
        if (ExplosionStorage[i].curFrame > ExplosionStorage[i].explosionFrames) {
          ExplosionStorage[i] = null;
        }
      }
    }

    if (curPlr != null) {
      curPlr.display();
      curPlr.move();
      if (curPlr.canShoot == true && spaceHeld == true) {
        curPlr.shoot("Projectile");
      }
      updateInfoBar();
      if (curPlr.alive == false) {
        curPlr = null;
        loseFrame = frameCount;
      }
    }

    if (loseFrame != -1) {
      fill(0, 0, 0, lerp(0, 255, float(frameCount - loseFrame) / 120));
      rect(0, 0, width, height);
      if (frameCount > loseFrame + 120) {
        gameState = "Lose";
      }
    }
    if (hitFrame != -1) {
      fill(255, 100, 100, lerp(150, 0, float(frameCount - hitFrame) / 30));
      rect(0, 0, width, height);
    }
    break;
  case "Lose":
    background(0);
    updateStars();
    textAlign(CENTER, CENTER);
    fill(255, 255, 255, lerp(0, 255, float(frameCount - (loseFrame + 120)) / 120));
    textSize(25);
    text("you died! (biden says youre a hero)", width / 2, height / 2 -
      lerp(0, 300, smoothTween(
        float(frameCount - (loseFrame + 240)), 60, 1.25
      ))
    );
    fill(255, 255, 255, lerp(0, 255, float(frameCount - (loseFrame + 280)) / 60));
    text("kills: " + str(enemiesKilled),
      width / 2 - lerp(300, 0, smoothTween(float(frameCount - (loseFrame + 280)), 60, 1.25)),
      height / 2 - 250);

    fill(255, 255, 255, lerp(0, 255, float(frameCount - (loseFrame + 300)) / 60));
    text("time survived: " + str(round(timeSurvived * 10) / 10.0) + "s",
      width / 2 - lerp(300, 0, smoothTween(float(frameCount - (loseFrame + 300)), 60, 1.25)),
      height / 2 - 200);

    fill(255, 255, 255, lerp(0, 255, float(frameCount - (loseFrame + 320)) / 60));
    text("press R to restart",
      width / 2 - lerp(300, 0, smoothTween(float(frameCount - (loseFrame + 320)), 60, 1.25)),
      height / 2 + 200);

    fill(255, 255, 255, lerp(0, 255, float(frameCount - (loseFrame + 340)) / 60));
    text("press M to return to menu",
      width / 2 - lerp(300, 0, smoothTween(float(frameCount - (loseFrame + 340)), 60, 1.25)),
      height / 2 + 250);
      
      
      
      
      
     fill(0, 0, 0, lerp(255, 0, float(frameCount - (loseFrame + 120)) / 120));
     rect(0, 0, width, height);
     
    break;
  case "Menu":
    background(0);

    updateStars();
    textAlign(CENTER, CENTER);
    fill(255, 255, 255, lerp(0, 255, float(frameCount - menuFrame) / 120));
    textSize(50);
    text("SPACE INVADERS\n(gluten free)", width / 2, height / 2 -
      lerp(0, 300, smoothTween(
        float(frameCount - menuFrame), 60, 1.25
      ))
    );
    updateButtons();

    break;
  case "Shop":
    background(0);
    
    updateStars();
    updateButtons();
    
    textAlign(CENTER,CENTER);
    fill(255, 255, 255, lerp(0, 255, float(frameCount - menuFrame) / 30));
    textSize(50);
     text("shop!", width / 2, height / 2 -
      lerp(200, 300, smoothTween(
        float(frameCount - menuFrame), 30, 1.25
      ))
    );
    textAlign(RIGHT,CENTER);
    textSize(25);
    /*
    HealthLevels[upgradeStats[0]][0];
    SpeedLevels[upgradeStats[1]][0];
    ROFLevels[upgradeStats[2]][0];
    PierceLevels[upgradeStats[3]][0];
    ProjSpeedLevels[upgradeStats[4]][0];
    DamageLevels[upgradeStats[5]][0];*/
    fill(255, 255, 255, lerp(0, 255, float(frameCount - (menuFrame)) / 40));
    text("Mobility [" + str(SpeedLevels[upgradeStats[1]][0]) + "]", width/2 + 60 - lerp(300, 0, smoothTween(float(frameCount - (menuFrame)), 40, 1.25)), height/2-185);
    
    fill(255, 255, 255, lerp(0, 255, float(frameCount - menuFrame+5) / 40));
    text("Cyclic Rate [" + str(ROFLevels[upgradeStats[2]][0]) + "]", width/2 + 60 - lerp(300, 0, smoothTween(float(frameCount - (menuFrame+5)), 40, 1.25)), height/2-135);
    
    fill(255, 255, 255, lerp(0, 255, float(frameCount - (menuFrame+10)) / 40));
    text("Hull Integrity [" + str(HealthLevels[upgradeStats[0]][0]) + "]", width/2 + 60 - lerp(300, 0, smoothTween(float(frameCount -(menuFrame+10)), 40, 1.25)), height/2-85);
    
      
    fill(255, 255, 255, lerp(0, 255, float(frameCount - (menuFrame+15)) / 40));
    text("Lethality [" + str(DamageLevels[upgradeStats[5]][0]) + "]", width/2 + 60 - lerp(300, 0, smoothTween(float(frameCount - (menuFrame+15)), 40, 1.25)), height/2-35);
    
    fill(255, 255, 255, lerp(0, 255, float(frameCount - (menuFrame+20)) / 40));
    text("Penetration [" + str(PierceLevels[upgradeStats[3]][0]) + "]", width/2 + 60 - lerp(300, 0, smoothTween(float(frameCount - (menuFrame+20)), 40, 1.25)), height/2+15);
    
    fill(255, 255, 255, lerp(0, 255, float(frameCount - (menuFrame+25)) / 40));
    text("Phaser Velocity [" + str(ProjSpeedLevels[upgradeStats[4]][0]) + "]", width/2 + 60 - lerp(300, 0, smoothTween(float(frameCount - (menuFrame+25)), 40, 1.25)), height/2+65);
     
     //Description
     textAlign(CENTER,CENTER);
     textSize(20);
     
     for (int i = 0; i < ButtonStorage.length; i++) {
        Button button = ButtonStorage[i];
        if (RectRectCollision(button.pos, button.size, new PVector(mouseX, mouseY), new PVector(1, 1)) == true) {
           fill(200,255,200);
           switch(button.purpose){
  
            case "UpgradeHull":
              displayShopReqs(HealthLevels, 0, "Hull Integrity: ");
              break;
            case "UpgradeSpeed":
              displayShopReqs(SpeedLevels, 1, "Mobility: ");
              break;
            case "UpgradeROF":
              displayShopReqs(ROFLevels, 2, "Cyclic Rate: ");
              break;
            case "UpgradePen":
              displayShopReqs(PierceLevels, 3, "Penetration: ");
              break;
            case "UpgradeVel":
              displayShopReqs(ProjSpeedLevels, 4, "Phaser Velocity: ");
              break;
            case "UpgradeDamage":
              displayShopReqs(DamageLevels, 5, "Lethality: ");
              break; 
           }
       }
     }
    break;
  case "Missions":
    background(0);

    updateStars();
    updateButtons();
    break;
  }
}

void updateInfoBar() {
  noStroke();
  textAlign(LEFT);
  fill(255);
  textSize(20);
  text("SCORE: " + score, 25, height - 25);
  float healthPercentage = curPlr.health / HealthLevels[upgradeStats[0]][0];
  fill(lerp(255, 200, healthPercentage), lerp(200, 255, healthPercentage), 200);
  rect(120, height - 40, 200 * healthPercentage, 20);
}

void keyPressed() {
  println(keyCode);
  if (keyCode == 65) { //A
    AHeld = true;
  } else if (keyCode == 68) { //D
    DHeld = true;
  } else if (keyCode == 87) { //W
    WHeld = true;
  } else if (keyCode == 83) { //S
    SHeld = true;
  } else if (keyCode == 32) { //Space
    spaceHeld = true;
  } else if (keyCode == 82 && gameState == "Lose") {
    changeGameState("Game");
  } else if (keyCode == 77 && gameState == "Lose") {
    changeGameState("Menu");
  }

}

void keyReleased() {
  if (keyCode == 65) { //A
    AHeld = false;
  } else if (keyCode == 68) { //D
    DHeld = false;
  } else if (keyCode == 87) { //W
    WHeld = false;
  } else if (keyCode == 83) { //S
    SHeld = false;

  } else if (keyCode == 32) { //Space
    spaceHeld = false;
  }

}

void mousePressed() {
  for (int i = 0; i < ButtonStorage.length; i++) {
    Button button = ButtonStorage[i];
    if (RectRectCollision(button.pos, button.size, new PVector(mouseX, mouseY), new PVector(1, 1)) == true) {

      switch(button.purpose){
        case "StartGame":
          changeGameState("Game");
          break;
        case "OpenMenu":
          changeGameState("Menu");
          break;
        case "OpenShop":
          changeGameState("Shop");
          break;
        case "MissionSelect":
          changeGameState("Missions");
          break;
        //the bottom 6 cases are a testament to why roblox > processing (no FindFirstChild()?)
        case "UpgradeHull":
          if(PLR_CASH >= HealthLevels[upgradeStats[0]][1]){
           upgradeStats[0] = min(HealthLevels.length - 1, upgradeStats[0] + 1);
          }
          break;
        case "UpgradeSpeed":
          if(PLR_CASH >= SpeedLevels[upgradeStats[1]][1]){
           upgradeStats[1] = min(SpeedLevels.length - 1, upgradeStats[1] + 1);
          }
          break;
        case "UpgradeROF":
          if(PLR_CASH >= ROFLevels[upgradeStats[2]][1]){
           upgradeStats[2] = min(ROFLevels.length - 1, upgradeStats[2] + 1);
          }
          break;
        case "UpgradePen":
          if(PLR_CASH >= PierceLevels[upgradeStats[3]][1]){
           upgradeStats[3] = min(PierceLevels.length - 1, upgradeStats[3] + 1);
          }
          break;
        case "UpgradeVel":
          if(PLR_CASH >= ProjSpeedLevels[upgradeStats[4]][1]){
           upgradeStats[4] = min(ProjSpeedLevels.length - 1, upgradeStats[4] + 1);
          }
          break;
        case "UpgradeDamage":
          if(PLR_CASH >= DamageLevels[upgradeStats[5]][1]){
           upgradeStats[5] = min(DamageLevels.length - 1, upgradeStats[5] + 1);
          }
          break;
            
          
      }
    }
  }
}
