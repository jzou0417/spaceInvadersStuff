
class Player {
  PVector pos, moveDir;
  int size, animationFrame;
  float speed, health;
  boolean alive = true;

  //ProjectileData
  boolean canShoot = false;

  PVector pSize = new PVector(3, 10);
  float pSpeed, pDamage,cd,rs,pierce;

  Player(PVector pos) {
    this.health = HealthLevels[upgradeStats[0]][0];
    this.pos = pos;
    this.speed = SpeedLevels[upgradeStats[1]][0];
    this.size = 20;
    this.cd = ROFLevels[upgradeStats[2]][0];
    this.rs = cd;
    this.pierce = PierceLevels[upgradeStats[3]][0];
    this.pSpeed = ProjSpeedLevels[upgradeStats[4]][0];
    this.pDamage = DamageLevels[upgradeStats[5]][0];
  }
  
  void display() {
    fill(255);
    circle(pos.x, pos.y, size);
    circle(pos.x - width, pos.y, size);
    circle(pos.x + width, pos.y, size);

    cd = max(0, cd - 1);
    if (cd == 0) {
      canShoot = true;
    }
  }

  void shoot(String type) {
    switch (type) {
    case "Projectile":

      ProjectileStorage = (Projectile[]) append(ProjectileStorage, new Projectile(
        true //friendly/enemy projectile, don't touch
        , new PVector(pos.x, pos.y) //shot pos, don't touch
        , pSize //shot size
        , new PVector(0, -1) //shot dir
        , pDamage //shot damage
        , pSpeed //shot speed
        , "Rect" //shot type (circle or rect)
        , color(255, 200, 200, 200) //shot color
        , int(pierce) //shot pierce
      ));
      canShoot = false;
      cd = rs;
      break;

    }
  }

  void takeDamage(float damage) {
    if(mods[3][0] != 1){
      health = max(0, health - damage);
      if (health == 0) {
        alive = false;
        ExplosionStorage = (ExplosionFX[]) append(ExplosionStorage, new ExplosionFX(pos, 200, 120));
      }
    }
  
  }

  void move() {
    moveDir = new PVector(0, 0);
    if (AHeld) {
      moveDir.x -= 1;
    }
    if (DHeld) {
      moveDir.x += 1;
    }
    if (WHeld) {
      moveDir.y -= 1;
    }
    if (SHeld) {
      moveDir.y += 1;
    }

    moveDir.normalize();
    pos.add(new PVector(moveDir.x * speed, moveDir.y * speed));

    pos.y = max(min(pos.y, height - 100), height / 2);
    if (pos.x < 0) {
      pos.x = width;
    } else if (pos.x > width) {
      pos.x = 0;
    }
  }

}
