void setup(){
  size(500,500);
}
void draw(){
  background(#000000);
  Invader(0,10,0,0);
  Invader(1,10,0,80);
}
void Invader(int type,int size,int xoffset,int yoffset){
  noStroke();
  if(type==0){//bottom 2 rows
    fill(#e500ff);
    rect(4*size+xoffset,yoffset,4*size,size);
    rect(size+xoffset,size+yoffset,10*size,size*2);
    rect(0+xoffset,size*2+yoffset,size*3,3*size);
    rect(9*size+xoffset,2*size+yoffset,3*size,3*size);
    rect(5*size+xoffset,3*size+yoffset,2*size,2*size);
    rect(5*size+xoffset,6*size+yoffset,2*size,size);
    if(frameCount%30>15){
      rect(2*size+xoffset,4*size+yoffset,3*size,2*size);
      rect(7*size+xoffset,4*size+yoffset,3*size,2*size);
      rect(size+xoffset,6*size+yoffset,2*size,size);
      rect(9*size+xoffset,6*size+yoffset,2*size,size);
      rect(2*size+xoffset,7*size+yoffset,2*size,size);
      rect(8*size+xoffset,7*size+yoffset,2*size,size);//frame 2
    }
    else{
      rect(3*size+xoffset,4*size+yoffset,2*size,2*size);
      rect(7*size+xoffset,4*size+yoffset,2*size,2*size);
      rect(2*size+xoffset,6*size+yoffset,2*size,size);
      rect(8*size+xoffset,6*size+yoffset,2*size,size);
      rect(xoffset,7*size+yoffset,2*size,size);
      rect(10*size+xoffset,7*size+yoffset,2*size,size);//frame 1
    }
  }
  if(type==1){//middle 2 rows
    fill(#00f4ff);
    rect(2*size+xoffset,yoffset,size,size);
    rect(8*size+xoffset,yoffset,size,size);
    rect(3*size+xoffset,size+yoffset,size,2*size);
    rect(7*size+xoffset,size+yoffset,size,2*size);
    rect(2*size+xoffset,2*size+yoffset,size,5*size);
    rect(8*size+xoffset,2*size+yoffset,size,5*size);
    rect(4*size+xoffset,2*size+yoffset,3*size,2*size);
    rect(3*size+xoffset,4*size+yoffset,5*size,2*size);
    if(frameCount%30>15){
      rect(xoffset,size+yoffset,size,4*size);
      rect(size+xoffset,3*size+yoffset,size,3*size);
      rect(size+xoffset,7*size+yoffset,size,size);
      rect(9*size+xoffset,7*size+yoffset,size,size);
      rect(9*size+xoffset,3*size+yoffset,size,3*size);
      rect(10*size+xoffset,size+yoffset,size,4*size);
    }
    else{
      rect(xoffset,4*size+yoffset,size,3*size);
      rect(size+xoffset,3*size+yoffset,size,2*size);
      rect(3*size+xoffset,7*size+yoffset,2*size,size);
      rect(6*size+xoffset,7*size+yoffset,2*size,size);
      rect(9*size+xoffset,3*size+yoffset,size,2*size);
      rect(10*size+xoffset,4*size+yoffset,size,3*size);
    }
  }
}
