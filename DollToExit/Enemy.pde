class Enemy{
  
  // properties
  float x;
  float y;
  float sx;
  float sy;
  float size = 4*BRICK_SIZE/5;
  
  final int LASER_COOLDOWN = 100;
  int cooldown = LASER_COOLDOWN;
  float targetRadians;
  float shootRadians;
  float maxDetectRadians = 60;
  
  // rotate
  float angle=0;
  float phi=0;
  
  int life = 5;
  
  Laser laser;
  
  // constructor
  Enemy(float x, float y){
    this.x = x;
    this.y = y;  
    
    laser = new Laser();
  }
  
  // methods
  
  void shoot(){
    // if doll is in the radian range, shoot
    if(cooldown == LASER_COOLDOWN){
      targetRadians = atan2((y+BRICK_SIZE/2)-player.y, (x+BRICK_SIZE/2)-player.x);
      shootRadians = atan2((y+BRICK_SIZE/2)-sy,(x+BRICK_SIZE/2)-sx);
      if(getRadiansDifference(targetRadians,shootRadians) <= radians(maxDetectRadians)){
        laser.fire(sx,sy,player.x+player.size/2, player.y+player.size/2); 
      }
    }
    
    cooldown--;
    
    if(cooldown <= 0){cooldown = LASER_COOLDOWN;}
    
    laser.update();
  }
  
  void checkCollision(Doll player){
    laser.checkCollision(player);
  }
  
  void display(){
    drawEnemy();
    phi += 0.005;
    
    laser.display();
  }
  
  void drawEnemy(){
      fill(255);
      noStroke();
      ellipse(x+BRICK_SIZE/2, y+BRICK_SIZE/2,size,size);
      
      //satellite
      fill(255,0,0);
      sx = x+BRICK_SIZE/2+cos(270+phi)*size/2;
      sy = y+BRICK_SIZE/2+sin(270+phi)*size/2;
      ellipse(sx,sy,10,10);
      
     
  }
}
