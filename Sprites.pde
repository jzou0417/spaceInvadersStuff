void setup(){
  size(500,500);
}
void draw(){
  background(#000000);
  PVector invaderOne=new PVector(0,0);
  PVector invaderTwo=new PVector(200,0);
  PVector invaderThree=new PVector(400,0);
  PVector Player=new PVector(200,400);
  Invader(0,10,invaderOne);
  Invader(1,10,invaderTwo);
  Invader(2,10,invaderThree);
  Player(10, Player);
}
void Invader(int type,int size,PVector offset){
  noStroke();
  pushMatrix();
  translate(offset.x,offset.y);
  if(type==0){//bottom 2 rows
    fill(#e500ff);
    rect(4*size,0,4*size,size);
    rect(size,size,10*size,size*2);
    rect(0,2*size,size*3,3*size);
    rect(9*size,2*size,3*size,3*size);
    rect(5*size,3*size,2*size,2*size);
    rect(5*size,6*size,2*size,size);
    if(frameCount%30>15){
      rect(2*size,4*size,3*size,2*size);
      rect(7*size,4*size,3*size,2*size);
      rect(size,6*size,2*size,size);
      rect(9*size,6*size,2*size,size);
      rect(2*size,7*size,2*size,size);
      rect(8*size,7*size,2*size,size);//frame 2
    }
    else{
      rect(3*size,4*size,2*size,2*size);
      rect(7*size,4*size,2*size,2*size);
      rect(2*size,6*size,2*size,size);
      rect(8*size,6*size,2*size,size);
      rect(0,7*size,2*size,size);
      rect(10*size,7*size,2*size,size);//frame 1
    }
  }
  if(type==1){//middle 2 rows
    fill(#00f4ff);
    rect(2*size,0,size,size);
    rect(8*size,0,size,size);
    rect(3*size,size,size,2*size);
    rect(7*size,size,size,2*size);
    rect(2*size,2*size,size,5*size);
    rect(8*size,2*size,size,5*size);
    rect(4*size,2*size,3*size,2*size);
    rect(3*size,4*size,5*size,2*size);
    if(frameCount%30>15){
      rect(0,size,size,4*size);
      rect(size,3*size,size,3*size);
      rect(size,7*size,size,size);
      rect(9*size,7*size,size,size);
      rect(9*size,3*size,size,3*size);
      rect(10*size,size,size,4*size);
    }
    else{
      rect(0,4*size,size,3*size);
      rect(size,3*size,size,2*size);
      rect(3*size,7*size,2*size,size);
      rect(6*size,7*size,2*size,size);
      rect(9*size,3*size,size,2*size);
      rect(10*size,4*size,size,3*size);
    }
  }
  if(type==2){
    fill(#3bff07);
    rect(3*size,0,2*size,5*size);
    rect(2*size,size,4*size,2*size);
    rect(size,2*size,6*size,size);
    rect(0,3*size,2*size,2*size);
    rect(6*size,3*size,2*size,2*size);
    rect(0,4*size,8*size,size);
    if(frameCount%30>15){
      rect(3*size,5*size,2*size,size);
      rect(size,5*size,size,size);
      rect(0,6*size,size,size);
      rect(size,7*size,size,size);
      rect(6*size,5*size,size,size);
      rect(7*size,6*size,size,size);
      rect(6*size,7*size,size,size);
    }
    else{
      rect(2*size,5*size,size,size);
      rect(5*size,5*size,size,size);
      rect(size,6*size,size,size);
      rect(3*size,6*size,2*size,size);
      rect(6*size,6*size,size,size);
      rect(0,7*size,size,size);
      rect(2*size,7*size,size,size);
      rect(5*size,7*size,size,size);
      rect(7*size,7*size,size,size);
    }
  }
  popMatrix();
}
void Player(int size, PVector offset){
  noStroke();
  fill(#22cc00);
  pushMatrix();
  translate(offset.x,offset.y);
  rect(6*size,0,size,size);
  rect(5*size,size,3*size,2*size);
  rect(size,3*size,11*size,size);
  rect(0,4*size,13*size,4*size);
  popMatrix();
}
