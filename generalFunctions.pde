float getAngle(float[] pos1, float[] pos2){
  return atan2(pos2[1] - pos1[1], pos2[0] - pos1[0])* 180/ PI;
}
