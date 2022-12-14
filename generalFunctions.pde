float getAngle(float[] pos1, float[] pos2){
  return atan2(pos2[1] - pos1[1], pos2[0] - pos1[0])* 180/ PI;
}

boolean CircleCircleCollision(PVector pos1, PVector pos2, float c1Size, float c2Size){
  float maxDist = min(c1Size,c2Size);
  if(pos1.dist(pos2) < maxDist){
    return true;
  }
  return false;
}


boolean RectRectCollision(PVector rect1, PVector size1, PVector rect2, PVector size2){
  if( rect1.x < rect2.x + size2.x && rect1.x + size1.x > rect2.x && rect1.y < rect2.y + size2.y && size1.y + rect1.y > rect2.y){
    return true;
  }
  return false;
}

int[][] interpretFromStringToArray(String arr){
  println(arr);
 return new int[][] {};
}



void makeBorders(int posX,int posY,int sizeX,int sizeY,int lineSize,color lineColor){
  stroke(lineColor);
  line(posX,posY,posX+lineSize,posY);
  line(posX,posY,posX,posY+lineSize);
  line(posX+sizeX-1,posY,posX+sizeX-1 - lineSize,posY);
  line(posX+sizeX-1,posY,posX+sizeX-1,posY+lineSize);
  
  
  line(posX,posY+sizeY-1,posX+lineSize,posY+sizeY-1);
  line(posX,posY+sizeY-1,posX,posY+sizeY-lineSize-1);
  line(posX+sizeX-1,posY+sizeY-1,posX+sizeX-1 - lineSize,posY+sizeY-1);
  line(posX+sizeX-1,posY+sizeY-1,posX+sizeX-1,posY+sizeY-lineSize-1);
}
