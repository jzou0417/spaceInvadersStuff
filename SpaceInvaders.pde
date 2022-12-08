boolean AHeld,DHeld,SpaceHeld = false;

void setup(){
 size(500,800); 
  for(int i = 0; i < STAR_COUNT; i++){
    StarStorage.add(new Star());
  }
}

void draw(){
 background(0);
 //background stuf
 for(int i = 0; i < StarStorage.size(); i++){
  StarStorage.get(i).display(); 
 }
}



void keyPressed(){
    
  if(keyCode == 65){ //A
    AHeld = true;
  } else if(keyCode == 68){ //D
    DHeld = true;
  } else if(keyCode == 32){ //Space
    SpaceHeld = true;
  }
  
}

void keyReleased(){
    
  if(keyCode == 65){ //A
    AHeld = false;
  } else if(keyCode == 68){ //D
    DHeld = false;
  } else if(keyCode == 32){ //Space
    SpaceHeld = false;
  }
  
}
