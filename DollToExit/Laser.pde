class Laser {
  boolean isAlive;
  float x, y;
  float originX, originY;
  float angle;
  static final float maxLength = 20;
  float speed = 4;

  void update(){

    if(!isAlive) return;

    x += cos(angle) * speed;
    y += sin(angle) * speed;
  }

  void display(){

    if(!isAlive) return;
    
    pushStyle();
    strokeWeight(10);  
    stroke(255, 0, 0);
    if(dist(x, y, originX, originY) <= maxLength){
      line(x, y, originX, originY);
    }else{
      line(x, y, x - cos(angle) * maxLength, y - sin(angle) * maxLength);
    }
    popStyle();
  }

  void checkCollision(Doll player){
    if(!isAlive) return;

     
    if(isHit(x, y, 0, 0, player.x, player.y, player.size, player.size)){
      player.hurt();
      isAlive = false;
    }
  }

  void fire(float originX, float originY, float targetX, float targetY){
    this.x = this.originX = originX;
    this.y = this.originY = originY;
    angle = atan2(targetY - y, targetX - x);
    isAlive = true;
  }
  

  Laser(){
    isAlive = false;
  }
}
