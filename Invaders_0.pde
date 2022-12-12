Invader[][] InvaderGroup=new Invader[5][11];
int longest=11;
int shortest=1;
int surviving=55;

class Invader{
  PVector pos;
  int speed,xDir,type,level,size=20;
  boolean alive;
  Invader(PVector ipos,int ispeed,int kind){
    pos=ipos;
    speed=ispeed;
    type=kind;
    alive=true;
    xDir=1;
  }
    
  void move(){
    if(framerate%(61-framerate/suriving)){
      if(pos.x+shortest*size+speed<0|pos.x+longest*size+speed>width){
        pos.y+=speed;
        xDir*=-1;
      }
      else{
        pos.x+=speed;
      }
    }
}

void setupInvader(int level){
  for(int i=0;i<InvaderGroup.size;i++){
    for(int ii=0;ii<InvaderGroup[i].length;ii++){
      switch(i){
        case 0:
          InvaderGroup[i][ii]=new Invader(new PVector(size*ii,100+size*(i+level)),size/2,2);
        case (1|2):
          InvaderGroup[i][ii]=new Invader(new PVector(size*ii,100+size*(i+level)),size/2,1);
        default:
          InvaderGroup[i][ii]=new Invader(new PVector(size*ii,100+size*(i+level)),size/2,0);
      }
    }
  }
}

void updateWidth(){
  for(int i=0;i<InvaderGroup.length;i++){
    for(int ii=0;ii<InvaderGroup[i].length;ii++){
      if(InvaderGroup[i][ii]==true){
        shortest=min(ii,shortest);
        longest=max(ii,longest);
      }
    }
  }
}
//not sure why it causes an error
