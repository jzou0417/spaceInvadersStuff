void setup(){
  size(500,500);
}
void draw(){
  background(#000000);
  PVector invaderOne=new PVector(60,40);
  PVector invaderTwo=new PVector(60,120);
  Invader(0,10,invaderOne);
  Invader(1,10,invaderTwo);
}
void Invader(int type,int size,PVector offset){
  noStroke();
  pushMatrix();
  translate(offset.x,offset.y);
  if(type==0){//bottom 2 rows
    fill(#e500ff);
    rect(-2*size,-4*size,4*size,size);
    rect(-5*size,-3*size,10*size,size*2);
    rect(-6*size,-2*size,size*3,3*size);
    rect(3*size,-2*size,3*size,3*size);
    rect(-size,-size,2*size,2*size);
    rect(-size,2*size,2*size,size);
    if(frameCount%30>15){
      rect(-4*size,0,3*size,2*size);
      rect(size,0,3*size,2*size);
      rect(-5*size,2*size,2*size,size);
      rect(3*size,2*size,2*size,size);
      rect(-4*size,3*size,2*size,size);
      rect(2*size,3*size,2*size,size);//frame 2
    }
    else{
      rect(-3*size,0,2*size,2*size);
      rect(size,0,2*size,2*size);
      rect(-4*size,2*size,2*size,size);
      rect(2*size,2*size,2*size,size);
      rect(-6*size,3*size,2*size,size);
      rect(4*size,3*size,2*size,size);//frame 1
    }
  }
  if(type==1){//middle 2 rows
    fill(#00f4ff);
    rect(-4*size,-4*size,size,size);
    rect(2*size,-4*size,size,size);
    rect(-3*size,-3*size,size,2*size);
    rect(size,-3*size,size,2*size);
    rect(-4*size,-2*size,size,5*size);
    rect(2*size,-2*size,size,5*size);
    rect(-2*size,-2*size,3*size,2*size);
    rect(-3*size,0,5*size,2*size);
    if(frameCount%30>15){
      rect(-6*size,-3*size,size,4*size);
      rect(-5*size,-size,size,3*size);
      rect(-5*size,3*size,size,size);
      rect(3*size,3*size,size,size);
      rect(3*size,-size,size,3*size);
      rect(4*size,-3*size,size,4*size);
    }
    else{
      rect(-6*size,0,size,3*size);
      rect(-5*size,-size,size,2*size);
      rect(-3*size,3*size,2*size,size);
      rect(0,3*size,2*size,size);
      rect(3*size,-size,size,2*size);
      rect(4*size,0,size,3*size);
    }
  }
  popMatrix();
}
