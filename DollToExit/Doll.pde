class Doll{
  
  // properties
  float x;
  float y;
  float xSpeed = 2;
  float ySpeed = 5;
  float size = 3*BRICK_SIZE/5;
  
  float phi = 0;
  float maxDetectRadians = 60;
  
  int life = 5;
  
  PImage doll[] = new PImage[7];;

  
  // constructor
  Doll(float x, float y){ 
    this.x = x;
    this.y = y;
    xSpeed = 2;
    ySpeed = 5;
    for(int i=0; i<doll.length; i++) { doll[i] = loadImage("img/doll"+i+".png"); }
  }
 
  
  // methods
  void move(){
    
      moveOnBrick();
      
      int col = (int)x/BRICK_SIZE;
      int row = (int)y/BRICK_SIZE;
       
     
      
      // hit fire
      if(hitFire() == true){
         hurt();
      }
      
      
      // hit limb
      if(hitLimb()){
        limbNum--;
        // record walked
        walked[col][row] = true;
      }
      if(hitOpen()){
        walked[col][row] = true;
      }
      
      
  }
  
  
  void display(){
    
    int col = (int)x/BRICK_SIZE;
    int row = (int)y/BRICK_SIZE;
    
    
    if(gameState == 2){
      pushMatrix();
      if(downState){ 
        scale(1,1);
        image(doll[0],x,y,size,size);
        
      }
      if(!downState){ 
        scale(1,-1);
        image(doll[0],x,-y-size,size,size);
        
      }
      popMatrix();
    }
    
     if(gameState == 4){
      pushMatrix();
      if(downState){ 
        scale(1,1);
        image(doll[1],x,y,size,size); 
        if(brickHealth[col][row+1] == 2){
          image(doll[3],x,y,size,size);
        }
      }
      if(!downState){ 
        scale(1,-1);
        image(doll[1],x,-y-size,size,size);
        if(brickHealth[col][row-1] == 2){
          image(doll[3],x,-y-size,size,size);
        }
      }
      popMatrix();
    }
    
   
    
    if(gameState == 6){
      pushMatrix();
      
      phi += 0.005;
      float sx = 7*BRICK_SIZE+BRICK_SIZE/2+cos(270+phi)*size/2;
      float sy = 8*BRICK_SIZE+BRICK_SIZE/2+sin(270+phi)*size/2;
      float targetRadians = atan2((8*BRICK_SIZE+BRICK_SIZE/2)-y, (7*BRICK_SIZE+BRICK_SIZE/2)-x);
      float shootRadians = atan2((8*BRICK_SIZE+BRICK_SIZE/2)-sy,(7*BRICK_SIZE+BRICK_SIZE/2)-sx);
      
      if(downState){ 
        scale(1,1);
        if(getRadiansDifference(targetRadians,shootRadians) > radians(maxDetectRadians)){
          image(doll[2],x,y,size,size);
        }else{
          image(doll[5],x,y,size,size);
        }
        
        if(brickHealth[col][row+1] == 2){
          if(getRadiansDifference(targetRadians,shootRadians) > radians(maxDetectRadians)){
            image(doll[4],x,y,size,size);
          }else{
            image(doll[6],x,y,size,size);
          }
        }
      }
      if(!downState){ 
        scale(1,-1);
        if(getRadiansDifference(targetRadians,shootRadians) > radians(maxDetectRadians)){
          image(doll[2],x,-y-size,size,size);
        }else{
          image(doll[5],x,-y-size,size,size);
        }
        if(brickHealth[col][row-1] == 2){
          if(getRadiansDifference(targetRadians,shootRadians) > radians(maxDetectRadians)){
            image(doll[4],x,-y-size,size,size);
          }else{
            image(doll[6],x,-y-size,size,size);
          }
        }
      }
      popMatrix();
    }

  }
  
  void changeGamestate(){
    if(gameState == 2){
        if((x > 550 && x < 600) && (y >= 250 && y <= 300)){
          gameState = GAME_PR_2;
        }
    }
    if(gameState == 4){
       if((x > 650 && x < 700) && (y >= 150 && y <= 200)){
          gameState = GAME_PR_3;
        }
    }
    if(gameState == 6){
       if((x > 650 && x < 700) && (y >= 150 && y <= 200)){
         isWin = false;
          gameState = GAME_WIN;
        }
    }
  }
  
  void alert(){
    
  }

  
  void hurt(){
    life -- ;
    
    if(gameState == 2){
      x = 5*BRICK_SIZE;
      y = 9*BRICK_SIZE;
    }
    if(gameState == 4 || gameState == 6){
      x = 3*BRICK_SIZE;
      y = 12*BRICK_SIZE;
    }
    downState = true;
    
    if(life <= 0){
      gameState = GAME_LOSE;
    }
    
  }
  
  boolean hitFire(){
    if(hitDetection(6)){
      return true;
    }else{
      return false;
    }
  }
  
  boolean hitLimb(){
    if(hitDetection(7) || hitDetection(8)){
      return true;
    }else{
      return false;
    }
  }
  
  boolean hitOpen(){
    if(hitDetection(3)){
      return true;
    }else{
      return false;
    }
  }
  
 boolean hitDetection(int num){
    int col = (int)x/BRICK_SIZE;
    int row = (int)y/BRICK_SIZE;
    boolean isHit = false;
    
        if(brickHealth[col][row] == num){
          isHit=true;
        }
        
    return isHit;
  }
  
  
  
  void moveOnBrick(){

    if(downState){
        
        int col = (int)x/BRICK_SIZE;
        int row = (int)y/BRICK_SIZE;
        
        float currentySpeed = ySpeed;
        float currentxSpeed = xSpeed;
        if(brickHealth[col][row+1] == 1 || brickHealth[col][row+1] == 2 || brickHealth[col][row+1] == 4){
          if((row+1)*BRICK_SIZE <= y+size){
            currentySpeed = 0;
          }
        }
        if(brickHealth[col-1][row] == 1 || brickHealth[col-1][row] == 2 || brickHealth[col-1][row] == 4){
          if(col*BRICK_SIZE >= x){
            currentxSpeed = 0;
          }
        }
        if(brickHealth[col+1][row] == 1 || brickHealth[col+1][row] == 2 || brickHealth[col+1][row] == 4){
          if((col+1)*BRICK_SIZE <= x+size){
            currentxSpeed = 0;
          }
        }
        
        // mid
        if( x%BRICK_SIZE + size > BRICK_SIZE){
          col += 1;
          if(brickHealth[col][row+1] == 1 || brickHealth[col][row+1] == 2 || brickHealth[col][row+1] == 4){
            if((row+1)*BRICK_SIZE <= y+size){
              currentySpeed = 0;
            }
          }
          if(brickHealth[col-1][row] == 1 || brickHealth[col-1][row] == 2 || brickHealth[col-1][row] == 4){
            if(col*BRICK_SIZE >= x){
              currentxSpeed = 0;
            }
          }
          if(brickHealth[col+1][row] == 1 || brickHealth[col-1][row] == 2 || brickHealth[col-1][row] == 4){
            if((col+1)*BRICK_SIZE <= x+size){
              currentxSpeed = 0;
            }
          }
        }
        y+=currentySpeed;
      }
    
    
    
    if(!downState){
        int col = (int)x/BRICK_SIZE;
        int row = (int)y/BRICK_SIZE;
        
        float currentySpeed = ySpeed;
        float currentxSpeed = xSpeed;
        if(brickHealth[col][row-1] == 1 || brickHealth[col][row-1] == 2 || brickHealth[col][row-1] == 4){
          if(row*BRICK_SIZE >= y){
            currentySpeed = 0;
          }
        }
        if(brickHealth[col-1][row] == 1 || brickHealth[col-1][row] == 2 || brickHealth[col-1][row] == 4){
          if(col*BRICK_SIZE >= x){
            currentxSpeed = 0;
          }
        }
        if(brickHealth[col+1][row] == 1 || brickHealth[col+1][row] == 2 || brickHealth[col+1][row] == 4){
          if((col+1)*BRICK_SIZE <= x+size){
            currentxSpeed = 0;
          }
        }
        
        // mid
        if( x%BRICK_SIZE + size > BRICK_SIZE){
          col += 1;
          if(brickHealth[col][row-1] == 1 || brickHealth[col][row-1] == 2 || brickHealth[col][row-1] == 4){
            if(row*BRICK_SIZE >= y){
              currentySpeed = 0;
            }
          }
          if(brickHealth[col-1][row] == 1 || brickHealth[col-1][row] == 2 || brickHealth[col-1][row] == 4){
            if(col*BRICK_SIZE >= x){
              currentxSpeed = 0;
            }
          }
          if(brickHealth[col+1][row] == 1 || brickHealth[col+1][row] == 2 || brickHealth[col+1][row] == 4){
            if((col+1)*BRICK_SIZE <= x+size){
              currentxSpeed = 0;
            }
          }
        }
        y-=currentySpeed;
      }
      
      
      
      if(leftState){
        int col = (int)x/BRICK_SIZE;
        int row = (int)y/BRICK_SIZE;
        
        float currentySpeed = ySpeed;
        float currentxSpeed = xSpeed;
        if(downState && brickHealth[col][row+1] == 2) {currentxSpeed *= 2;}
        if(!downState && brickHealth[col][row-1] == 2) {currentxSpeed *= 2;}

        if(brickHealth[col-1][row] == 1 || brickHealth[col-1][row] == 2 || brickHealth[col-1][row] == 4){
          if(col*BRICK_SIZE >= x-currentxSpeed){
            currentxSpeed = 0;
          }
        }
        if(brickHealth[col][row-1] == 1 || brickHealth[col][row-1] == 2 || brickHealth[col][row-1] == 4){
          if(row*BRICK_SIZE >= y){
            currentySpeed = 0;
          }
        }
        if(brickHealth[col][row+1] == 1 || brickHealth[col][row+1] == 2 || brickHealth[col][row+1] == 4){
          if((row+1)*BRICK_SIZE <= y+size){
            currentySpeed = 0;
          }
        }
        
        // mid
        if( y%BRICK_SIZE + size > BRICK_SIZE){
          row += 1;
          if(brickHealth[col-1][row] == 1 || brickHealth[col-1][row] == 2 || brickHealth[col-1][row] == 4){
            if(col*BRICK_SIZE >= x-currentxSpeed){
              currentxSpeed = 0;
            }
          }
          if(brickHealth[col][row-1] == 1 || brickHealth[col][row-1] == 2 || brickHealth[col][row-1] == 4){
            if(row*BRICK_SIZE >= y){
              currentySpeed = 0;
            }
          }
          if(brickHealth[col][row+1] == 1 || brickHealth[col][row+1] == 2 || brickHealth[col][row+1] == 4){
            if((row+1)*BRICK_SIZE <= y+size){
              currentySpeed = 0;
            }
          }
        }
        x-=currentxSpeed;

      }
      
      if(rightState){
        int col = (int)x/BRICK_SIZE;
        int row = (int)y/BRICK_SIZE;
        
        float currentySpeed = ySpeed;
        float currentxSpeed = xSpeed;
        if(downState && brickHealth[col][row+1] == 2) {currentxSpeed *= 2;}
        if(!downState && brickHealth[col][row-1] == 2) {currentxSpeed *= 2;}
        
        if(brickHealth[col+1][row] == 1 || brickHealth[col+1][row] == 2 || brickHealth[col+1][row] == 4 || brickHealth[col+1][row] == 5){
          if((col+1)*BRICK_SIZE <= x+size){
            currentxSpeed = 0;
          }
        }
        if(brickHealth[col][row-1] == 1 || brickHealth[col][row-1] == 2 || brickHealth[col][row-1] == 4 || brickHealth[col][row-1] == 5){
          if(row*BRICK_SIZE >= y){
            currentySpeed = 0;
          }
        }
        if(brickHealth[col][row+1] == 1 || brickHealth[col][row+1] == 2 || brickHealth[col][row+1] == 4 || brickHealth[col][row+1] == 5) { 
          if((row+1)*BRICK_SIZE <= y+size){
            currentySpeed = 0;
          }
        }
        
        // mid
        if( y%BRICK_SIZE + size > BRICK_SIZE){
          row += 1;
          if(brickHealth[col+1][row] == 1 || brickHealth[col+1][row] == 2 || brickHealth[col+1][row] == 4 || brickHealth[col][row+1] == 5){
            if((col+1)*BRICK_SIZE <= x+size){
              currentxSpeed = 0;
            }
          }
          if(brickHealth[col][row-1] == 1 || brickHealth[col][row-1] == 2 || brickHealth[col][row-1] == 4 || brickHealth[col][row+1] == 5){
            if(row*BRICK_SIZE >= y){
              currentySpeed = 0;
            }
          }
          if(brickHealth[col][row+1] == 1 || brickHealth[col][row+1] == 2 || brickHealth[col][row+1] == 4 || brickHealth[col][row+1] == 5){ 
            if((row+1)*BRICK_SIZE <= y+size){
              currentySpeed = 0;
            }
          }
        }
        
          x+=currentxSpeed;
      }
  }
  
}
  
