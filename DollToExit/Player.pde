class Player{
  String state;
  int frame = 1;
  
  
  Player( float x, float y ){
    location = new PVector( x, y );
    velocity = new PVector( 0, 0 );
  }
  
  void drawPlayer(){
    image( runDolls[frame], location.x, location.y );
  }
  
  void movePlayer(){
    if( keys[0] == true ){
      velocity.x = -3;
    } else if( keys[1] == true ){
        velocity.x = 3;
      } else {
          velocity.x = 0;
        }    
    location.add(velocity);
  }
  
  void constrainPlayer(){
    location.x = constrain(location.x, 10, width - 10);
  }  
  
  String playerState(){
    if( keys[0] == false && lastKey == "LEFT" ){
      state = "IDLELEFT";
    } else if( keys[1] == false && lastKey == "RIGHT" ){
        state = "IDLERIGHT";
      }
    if( keys[0] == true ){
      state = "WALKINGLEFT";
    } else if( keys[1] == true ){
        state = "WALKINGRIGHT";
      }
    return state;
  }
  
  void loopFrame(){
    frame += 1;
    if( playerState() == "WALKINGRIGHT" ){
      if( frame >= 4 ){
        frame = 1;
      }
    }
    if( playerState() == "WALKINGLEFT" ){
      if( frame <= 4 ){
        frame = 5;
      }
      if( frame >= 8 ){
        frame = 5;
      }  
    }
    if( playerState() == "IDLERIGHT" ){
      frame = 0;
    }
    if( playerState() == "IDLELEFT" ){
      frame = 4;
    }
  }
}
