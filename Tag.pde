
Tag[] TagStorage = new Tag[] {};






class Tag{
  String tagName;
  int textSize;
  float timeExisting = 0;
  float lifeTime;
  PVector pos;
  color textColor;
  Tag(PVector pos, String tagName, color textColor,int textSize,float lifeTime){
    this.tagName = tagName;
    this.textSize = textSize;
    this.lifeTime = lifeTime;
    this.pos = pos;
    this.textColor = textColor;
  }
  
  void update(){
    if(tagName != null && pos != null) { //i have literally no idea why this errors
      stroke(0);
      timeExisting += 1.0/60;
      float a = map(lifeTime - timeExisting, 0, 1, 0, 255);    
      fill(textColor,a);
      textSize(textSize);
      text(tagName,pos.x,pos.y);
      pos.y -= 1;
    }
    
  }
}

