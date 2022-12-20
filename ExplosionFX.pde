ExplosionFX[] ExplosionStorage = new ExplosionFX[] {};


class ExplosionFX {
 PVector pos;
 int explosionSize,explosionFrames;
 int curFrame = 0;
 color initColor = color(255,100,100);
 color midColor = color(255,200,100);
 color finColor = color(100,100,100);
 
 ExplosionFX(PVector pos,int explosionSize, int explosionFrames){
   this.pos = pos;
   this.explosionSize = explosionSize;
   this.explosionFrames = explosionFrames;
 }
 
 void update(){
   noStroke();
   pushMatrix();
   translate(pos.x,pos.y);

   float exp3Progress = float(curFrame) /explosionFrames;
   fill(finColor,lerp(100,0,exp3Progress));
   rotate(lerp(0,90,exp3Progress));
   rect(-explosionSize/2 * (1+exp3Progress),-explosionSize/2 * (1+exp3Progress),explosionSize * (1+exp3Progress),explosionSize * (1+exp3Progress));
   rotate(-lerp(0,90 ,exp3Progress));
   
   
   float exp2Progress = curFrame/(explosionFrames/2.0);
   fill(midColor,lerp(200,0,exp2Progress));
   rotate(lerp(0,180,exp2Progress));
   rect(-explosionSize/2 * (1+exp2Progress),-explosionSize/2 * (1+exp2Progress),explosionSize * (1+exp2Progress),explosionSize * (1+exp2Progress));
   rotate(-lerp(0,180,exp2Progress));
   
   
   float exp1Progress = curFrame/(explosionFrames/3.0);
   fill(initColor,lerp(255,0,exp1Progress));
   rotate(lerp(0,90,exp1Progress));
   rect(-explosionSize/2,-explosionSize/2,explosionSize,explosionSize);
   rotate(-lerp(0,90,exp1Progress));

  
   popMatrix();
   curFrame++;
 }
}
