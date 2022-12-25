boolean AHeld, DHeld, WHeld, SHeld, spaceHeld, scuttling, readTutorial,enemiesAlive,waveComplete = false;

int tabFrame,loseFrame = -1;
String gameState = "Menu";

int PLR_CASH = 5000;
int scuttleFrames = 0;
int CUR_WAVE = 1;
String WAVE_DESC;



//Mods (Active, Cash Multiplier)
float[][] mods = new float[][] {
{0,1.2},
{0,1.25},
{0,1.8},
{0,-10},
}; //Hidden, Sudden Death, Flashlight, NoFail


//Player Stats
int[] upgradeStats = new int[] {0,0,0,0,0,0}; //Health, Speed, ROF, Pierce, ProjSpeed, Damage
//Upgrade Stats {stat, cost to NEXT LEVEL, not the current level}
float[][] HealthLevels = new float[][] {
  {20,200},//baseline
  {30,600},
  {40,1000},
  {50,0}, //last upgrade
};
float[][] SpeedLevels = new float[][] {
  {3,550},//baseline
  {5,1200},
  {7,0}, //last upgrade
};

float[][] ROFLevels = new float[][] {
  {30,500},//baseline
  {20,1200},
  {15,2000},
  {10,0}, //last upgrade
};

float[][] PierceLevels = new float[][] {
  {1,2000},//baseline
  {2,4000},
  {3,0}, //last upgrade
};

float[][] ProjSpeedLevels = new float[][] {
  {8,500},//baseline
  {10,1550},
  {15,0},//last upgrade
};

float[][] DamageLevels = new float[][] {
  {12,200},//baseline
  {20,1200},
  {30,3000},
  {50,0}, //last upgrade
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
    updateProjectiles();
    updateInvaders();
    updateExplosions();
    updateTags();
    updateWave();
    
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
    if(curPlr != null){//Mod Support
     
      if(mods[1][0] == 1){
        curPlr.takeDamage(curPlr.health - 1);
      }
      if(mods[2][0] == 1){
       int vision = 120;
       if(spaceHeld == true){
        vision = 75; 
       }
       fill(0,0,0,255 - vision/6);
       rect(0,0,mouseX - vision,height); 
       rect(mouseX + vision,0,width,height); 
       rect(mouseX - vision,0,vision*2,mouseY - vision); 
       rect(mouseX - vision,mouseY + vision,vision*2,height); 
      }
    }
    if (scuttling == true && curPlr != null){
     scuttleFrames++;
     textAlign(CENTER,CENTER);
     fill(255,200,200);
     textSize(25);
     text("keep holding J for [" + str(round(20 - scuttleFrames/6.0)/10.0) + "] seconds\nto scuttle your ship",width/2,height/2);
     if (scuttleFrames > 120){
       curPlr.alive = false;
     }
    }
    
    if (loseFrame != -1) {
      fill(0, 0, 0, lerp(0, 255, float(frameCount - loseFrame) / 120));
      rect(0, 0, width, height);
      if (frameCount > loseFrame + 120) {
        changeGameState("Lose");
      }
    }
    if (hitFrame != -1) {
      fill(255, 100, 100, lerp(150, 0, float(frameCount - hitFrame) / 30));
      rect(0, 0, width, height);
    }
    tabFrame++;
    if(waveComplete == true && enemiesAlive == false){
      changeGameState("Win");
      CUR_WAVE++;
     
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
     tabFrame++;
    break;
  case "Menu":
    background(0);

    updateStars();
    textAlign(CENTER, CENTER);
    fill(255, 255, 255, lerp(0, 255, float(frameCount - tabFrame) / 120));
    textSize(50);
    text("SPACE INVADERS\n(gluten free)", width / 2, height / 2 -
      lerp(0, 300, smoothTween(
        float(frameCount - tabFrame), 60, 1.25
      ))
    );
    updateButtons();

    break;
  case "Shop":
    background(0);
    
    updateStars();
    updateButtons();
    
    textAlign(CENTER,CENTER);
   
    fill(255, 255, 255, lerp(0, 255, float(frameCount - tabFrame) / 30));
    textSize(50);
     text("shop!", width / 2, height / 2 -
      lerp(200, 300, smoothTween(
        float(frameCount - tabFrame), 30, 1.25
      ))
    );
    textSize(20);
    text("you have $" + str(PLR_CASH),width/2, 150);

    textAlign(RIGHT,CENTER);
    textSize(25);
    /*
    HealthLevels[upgradeStats[0]][0];
    SpeedLevels[upgradeStats[1]][0];
    ROFLevels[upgradeStats[2]][0];
    PierceLevels[upgradeStats[3]][0];
    ProjSpeedLevels[upgradeStats[4]][0];
    DamageLevels[upgradeStats[5]][0];*/
    fill(255, 255, 255, lerp(0, 255, float(frameCount - (tabFrame)) / 40));
    text("Mobility [" + str(SpeedLevels[upgradeStats[1]][0]) + "]", width/2 + 60 - lerp(300, 0, smoothTween(float(frameCount - (tabFrame)), 40, 1.25)), height/2-185);
    
    fill(255, 255, 255, lerp(0, 255, float(frameCount - tabFrame+5) / 40));
    text("Cyclic Rate [" + str(ROFLevels[upgradeStats[2]][0]) + "]", width/2 + 60 - lerp(300, 0, smoothTween(float(frameCount - (tabFrame+5)), 40, 1.25)), height/2-135);
    
    fill(255, 255, 255, lerp(0, 255, float(frameCount - (tabFrame+10)) / 40));
    text("Hull Integrity [" + str(HealthLevels[upgradeStats[0]][0]) + "]", width/2 + 60 - lerp(300, 0, smoothTween(float(frameCount -(tabFrame+10)), 40, 1.25)), height/2-85);
    
      
    fill(255, 255, 255, lerp(0, 255, float(frameCount - (tabFrame+15)) / 40));
    text("Lethality [" + str(DamageLevels[upgradeStats[5]][0]) + "]", width/2 + 60 - lerp(300, 0, smoothTween(float(frameCount - (tabFrame+15)), 40, 1.25)), height/2-35);
    
    fill(255, 255, 255, lerp(0, 255, float(frameCount - (tabFrame+20)) / 40));
    text("Penetration [" + str(PierceLevels[upgradeStats[3]][0]) + "]", width/2 + 60 - lerp(300, 0, smoothTween(float(frameCount - (tabFrame+20)), 40, 1.25)), height/2+15);
    
    fill(255, 255, 255, lerp(0, 255, float(frameCount - (tabFrame+25)) / 40));
    text("Phaser Velocity [" + str(ProjSpeedLevels[upgradeStats[4]][0]) + "]", width/2 + 60 - lerp(300, 0, smoothTween(float(frameCount - (tabFrame+25)), 40, 1.25)), height/2+65);
     
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
     fill(255, 255, 255, lerp(0, 255, float(frameCount - tabFrame) / 30));
      textSize(50);
       text("mods!", width / 2, height / 2 -
        lerp(200, 300, smoothTween(
          float(frameCount - tabFrame), 30, 1.25
        ))
      );
      
    textAlign(RIGHT,CENTER);
    textSize(25);
    noStroke();

    fill(255, 255, 255, lerp(0, 255, float(frameCount - (tabFrame)) / 40));
    text("Hidden [" + str(mods[0][1]) + "x]", width/2 + 60 - lerp(300, 0, smoothTween(float(frameCount - (tabFrame)), 40, 1.25)), height/2-185);
    fill(255,200,200,50);
    if(mods[0][0] == 1){
     fill(200,255,200,50); 
    }
    rect(width / 2 + 75, height / 2 - 200,50,50);
    
    fill(255, 255, 255, lerp(0, 255, float(frameCount - tabFrame+5) / 40));
    text("Sudden Death [" + str(mods[1][1]) + "x]", width/2 + 60 - lerp(300, 0, smoothTween(float(frameCount - (tabFrame+5)), 40, 1.25)), height/2-135);
    fill(255,200,200,50);
    if(mods[1][0] == 1){
     fill(200,255,200,50); 
    }
    rect(width / 2 + 75, height / 2 - 150,50,50);
    
    
    
    fill(255, 255, 255, lerp(0, 255, float(frameCount - (tabFrame+10)) / 40));
    text("Flashlight [" + str(mods[2][1]) + "x]", width/2 + 60 - lerp(300, 0, smoothTween(float(frameCount -(tabFrame+10)), 40, 1.25)), height/2-85);
    fill(255,200,200,50);
    if(mods[2][0] == 1){
     fill(200,255,200,50); 
    }
    rect(width / 2 + 75, height / 2 - 100,50,50);
     fill(255, 255, 255, lerp(0, 255, float(frameCount - (tabFrame+15)) / 40));
    text("No Fail [" + str(mods[3][1]) + "x]", width/2 + 60 - lerp(300, 0, smoothTween(float(frameCount -(tabFrame+10)), 40, 1.25)), height/2-35);
    fill(255,200,200,50);
    if(mods[3][0] == 1){
     fill(200,255,200,50); 
    }
    rect(width / 2 + 75, height / 2 - 50,50,50);
    
    
     textAlign(CENTER,CENTER);
     textSize(25);
     fill(255);
     text("multiplier: " + str(calculateScoreMult()),width/2,height/2+20);
     text("your current wave: " + str(CUR_WAVE),width/2,height/2+50);

    //Description
     
     textSize(20);
    
     for (int i = 0; i < ButtonStorage.length; i++) {
        Button button = ButtonStorage[i];
        if (RectRectCollision(button.pos, button.size, new PVector(mouseX, mouseY), new PVector(1, 1)) == true) {
           fill(200,255,200);
           textSize(18);
           switch(button.purpose){
            
            case "ModHidden":
              text("Projectiles get less visible the closer they are to you.\n(i couldn't think of a lore friendly explanation for this)",width/2, height/2 + 100);

              break;
            case "ModSD":
              text("Your cheap chinesium equipment turns out to not be too\ndurable in space. 'Buy once, cry once.' - A smart fellow",width/2, height/2 + 100);
              break;
            case "ModFlashlight":
              text("Your sensor modules malfunction, causing only a portion\nof the field to be visible at a time.",width/2, height/2 + 100);
              break;
            case "ModBaby":
              text("'wahh wahh i suck at video games' - you",width/2, height/2 + 100);
              break;
            
           }
       }
     }
 
 
 
    updateStars();
    updateButtons();
    break;
    case "Tutorial":
     background(0);
     fill(255, 255, 255, lerp(0, 255, float(frameCount - tabFrame) / 30));
      textSize(50);
       text("tutorial!", width / 2, height / 2 -
        lerp(200, 300, smoothTween(
          float(frameCount - tabFrame), 30, 1.25
        ))
      );
      textSize(20);
      text("CONTROLS LIST:\nMOVE: WASD\nSHOOT: SPACE\nSCUTTLE SHIP (suicide): J\n\ngo to the shop for upgrades\nif you need to test the features (for dw)\nchange the PLR_CASH variable to a large number",width/2,height/2);
      text("this only pops up once so read instructions plz",width/2,height/2-180);

      updateStars();
      updateButtons();
      break;
    case "Win":
      background(0);
      updateStars();
      textAlign(CENTER, CENTER);
      fill(255, 255, 255, lerp(0, 255, float(frameCount - (loseFrame + 120)) / 120));
      textSize(25);
      text("you beat wave " + str(CUR_WAVE - 1) + "!", width / 2, height / 2 -
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
      text("press R to continue",
        width / 2 - lerp(300, 0, smoothTween(float(frameCount - (loseFrame + 320)), 60, 1.25)),
        height / 2 + 200);
  
      fill(255, 255, 255, lerp(0, 255, float(frameCount - (loseFrame + 340)) / 60));
      text("press M to return to menu",
        width / 2 - lerp(300, 0, smoothTween(float(frameCount - (loseFrame + 340)), 60, 1.25)),
        height / 2 + 250);
        
        
        
        
        
       fill(0, 0, 0, lerp(255, 0, float(frameCount - (loseFrame + 120)) / 120));
       rect(0, 0, width, height);
       tabFrame++;
      break;
      
  }
}

void updateInfoBar() {
  noStroke();
  textAlign(LEFT);
  fill(255);
  textSize(20);
  text("$" + str(PLR_CASH), 25, height - 25);
  float healthPercentage = curPlr.health / HealthLevels[upgradeStats[0]][0];
  fill(lerp(255, 200, healthPercentage), lerp(200, 255, healthPercentage), 200);
  rect(120, height - 40, 200 * healthPercentage, 20);
  
  fill(255);
  textSize(20);
  text("WAVE: " + str(CUR_WAVE) + " // " + WAVE_DESC,25, height - 60);

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
  } else if (keyCode == 82 && (gameState == "Lose" || gameState == "Win")) {
    changeGameState("Game");
  } else if (keyCode == 77 && (gameState == "Lose" || gameState == "Win")) {
    changeGameState("Menu");
  } else if (keyCode == 74 && gameState == "Game") {
    scuttling = true; 
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
  } else if (keyCode == 74) {
    scuttling = false; 
    scuttleFrames = 0;
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
        //the bottom 9 cases are a testament to why roblox > processing
        case "UpgradeHull":
          if(PLR_CASH >= HealthLevels[upgradeStats[0]][1]){
           PLR_CASH -= HealthLevels[upgradeStats[0]][1];

           upgradeStats[0] = min(HealthLevels.length - 1, upgradeStats[0] + 1);
          }
          break;
        case "UpgradeSpeed":
          if(PLR_CASH >= SpeedLevels[upgradeStats[1]][1]){
           PLR_CASH -= SpeedLevels[upgradeStats[1]][1];

           upgradeStats[1] = min(SpeedLevels.length - 1, upgradeStats[1] + 1);

          }
          break;
        case "UpgradeROF":
          if(PLR_CASH >= ROFLevels[upgradeStats[2]][1]){
           PLR_CASH -= ROFLevels[upgradeStats[2]][1];

           upgradeStats[2] = min(ROFLevels.length - 1, upgradeStats[2] + 1);
          }
          break;
        case "UpgradePen":
          if(PLR_CASH >= PierceLevels[upgradeStats[3]][1]){
           PLR_CASH -= PierceLevels[upgradeStats[3]][1];
           upgradeStats[3] = min(PierceLevels.length - 1, upgradeStats[3] + 1);
          
          }
          break;
        case "UpgradeVel":
          if(PLR_CASH >= ProjSpeedLevels[upgradeStats[4]][1]){
           PLR_CASH -= ProjSpeedLevels[upgradeStats[4]][1];
           upgradeStats[4] = min(ProjSpeedLevels.length - 1, upgradeStats[4] + 1);
           
          }
          break;
        case "UpgradeDamage":
          if(PLR_CASH >= DamageLevels[upgradeStats[5]][1]){
           PLR_CASH -= DamageLevels[upgradeStats[5]][1];
           upgradeStats[5] = min(DamageLevels.length - 1, upgradeStats[5] + 1);
          }
          break;
        case "ModHidden": 
              println("hi");
              if(mods[0][0] == 1){
                mods[0][0] = 0;
              } else {
               mods[0][0] = 1; 
              }
              break; 
        case "ModSD":
              if(mods[1][0] == 1){
                mods[1][0] = 0;
              } else {
               mods[1][0] = 1; 
              }
              break; 
        case "ModFlashlight":
              if(mods[2][0] == 1){
                mods[2][0] = 0;
              } else {
               mods[2][0] = 1; 
              }
              break; 
        case "ModBaby":
              if(mods[3][0] == 1){
                mods[3][0] = 0;
              } else {
               mods[3][0] = 1; 
              }
              break; 
          
      }
    }
  }
}
