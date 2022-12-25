


void updateWave(){
 waveComplete = true;
 switch(CUR_WAVE){
   case 1:
     spawnInvader("4x4 easy",new PVector(10,20),1,0);
     WAVE_DESC = "Easy peasy.";
     break;
   case 2:
     spawnInvader("4x4 easy",new PVector(10,20),1,0);
     spawnInvader("4x4 easy",new PVector(width-100,20),-1,600);
     WAVE_DESC = "Easy peasy. [2]";
     break;
   case 3:
     spawnInvader("15x1 blitz",new PVector(10,20),1,0);
     spawnInvader("4x4 easy",new PVector(10,20),1,600);
     spawnInvader("4x4 easy",new PVector(width-100,20),-1,600);
     WAVE_DESC = "Enemy go zoom.";

     break;
   case 4:
     spawnInvader("8x5 norm", new PVector(10,20),1,0);
     WAVE_DESC = "Tankier and bigger swarms to come.";

     break;
   case 5:
     spawnInvader("15x1 blitz",new PVector(10,20),1,0);
     spawnInvader("15x1 blitz",new PVector(10,20),1,300);
     spawnInvader("15x1 blitz",new PVector(10,20),1,600);
     spawnInvader("15x1 blitz",new PVector(10,20),1,900);
     spawnInvader("15x1 blitz",new PVector(10,20),1,1200);
     WAVE_DESC = "*blitzkrieg reference here*";

     break;
   case 6:
    spawnInvader("8x5 norm", new PVector(10,20),1,0);
    spawnInvader("zigzag", new PVector(10,20),1,120);
    spawnInvader("zigzag", new PVector(width-40,20),-1,120);
  
    spawnInvader("4x4 easy", new PVector(10,20),1,600);
    spawnInvader("4x4 easy", new PVector(width-100,20),-1,600);
    WAVE_DESC = "Ehhh... looks more like Touhou to me.";

    
    break;
  case 7:
    spawnInvader("8x5 norm", new PVector(10,-20),1,0);
    spawnInvader("8x5 norm", new PVector(width - 220,-20),-1,0);

    spawnInvader("zigzag", new PVector(10,20),1,0);
    spawnInvader("zigzag", new PVector(10,20),1,120);
    spawnInvader("zigzag", new PVector(10,20),1,240);
    spawnInvader("zigzag", new PVector(10,20),1,360);
    spawnInvader("zigzag", new PVector(10,20),1,480);
    WAVE_DESC = "Watch your step!";
    break;
  case 8:
    spawnInvader("4x4 easy", new PVector(10,20),1,600000000);
    WAVE_DESC = "unfinished lol";
    break;
 }
  
  
}
