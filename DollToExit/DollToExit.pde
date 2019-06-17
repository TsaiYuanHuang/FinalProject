PImage[] bg = new PImage[3];
PImage[] doll = new PImage[7];
PImage[] brick = new PImage[5];
PImage leg,hand,fire,enemyImg,heart;
PImage start,lose;
PImage ex1,ex2,ex3,alert;

PFont font;

final int RUN1_TIMER = 1800;
final int RUN2_TIMER = 3600;
final int RUN3_TIMER = 3600;
int gameTimer = RUN1_TIMER;

Doll player;
Enemy enemy;

int[][] brickHealth = new int [16][16];
boolean[][] walked = new boolean [16][16];

/*
health
1:block
2:fast
3:open
4:door
5:exit
6:fire
7:hand
8:leg
*/
int limbNum; 

final int BRICK_COL_COUNT = 16;
final int BRICK_ROW_COUNT = 16;
final int BRICK_SIZE = 50;

float dollX, dollY;
float dollSize = 4*BRICK_SIZE/5;
float xSpeed = 3;
float ySpeed = 5;
boolean leftState = false;
boolean rightState = false;
boolean downState = true;

int life = 5;

float xEnemy = 8*BRICK_SIZE;
float yEnemy = 7*BRICK_SIZE;

final int GAME_START = 0;
final int GAME_PR_1 = 1, GAME_RUN_1 = 2;
final int GAME_PR_2 = 3, GAME_RUN_2 = 4;
final int GAME_PR_3 = 5, GAME_RUN_3 = 6;
final int GAME_LOSE = 7, GAME_WIN = 8;
final int GAME_DIALOG = 9;

int gameState = 0;
boolean mapDecide = false; // decide which map to choose in the very beginning of the run
int mapNum; 


// dialog
PFont words;
PImage dialogWhite,dialogRed,openingBg;
PImage openHuman1, openHuman2, openHuman3;
PImage openDoll1, openDoll2, openDoll3, openDoll4;

final float dialogX = 50;
final float dialogY = 700;
final float dialogW = 900;
final float dialogH = 250;
final float wordsX = 180;
final float wordsY = 760;

float openHumanX = 60;
float openHumanY = 300;
float openDollX = 680;
float openDollY = 300;

String hiro = "主角：";
String dollDialog = "人偶：";
boolean nextCheck = false;
int stringCheck = 0;


// ending 
PImage[] runDolls = new PImage[8];
PImage[] runHumans = new PImage[3];
PImage endingBg,dialog,endHuman,blood,bloodDoll,word1,word2,word3;

boolean[] keys = new boolean[2];
Player p1 = new Player( 100, 670 );
PVector location, velocity;
String lastKey;

int humanX,humanY;

int currentFrame;
int numFrames=3;
import processing.video.*;
import ddf.minim.*;
Movie movie;
Movie endMovie;
Minim minim;
AudioPlayer song;
int gameTimerEnding,endTimer;

boolean isWin = false;





void setup(){
  size(1000,1000);
  
  // load bg
  for(int i=0; i<bg.length; i++) { bg[i] = loadImage("img/bg"+i+".jpg"); }
  // load doll
  for(int i=0; i<doll.length; i++) { doll[i] = loadImage("img/doll"+i+".png"); }
  // load brick
  for(int i=0; i< brick.length; i++) { brick[i] = loadImage("img/brick"+i+".jpeg"); }
  // load other
  leg = loadImage("img/leg.png");
  hand = loadImage("img/hand.png");
  fire = loadImage("img/fire.png");
  enemyImg = loadImage("img/enemy.png");
  heart = loadImage("img/heart.png");
  //start = loadImage("img/start.jpeg");
  lose = loadImage("img/lose.jpeg");
  ex1 = loadImage("img/explanation1.jpeg");
  ex2 = loadImage("img/explanation2.jpeg");
  ex3 = loadImage("img/explanation3.jpeg");
  //alert = loadImage("img/alert.png");
  
  
  
  // dialog
  words = createFont("font/PingFang Regular_0.ttf",12);
  openingBg = loadImage("img/opening.png");
  dialogWhite = loadImage("img/dialog.png");
  dialogRed = loadImage("img/dialogRed.png");
  openHuman1 = loadImage("img/openhuman1.png");
  openHuman2 = loadImage("img/openhuman2.png");
  openHuman3 = loadImage("img/openhuman3.png");
  openDoll1 = loadImage("img/opendoll1.png");
  openDoll2 = loadImage("img/opendoll2.png");
  openDoll3 = loadImage("img/opendoll3.png");
  openDoll4 = loadImage("img/opendoll4.png");
  
  // ending
  endingBg = loadImage( "img/bg.png" );
  
  // ending DIALOG
  dialog = loadImage( "img/dialog.png" );
  dialogRed = loadImage( "img/dialogRed.png" );
  
  // ending DOLL WALKING
  for (int i=0; i<8; i++){
    runDolls[i] = loadImage("img/runDoll" + (i+1) + ".png");
  }
  blood = loadImage("img/blood.png");
  bloodDoll = loadImage("img/bloodDoll.png");
  keys[0] = false;
  keys[1] = false;
  lastKey = "RIGHT";
  
  // ending HUMAN WALKING
  currentFrame = 0;
  for (int i=0; i<numFrames; i++){
    runHumans[i] = loadImage("img/runHuman" + (i+1) + ".png");
  }
  endHuman = loadImage( "img/endHuman.png" );
  humanX=900;
  humanY=670;
  
  //// ending MOVIE
  //movie = new Movie(this, "hit.mov");
  //endMovie = new Movie(this, "end.mov");
  //gameTimerEnding = 20;
  //endTimer = 20;
  
  //// ending SONG
  //minim = new Minim(this);
  //song = minim.loadFile("streetSound.mp3");
  //song.play();
  
  word1 = loadImage("img/word1.png");
  word2 = loadImage("img/word2.png");
  word3 = loadImage("img/word3.png");
  
  
}

  
void movieEvent(Movie m){
  m.read();
}


void draw(){
  switch(gameState){
    case GAME_START:
        background(0);
        
        
        
        if(key == 's'){
          gameState = GAME_DIALOG;
        }
        
    break;
    
    
    case GAME_DIALOG: // dialog
        
        background(openingBg);
        
        if(stringCheck == 1) image(openHuman1,openHumanX,openHumanY);
        if(stringCheck == 2) image(openHuman2,openHumanX,openHumanY);
        if(stringCheck == 3) image(openHuman2,openHumanX,openHumanY);
        if(stringCheck == 4) image(openHuman2,openHumanX,openHumanY);
        if(stringCheck == 5) image(openHuman2,openHumanX,openHumanY);
        if(stringCheck == 6) {image(openHuman2,openHumanX,openHumanY); image(openDoll1,openDollX,openDollY);}
        if(stringCheck == 7) {image(openHuman1,openHumanX,openHumanY); image(openDoll1,openDollX,openDollY);}
        if(stringCheck == 8) {image(openHuman1,openHumanX,openHumanY); image(openDoll2,openDollX,openDollY);}
        if(stringCheck == 9) {image(openHuman3,openHumanX,openHumanY); image(openDoll2,openDollX,openDollY);}
        if(stringCheck == 10) {image(openHuman3,openHumanX,openHumanY); image(openDoll2,openDollX,openDollY);}
        if(stringCheck == 11) {image(openHuman3,openHumanX,openHumanY); image(openDoll3,openDollX,openDollY);}
        if(stringCheck == 12) {image(openHuman3,openHumanX,openHumanY); image(openDoll3,openDollX,openDollY);}
        if(stringCheck == 13) {image(openHuman3,openHumanX,openHumanY); image(openDoll3,openDollX,openDollY);}
        if(stringCheck == 14) {image(openHuman3,openHumanX,openHumanY); image(openDoll3,openDollX,openDollY);}
        if(stringCheck == 15) {image(openHuman1,openHumanX,openHumanY); image(openDoll3,openDollX,openDollY);}
        if(stringCheck == 16) {image(openHuman2,openHumanX,openHumanY); image(openDoll3,openDollX,openDollY);}
        if(stringCheck == 17) {image(openHuman2,openHumanX,openHumanY); image(openDoll2,openDollX,openDollY);}
        if(stringCheck == 18) {image(openHuman2,openHumanX,openHumanY); image(openDoll2,openDollX,openDollY);}
        if(stringCheck == 19) {image(openHuman1,openHumanX,openHumanY); image(openDoll1,openDollX,openDollY);}
        if(stringCheck == 20) {image(openHuman2,openHumanX,openHumanY); image(openDoll2,openDollX,openDollY);}
        if(stringCheck == 21) {image(openHuman2,openHumanX,openHumanY); image(openDoll2,openDollX,openDollY);}
        if(stringCheck == 22) {image(openHuman2,openHumanX,openHumanY); image(openDoll4,openDollX,openDollY);}
        if(stringCheck == 23) {image(openHuman1,openHumanX,openHumanY); image(openDoll1,openDollX,openDollY);}
        if(stringCheck == 24) {image(openHuman3,openHumanX,openHumanY); image(openDoll1,openDollX,openDollY);}
        if(stringCheck == 25) {
          image(openHuman3,openHumanX,openHumanY);
          openHumanX -= 20;
          if(openHumanX <= -300){
            openHumanX = -300;
          }
          image(openDoll1,openDollX,openDollY);
        }
        if(stringCheck == 26) image(openDoll2,openDollX,openDollY);
        if(stringCheck == 27) image(openDoll2,openDollX,openDollY);
        if(stringCheck == 28) image(openDoll4,openDollX,openDollY);
        
        if(stringCheck >= 1 && stringCheck <= 28) image(dialogWhite,dialogX,dialogY,dialogW,dialogH);
        
        fill(255);
        textFont(words,24);
        if(stringCheck == 1) text(hiro + "\n果然…亂七八糟的。",wordsX,wordsY);
        if(stringCheck == 2) text(hiro + "\n……唉。",wordsX,wordsY);
        if(stringCheck == 3) text("(翻東西的聲音)",wordsX,wordsY);
        if(stringCheck == 4) text(hiro + "\n嗯？\t這個是？",wordsX,wordsY);
        if(stringCheck == 5) text(hiro + "\n嗯？\t這個是？\n……都破破爛爛的了，放很久了嗎？",wordsX,wordsY);
        if(stringCheck == 6) text(dollDialog + "\n你好。",wordsX,wordsY);
        if(stringCheck == 7) text(hiro + "\n… …蛤？",wordsX,wordsY);
        if(stringCheck == 8) text(dollDialog + "\n好久沒見到人類了，感覺真懷念呀─",wordsX,wordsY);
        if(stringCheck == 9) text(hiro + "\n噫…！",wordsX,wordsY);
        if(stringCheck == 10) text(hiro + "\n噫…！\n娃、娃娃說話了！",wordsX,wordsY);
        if(stringCheck == 11) text(dollDialog + "\n痛！\t你小心一點、身體都要散了！",wordsX,wordsY);
        if(stringCheck == 12) text(hiro + "\n哇啊…",wordsX,wordsY);
        if(stringCheck == 13) text(hiro + "\n哇啊… 好噁。",wordsX,wordsY);
        if(stringCheck == 14) text(dollDialog + "\n噁心？\t你這沒禮貌的傢伙，這是和好久不見的朋友說的話嗎！",wordsX,wordsY);
        if(stringCheck == 15) text(hiro + "\n誰和你是朋友啊！",wordsX,wordsY);
        if(stringCheck == 16) text(dollDialog + "\n你…！",wordsX,wordsY);
        if(stringCheck == 17) text(dollDialog + "\n你…！\t很好，沒關係，",wordsX,wordsY);
        if(stringCheck == 18) text(dollDialog + "\n你…！\t很好，沒關係，\n反正你很快就不能再說出這種話了。",wordsX,wordsY);
        if(stringCheck == 19) text(hiro + "\n… …蛤？\t又在說什麼鬼話。",wordsX,wordsY);
        if(stringCheck == 20) text(dollDialog + "\n你看我的身體，看起來就快要壞光了對吧？",wordsX,wordsY);
        if(stringCheck == 21) text(dollDialog + "\n你看我的身體，看起來就快要壞光了對吧？\n這樣的話，不就應該找找另外一副身體吧？",wordsX,wordsY);
        if(stringCheck == 22) text(dollDialog + "\n你看我的身體，看起來就快要壞光了對吧？\n這樣的話，不就應該找找另外一副身體吧？\n現在眼前不就有一個嗎。",wordsX,wordsY);
        if(stringCheck == 23) text(dollDialog + "\n…",wordsX,wordsY);
        if(stringCheck == 24) text(dollDialog + "\n… …唔…！",wordsX,wordsY);
        if(stringCheck == 25) text("(關門聲)",wordsX,wordsY);
        if(stringCheck == 26) text(dollDialog + "\n呵...啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈！！",wordsX,wordsY);
        if(stringCheck == 27) text(dollDialog + "\n呵...啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈！！\n以為這樣就能逃掉嗎？",wordsX,wordsY);
        if(stringCheck == 28) text(" ",wordsX,wordsY);
        if(stringCheck == 29) {
          background(0);
          image(dialogRed,dialogX,dialogY,dialogW,dialogH);
          fill(255,0,0);
          text(dollDialog + "\n別開玩笑了。",wordsX,wordsY);
        }
        if(stringCheck == 30){
          gameState = GAME_PR_1;
        }
    
    break;
    
    case GAME_PR_1:
        
        background(0);
        
        mapDecide = false; // decide run1 map
        limbNum = 4; // initialize limb number
        
        // init movestate
        leftState = false;
        rightState = false;
        downState = true;
        
        // init time
        font = createFont("font/jackeyfont.ttf",30);
        textFont(font);
        gameTimer = RUN1_TIMER;
        
        // init life
        life = 5;
        
        // init walked
        for(int i=0; i<walked.length; i++){
          for(int j=0; j<walked.length; j++){
            walked[i][j] = false;
         }
        }
        
        // load explanation image
        pushMatrix();
        translate(250,150);
        image(ex1,0,0,500,500);
        
        textAlign(CENTER,TOP);
        textSize(20);
        fill(#ffffff);
        if(mouseX >= 395 && mouseX <= 600 && mouseY >= 655 && mouseY <= 670){
          fill(#fff200);
          if(mousePressed){
            mousePressed = false;
            gameState = GAME_RUN_1;
           
          }
        }
        text("CLICK HERE TO START",250,500);
        
        
        popMatrix();
      
    break;
    
    case GAME_RUN_1:
    
      background(0);
      
      pushMatrix();
      translate(100,100);
      image(bg[0],0,0);
     
      // decide map
      if( mapDecide == false ){
        // init player
        dollX = 5*BRICK_SIZE;
        dollY = 9*BRICK_SIZE;
        player = new Doll(dollX,dollY);
        
        // choose map
        int count1 = floor(random(2));
        if(count1 == 1){
          run1_1();
          mapNum = 1;
        }else{
          run1_2();
          mapNum = 2;
        }
        mapDecide = !mapDecide;
      }
      
      
      // game run
    if( mapDecide ){  
        if( mapNum == 1 ){
            limb1_1();
            exit1();
        }

        if( mapNum == 2 ){
            limb1_2();
            exit1();
        }

        // draw brick images 
        drawImage();
        
        // player
        player.display();
        player.move();
        player.changeGamestate();
        
        // time UI
        timeUI();
        
        // life UI
        heartUI();

    }
    popMatrix();
    
    
    if(key == 'b'){
      keyPressed = false;
      gameState = GAME_PR_2;
    }
      
    break;
    
    case GAME_PR_2:
    
        background(0);
    
        // decide run1 map
        mapDecide = false;
        // initialize limb number
        limbNum = 6;
        
        // init movestate
        leftState = false;
        rightState = false;
        downState = true;
        
        // init time
        font = createFont("font/jackeyfont.ttf",30);
        textFont(font);
        gameTimer = RUN2_TIMER;
        
        // init life
        life = 5;
        
        // init walked
        for(int i=0; i<walked.length; i++){
          for(int j=0; j<walked.length; j++){
            walked[i][j] = false;
         }
        }
        
        // load explanation image
        pushMatrix();
        translate(250,150);
        image(ex2,0,0,500,500);
        
        textAlign(CENTER,TOP);
        textSize(20);
        fill(#ffffff);
        if(mouseX >= 395 && mouseX <= 600 && mouseY >= 655 && mouseY <= 670){
          fill(#fff200);
          if(mousePressed){
            mousePressed = false;
            gameState = GAME_RUN_2;
          }
        }
        text("CLICK HERE TO START",250,500);
        
        popMatrix();
        
        // change state
        //gameState = GAME_RUN_2;
        
    break;
    
    case GAME_RUN_2:
    
      background(0);
      
      pushMatrix();
      translate(100,100);
      image(bg[1],0,0);
     
      // decide map
      if( mapDecide == false ){
        // init player
        dollX = 3*BRICK_SIZE;
        dollY = 12*BRICK_SIZE;
        player = new Doll(dollX,dollY);
        
        // choose map
        int count1 = floor(random(2));
        if(count1 == 1){
          run2_1();
          mapNum = 1;
        }else{
          run2_2();
          mapNum = 2;
        }
        mapDecide = !mapDecide;
      }
      
      // game run
      
      if( mapDecide == true){
        
        if( mapNum == 1 ){
          limb2_1();
          exit2();
          open2_1();
          door2_1();
        }

        if( mapNum == 2 ){ 
          limb2_2();
          exit2();
          open2_2();
          door2_2();
        }

        
        // draw images
        drawImage();
        
        // draw doll
        player.display();
        player.move();
        player.changeGamestate();
        
        // time UI
        timeUI();
        
        // life UI
        heartUI();
      }
      
      popMatrix();
      
     
     if(key =='c'){
      keyPressed = false;
      gameState =  GAME_PR_3;
    }
      
      
    break;
    
    case GAME_PR_3:
    
        background(0);
        
        // decide run1 map
        mapDecide = false;
        // initialize limb number
        limbNum = 6;
        
        // init movestate
        leftState = false;
        rightState = false;
        downState = true;
        
        // init time
        font = createFont("font/jackeyfont.ttf",30);
        textFont(font);
        gameTimer = RUN3_TIMER;
        
        // init life
        life = 5;
        
        // init walked
        for(int i=0; i<walked.length; i++){
          for(int j=0; j<walked.length; j++){
            walked[i][j] = false;
         }
        }
        
        // load explanation image
        pushMatrix();
        translate(250,150);
        image(ex3,0,0,500,500);
        
        textAlign(CENTER,TOP);
        textSize(20);
        fill(#ffffff);
        if(mouseX >= 395 && mouseX <= 600 && mouseY >= 655 && mouseY <= 670){
          fill(#fff200);
          if(mousePressed){
            mousePressed = false;
            gameState = GAME_RUN_3;
           
          }
        }
        text("CLICK HERE TO START",250,500);
        
        
        popMatrix();
      
    break;
    
    case GAME_RUN_3:
      background(0);
      
      pushMatrix();
      translate(100,100);
      image(bg[2],0,0);
     
      // decide map
      if( mapDecide == false ){
        dollX = 3*BRICK_SIZE;
        dollY = 12*BRICK_SIZE;
        player = new Doll(dollX,dollY);
        enemy = new Enemy(xEnemy,yEnemy);
        
        // choose map
        int count1 = floor(random(2));
        if(count1 == 1){
          run3_1();
          mapNum = 1;
        }else{
          run3_2();
          mapNum = 2;
        }
        mapDecide = !mapDecide;
      }
      
      // game run
      
      if( mapDecide == true){
        
        if( mapNum == 1 ){
          limb3_1();
          exit3();
          open3_1();
          door3_1();
        }

        if( mapNum == 2 ){
          limb3_2();
          exit3();
          open3_2();
          door3_2();
        }

        // draw images
        drawImage();
        
        // draw doll
        player.display();
        player.move();
        player.changeGamestate();
        
        enemy.display();
        enemy.shoot();
        enemy.checkCollision(player);
        
        // time UI
        timeUI();
        
        // life UI
        heartUI();
      }
      
      popMatrix();
      
      if(key =='d'){
      keyPressed = false;
      gameState =  GAME_WIN;
    }
      
      
  
    break;
    
    case GAME_LOSE:
    
    background(0);
    
    pushMatrix();
    translate(100,0);
    image(lose,0,0,800,800);
    
    popMatrix();
    
    textAlign(CENTER,TOP);
    textSize(20);
    
    fill(#ffffff);
    if(mouseX >= 440 && mouseX <= 555 && mouseY >= 830 && mouseY <= 850){
      fill(#fff200);
      if(mousePressed){
         mousePressed = false;
         gameState = GAME_START; 
       }
     }
     text("PLAY AGAIN",500,820);
     
     
    
    break;
    
    case GAME_WIN: // ending 
    
    if(!isWin){
      frameRate(20);
      // ending MOVIE
      movie = new Movie(this, "hit.mov");
      endMovie = new Movie(this, "end.mov");
      gameTimerEnding = 20;
      endTimer = 20;
      
      // ending SONG
      minim = new Minim(this);
      song = minim.loadFile("streetSound.mp3");
      song.play();
      
      isWin = true;
    }
    
    if(isWin){
      background(0);
      image( endingBg, width/2, height/2 );
      
      //BLACKLIGHT
      loadPixels();
      for (int x = 0; x < endingBg.width; x++ ) {
        for (int y = 0; y < endingBg.height; y++ ) {
          int loc = x + y*endingBg.width;
          float r = red (endingBg.pixels[loc]);
          float g = green (endingBg.pixels[loc]);
          float b = blue (endingBg.pixels[loc]);
          float distance = dist(x,y,location.x+10,location.y+10);
          float adjustBrightness = map(distance, 0,150,1,0);
          r *= adjustBrightness;
          g *= adjustBrightness;
          b *= adjustBrightness;
          r = constrain(r,0,255);
          g = constrain(g,0,255);
          b = constrain(b,0,255);
          color c = color(r,g,b);
          pixels[loc] = c;
        }
      }
      updatePixels();  
      
      //PLAYER
      p1.drawPlayer();
      p1.loopFrame();
      p1.movePlayer();
      p1.constrainPlayer();
      
      //HUMAN
      int i = (currentFrame ++) % numFrames;
      image(runHumans[i], humanX, humanY);
      
      //MOVIE
      
      pushStyle();
      imageMode(CENTER);
      if(location.x+50>=humanX){
      movie.play();
      image(movie, 500, 500,width,height);
      }
      if (movie.time() == movie.duration()) { 
        image(endingBg,width/2, height/2);
        image(endHuman,humanX,humanY);
        image(blood,800,670);
        image(bloodDoll,800,670);
        gameTimerEnding--;
      }
      if(gameTimerEnding<=0){
        image(dialog,width/2,150);
        text(".........",100,100);
        endTimer--;
      }
      if(endTimer<=0){
        gameTimerEnding=3;
        endMovie.play();
        image(endMovie, 500, 500,width,height);
      }
      popStyle();
      
      
      //DIALOG
      pushStyle();
      imageMode(CENTER);
      if(location.x>=200 && location.x<=250){
        image(dialog,width/2,150);
        image(word1,350,100);
      }
      
      if(location.x>=500 && location.x<=550){
        image(dialog,width/2,150);
        image(word2,350,100);
      }
      
      if(location.x>=750 && location.x<=800){
        image(dialogRed,width/2,150);
        image(word3,350,100);
      }
      popStyle();
    }
    
    
    
    
    break;
  }
}






// isHit
boolean isHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh){
  return  ax + aw > bx &&    // a right edge past b left
        ax < bx + bw &&    // a left edge past b right
        ay + ah > by &&    // a top edge past b bottom
        ay < by + bh;
}

// radian
float getRadiansDifference(float a, float b){
  float result = b - a;
  if(result > PI) result -= TWO_PI;
  else if(result < - PI) result += TWO_PI;
  return abs(result);
}

// time UI
void timeUI(){
  textAlign(CENTER,TOP);
  String timeString = convertFrameToTimeString(gameTimer);
  fill(getTimeTextColor(gameTimer));
  text(timeString,400,0);
  
  gameTimer --;
  if(gameTimer<=0) gameState = GAME_LOSE;
}

color getTimeTextColor(int frames){
  if(frames >= 1800){
    return #ffffff;
  }else if(frames >= 1200){
    return #ffcc00;
  }else if(frames >= 600){
    return #ff6600;
  }

  return #ff0000;
}


String convertFrameToTimeString(int frames){
  String result = "";
  float totalSeconds = float(frames) / 60;
  result += nf(floor(totalSeconds/60), 2);
  result += ":";
  result += nf(floor(totalSeconds%60), 2);
  return result;
}


// heart UI
void heartUI(){
  for(int i=0; i<player.life; i++){
    image(heart,320+30*i,40,30,30);
  }
  
}



// maps
// map1
void run1_1(){
  for(int i=0; i<brickHealth.length; i++){
      for(int j=0; j<brickHealth.length; j++){
        brickHealth[i][j] = 0;
        
        // health 1: normal
        if(j==4 || j==11) {if(i>=4 && i<12) brickHealth[i][j] = 1;}
        if(i==4) {if(j>=4 && j<12) brickHealth[i][j] = 1;}
        if(i==11) {if(j==4 || (j>=6 &&  j<12)) brickHealth[i][j] = 1;}
        if(i==5 && j==5) brickHealth[i][j] = 1;
        if(i==6) {if(j==7 || j==8 || j==9) brickHealth[i][j] = 1;}
        if(i==7) {if(j==5 || j==7) brickHealth[i][j] = 1; }
        if(i==9) {if(j==5 || j==6 || j==8 || j==10) brickHealth[i][j] = 1;}
        if(i==10 && j==8) brickHealth[i][j] = 1;

        
        // health 6: fire
        if(i==5 && j==5) brickHealth[i][j] = 6;
        if(i==7 && j==9) brickHealth[i][j] = 6;
        if(i==11 && j==9) brickHealth[i][j] = 6;

      }
    }
}

void run1_2(){
  for(int i=0; i<brickHealth.length; i++){
      for(int j=0; j<brickHealth.length; j++){
        brickHealth[i][j] = 0;
        
        // health 1: normal
        if(j==4 || j==11) {if(i>=4 && i<12) brickHealth[i][j] = 1;}
        if(i==4) {if(j>=4 && j<12) brickHealth[i][j] = 1;}
        if(i==11) {if(j==4 || (j>=6 &&  j<12)) brickHealth[i][j] = 1;}
        if(i==5 && j==7) brickHealth[i][j] = 1;
        if(i==6) {if(j==5 || j==7 || j==9 || j==10) brickHealth[i][j] = 1;}
        if(i==8) {if(j==8 || j==10) brickHealth[i][j] = 1;}
        if(i==9) {if(j==6 || j==7 || j==8) brickHealth[i][j] = 1;}
        if(i==10 && j==7) brickHealth[i][j] = 1;
        if(i==10 && j==10) brickHealth[i][j] = 1;

        // health 6: fire
        if(i==4 && j==6) brickHealth[i][j] = 6;
        if(i==8 && j==6) brickHealth[i][j] = 6;
        
        
      }
    }
  
}

void exit1(){
  for(int i=0; i<brickHealth.length; i++){
    for(int j=0; j<brickHealth.length; j++) {
      if(limbNum <=0) {
        brickHealth[11][5] = 0;
        continue;
      }else{
      if(i==11 && j==5) brickHealth[i][j] = 5;
      }
      
    }
  }
}


void limb1_1(){
  for(int i=0; i<brickHealth.length; i++){
              for(int j=0; j<brickHealth.length; j++){
                
                if(walked[i][j]){
                  brickHealth[i][j] = 0;
                  
                  continue;
                }
                if(i==5 && j==7) brickHealth[i][j] = 7;
                if(i==6 && j==5) brickHealth[i][j] = 7;
                if(i==10){if(j==5 || j==10) brickHealth[i][j] = 7;}
              }
              
  }
}

void limb1_2(){
  for(int i=0; i<brickHealth.length; i++){
              for(int j=0; j<brickHealth.length; j++){
                
                if(walked[i][j]){
                  brickHealth[i][j] = 0;      
                  
                  continue;
                }
                if(i==5 && j==5) brickHealth[i][j] = 7;
                if(i==9 && j==10) brickHealth[i][j] = 7;
                if(i==10){if(j==6 || j==8) brickHealth[i][j] = 7;}
              }
              
            }
}




// map2
void run2_1(){
  for(int i=0; i<brickHealth.length; i++){
      for(int j=0; j<brickHealth.length; j++){
        brickHealth[i][j] = 0;
        
        // health 1: normal
        if(i==2 || i==13) {if(j>=2 && j<14) brickHealth[i][j] = 1;}
        if(j==2 || j==13) {if(i>=2 && i<14) brickHealth[i][j] = 1;}
        if(i==3) {if(j==7 || j==11) brickHealth[i][j] = 1;}
        if(i==4) {if(j==3 || j==4 || j==6 || j==7) brickHealth[i][j] = 1;}
        if(i==5) {if(j==10 || j==11 || j==12) brickHealth[i][j] = 1;}
        if(i==6) {if(j==5 || j==7 || j==11) brickHealth[i][j] = 1;}
        if(i==7) {if(j==4 || j==5 || j==7 || j==8 || j==10) brickHealth[i][j] = 1;} 
        if(i==8) {if(j==9 || j==10) brickHealth[i][j] = 1;}
        if(i==9) {if(j==4 || j==5 || j==6) brickHealth[i][j] = 1;}
        if(i==10) {if(j==4 || j==9 || j==10 || j==11 || j==12) brickHealth[i][j] = 1;}
        if(i==11) {if(j==4 || j==9 || j==10) brickHealth[i][j] = 1;}
        if(i==12) {if(j==4 || j==7) brickHealth[i][j] = 1;}
 
        // health 2: fast
        if(j==2) {if(i==8 || i==9) brickHealth[i][j] = 2;}
        if(j==7) {if(i==9 || i==10) brickHealth[i][j] = 2;}
        if(j==9) {if(i==4 || i==5) brickHealth[i][j] = 2;}
        
        // health 6: fire
        if(i==8 && j==13) brickHealth[i][j] = 6;
        if(j==2) {if(i==10 || i==12) brickHealth[i][j] = 6;}
        
      }
    }
}

void run2_2(){
  for(int i=0; i<brickHealth.length; i++){
      for(int j=0; j<brickHealth.length; j++){
        brickHealth[i][j] = 0;  
        
        // health 1: normal
        if(i==2 || i==13) {if(j>=2 && j<14) brickHealth[i][j] = 1;}
        if(j==2) {if(i>=2 && i<7) brickHealth[i][j] = 1;}
        if(j==2) {if(i>=8 && i<14) brickHealth[i][j] = 1;}
        if(j==13) {if(i>=2 && i<14) brickHealth[i][j] = 1;}
        if(i==3) {if(j==8 || j==11) brickHealth[i][j] = 1;}
        if(i==4) {if(j==5 || j==6 || j==11) brickHealth[i][j] = 1;}
        if(i==5) {if(j==3 || j==4 || j==5 || j==6) brickHealth[i][j] = 1;}
        if(i==6) {if(j==9 || j==10) brickHealth[i][j] = 1;}
        if(i==7) {if(j==5 || j==6) brickHealth[i][j] = 1;} 
        if(i==8) {if(j==5 || j==7 || j==8 || j==10 || j==11) brickHealth[i][j] = 1;}
        if(i==9) {if(j==4 || j==8 || j==10) brickHealth[i][j] = 1;}
        if(i==10) {if(j==4 || j==5 || j==12) brickHealth[i][j] = 1;}
        if(i==11) {if(j==8 || j==9 || j==11 || j==12) brickHealth[i][j] = 1;}
        if(i==12 && j==4) brickHealth[i][j] = 1;
 
        // health 2: fast
        if(j==6) {if(i==10 || i==11) brickHealth[i][j] = 2;}
        if(j==8) {if(i==5 || i==6) brickHealth[i][j] = 2;}
        if(j==13) {if(i==6 || i==7) brickHealth[i][j] = 2;}
        

        // health 6: fire
        
        if(i==7 && j==2) brickHealth[i][j] = 6;
        if(i==10 && j==3) brickHealth[i][j] = 6;
        if(i==12 && j==8) brickHealth[i][j] = 6;
        if(j==11) {if(i==5 || i==6) brickHealth[i][j] = 6;}
        
      }
    }
}

void exit2(){
  for(int i=0; i<brickHealth.length; i++){
    for(int j=0; j<brickHealth.length; j++) {
      if(limbNum <=0) {
        brickHealth[13][3] = 0;
        continue;
      }else{
      if(i==13 && j==3) brickHealth[i][j] = 5;
      }
    }
  }
}

void open2_1(){
  for(int i=0; i<brickHealth.length; i++){
    for(int j=0; j<brickHealth.length; j++){
      if(walked[i][j]){
        brickHealth[i][j] = 0;
        continue;
      }
      if(i==3 && j==3) brickHealth[i][j] = 3;
    }
  }
}

void door2_1(){
  for(int i=0; i<brickHealth.length; i++){
    for(int j=0; j<brickHealth.length; j++){
      if(brickHealth[3][3] == 0){
        brickHealth[11][7] = 0;
      }
      if(i==11 && j==7) brickHealth[i][j] = 4;
    }
  }
}

void open2_2(){
  for(int i=0; i<brickHealth.length; i++){
    for(int j=0; j<brickHealth.length; j++){
      if(walked[i][j]){
        brickHealth[i][j] = 0;
        continue;
      }
      if(i==12 && j==12) brickHealth[i][j] = 3;
    }
  }
}

void door2_2(){
  for(int i=0; i<brickHealth.length; i++){
    for(int j=0; j<brickHealth.length; j++){
      if(brickHealth[12][12] == 0){
        brickHealth[4][8] = 0;
      }
      if(i==4 && j==8) brickHealth[i][j] = 4;
    }
  }
}

void limb2_1(){
  for(int i=0; i<brickHealth.length; i++){
              for(int j=0; j<brickHealth.length; j++){
                if(walked[i][j]){
                  brickHealth[i][j] = 0;
                  
                  continue;
                }
                if(i==3 && j==10) brickHealth[i][j] = 8;
                if(i==6) {if(j==4 || j==12) brickHealth[i][j] = 8;}
                if(i==7 && j==9) brickHealth[i][j] = 8;
                if(i==11) {if(j==5 || j==11) brickHealth[i][j] = 8;}
              }
            }
}

void limb2_2(){
  for(int i=0; i<brickHealth.length; i++){
              for(int j=0; j<brickHealth.length; j++){
                if(walked[i][j]){
                  brickHealth[i][j] = 0;
                  
                  continue;
                }
                if(i==4) {if(j==4 || j==10) brickHealth[i][j] = 8;}
                if(i==8 && j==6) brickHealth[i][j] = 8;
                if(i==9) {if(j==3 || j==11) brickHealth[i][j] = 8;}
                if(i==12 && j==5) brickHealth[i][j] = 8;
              }
            }
}



// map3
void run3_1(){
  for(int i=0; i<brickHealth.length; i++){
      for(int j=0; j<brickHealth.length; j++){
        brickHealth[i][j] = 0;
        
        // health 1: normal
        if(i==2 || i==13) {if(j>=2 && j<14) brickHealth[i][j] = 1;}
        if(j==2 || j==13) {if(i>=2 && i<14) brickHealth[i][j] = 1;}
        if(i==3 && j==9) brickHealth[i][j] = 1;
        if(i==4) {if(j==3 || j==5 || j==7 || j==11 || j==12) brickHealth[i][j] = 1;}
        if(i==5) {if(j==7 || j==8 || j==9 || j==11) brickHealth[i][j] = 1;}
        if(i==6) {if(j==3 || j==8 || j==11) brickHealth[i][j] = 1;}
        if(i==7) {if(j==6 || j==7) brickHealth[i][j] = 1;}
        if(i==8) {if(j==6 || j==10 || j==11 || j==12) brickHealth[i][j] = 1;}
        if(i==9) {if(j==5 || j==6 || j==7 || j==10) brickHealth[i][j] = 1;}
        if(i==10) {if(j==5 || j==10 || j==12) brickHealth[i][j] = 1;}
        if(i==11) {if(j==5 || j==7 || j==8) brickHealth[i][j] = 1;}
        if(i==12) {if(j==4 || j==9 || j==11) brickHealth[i][j] = 1;}
 
        // health 2: fast
        if(j==3) {if(i==8 || i==9) brickHealth[i][j] = 2;}
        if(j==5) {if(i==5 || i==6) brickHealth[i][j] = 2;}
        if(j==8) {if(i==7 || i==8) brickHealth[i][j] = 2;}
        
        // health 6: fire
        if(i==2 && j==7) brickHealth[i][j] = 6;
        if(i==5 && j==2) brickHealth[i][j] = 6;
        if(i==7 && j==6) brickHealth[i][j] = 6;
        if(i==9 && j==8) brickHealth[i][j] = 6;
        if(i==10 && j==3) brickHealth[i][j] = 6;
        if(i==12 && j==13) brickHealth[i][j] = 6;
        if(i==13 && j==7) brickHealth[i][j] = 6;
        
      }
    }
}

void run3_2(){
  for(int i=0; i<brickHealth.length; i++){
      for(int j=0; j<brickHealth.length; j++){
        brickHealth[i][j] = 0;
        
        // health 1: normal
        if(i==2 || i==13) {if(j>=2 && j<14) brickHealth[i][j] = 1;}
        if(j==2 || j==13) {if(i>=2 && i<14) brickHealth[i][j] = 1;}
        if(i==3) {if(j==9 || j==11) brickHealth[i][j] = 1;}
        if(i==4) {if(j==5 || j==7 || j==8) brickHealth[i][j] = 1;}
        if(i==5) {if(j==5 || j==10 || j==12) brickHealth[i][j] = 1;}
        if(i==6) {if(j==5 || j==7 || j==10) brickHealth[i][j] = 1;}
        if(i==7) {if(j==6 || j==7 || j==8 || j==10 || j==11) brickHealth[i][j] = 1;}
        if(i==8) {if(j==5 || j==6 || j==8) brickHealth[i][j] = 1;}
        if(i==9) {if(j==3 || j==6 || j==7 || j==8 || j==11) brickHealth[i][j] = 1;}
        if(i==10) {if(j==7 || j==9 || j==11) brickHealth[i][j] = 1;}
        if(i==11) {if(j==4 || j==5 || j==7 || j==11 || j==12) brickHealth[i][j] = 1;}
        if(i==12) {if(j==5 || j==9) brickHealth[i][j] = 1;}
 
        // health 2: fast
        if(j==3) {if(i==6 || i==7) brickHealth[i][j] = 2;}
        if(j==5) {if(i==9 || i==10) brickHealth[i][j] = 2;}
        if(j==13) {if(i==8 || i==9) brickHealth[i][j] = 2;}
        
        // health 6: fire
        if(i==2 && j==7) brickHealth[i][j] = 6;
        if(i==5 && j==2) brickHealth[i][j] = 6;
        if(i==6 && j==8) brickHealth[i][j] = 6;
        if(i==7 && j==12) brickHealth[i][j] = 6;
        if(i==8 && j==2) brickHealth[i][j] = 6;
        if(i==10 && j==8) brickHealth[i][j] = 6;
        if(i==13 && j==7) brickHealth[i][j] = 6;
      }
    }
}

void exit3(){
  for(int i=0; i<brickHealth.length; i++){
    for(int j=0; j<brickHealth.length; j++) {
      if(limbNum <=0) {
        brickHealth[13][3] = 0;
        continue;
      }else{
      if(i==13 && j==3) brickHealth[i][j] = 5;
      }
    }
  }
}

void open3_1(){
  for(int i=0; i<brickHealth.length; i++){
    for(int j=0; j<brickHealth.length; j++){
      if(walked[i][j]){
        brickHealth[i][j] = 0;
        continue;
      }
      if(i==12 && j==10) brickHealth[i][j] = 3;
    }
  }
}

void door3_1(){
  for(int i=0; i<brickHealth.length; i++){
    for(int j=0; j<brickHealth.length; j++){
      if(brickHealth[12][10] == 0){
        brickHealth[3][5] = 0;
      }
      if(i==3 && j==5) brickHealth[i][j] = 4;
    }
  }
}

void open3_2(){
  for(int i=0; i<brickHealth.length; i++){
    for(int j=0; j<brickHealth.length; j++){
      if(walked[i][j]){
        brickHealth[i][j] = 0;
        continue;
      }
      if(i==12 && j==12) brickHealth[i][j] = 3;
    }
  }
}

void door3_2(){
  for(int i=0; i<brickHealth.length; i++){
    for(int j=0; j<brickHealth.length; j++){
      if(brickHealth[12][12] == 0){
        brickHealth[3][4] = 0;
      }
      if(i==3 && j==4) brickHealth[i][j] = 4;
    }
  }
}

void limb3_1(){
  for(int i=0; i<brickHealth.length; i++){
              for(int j=0; j<brickHealth.length; j++){
                  if(walked[i][j]){
                    brickHealth[i][j] = 0;
                    
                    continue;
                  }

                if(i==5 && j==12) brickHealth[i][j] = 7;
                if(i==12 && j==8) brickHealth[i][j] = 8;
                if(i==9 && j==12) brickHealth[i][j] = 8;
                if(i==3 && j==3) brickHealth[i][j] = 7;
                if(i==8 && j==5) brickHealth[i][j] = 7;
                if(i==6 && j==7) brickHealth[i][j] = 8;
              }
            }
}

void limb3_2(){
  for(int i=0; i<brickHealth.length; i++){
              for(int j=0; j<brickHealth.length; j++){
                  if(walked[i][j]){
                    brickHealth[i][j] = 0;
                    
                    continue;
                  
                }
                
                if(i==3 && j==8) brickHealth[i][j] = 7;
                if(i==6 && j==12) brickHealth[i][j] = 8;
                if(i==3 && j==3) brickHealth[i][j] = 8;
                if(i==7 && j==5) brickHealth[i][j] = 7;
                if(i==10 && j==12) brickHealth[i][j] = 7;
                if(i==10 && j==6) brickHealth[i][j] = 8;
              }
            }
}



void drawImage(){
  for(int i=0; i<brickHealth.length;i++){
          for(int j=0; j<brickHealth.length;j++){
            if( brickHealth [i][j] == 1 ) image(brick[0], i*BRICK_SIZE, j*BRICK_SIZE);
            if( brickHealth [i][j] == 2 ) image(brick[1], i*BRICK_SIZE, j*BRICK_SIZE);
            if( brickHealth [i][j] == 3 ) image(brick[2], i*BRICK_SIZE, j*BRICK_SIZE);
            if( brickHealth [i][j] == 4 ) image(brick[3], i*BRICK_SIZE, j*BRICK_SIZE);
            if( brickHealth [i][j] == 5 ) image(brick[4], i*BRICK_SIZE, j*BRICK_SIZE);
            if( brickHealth [i][j] == 6 ) image(fire, i*BRICK_SIZE, j*BRICK_SIZE);
            if( brickHealth [i][j] == 7 ) image(hand, i*BRICK_SIZE, j*BRICK_SIZE,BRICK_SIZE,BRICK_SIZE);
            if( brickHealth [i][j] == 8 ) image(leg, i*BRICK_SIZE, j*BRICK_SIZE,BRICK_SIZE,BRICK_SIZE);
          }
        }
}

// move keycode
void keyPressed(){
    if(gameState == GAME_WIN){
      if( key == CODED ){
        if( keyCode == LEFT ){
          keys[0] = true;
          lastKey = "LEFT";
        }
        if( keyCode == RIGHT ){
          keys[1] = true;
          lastKey = "RIGHT";
        }
      }
    }else{
      if(keyCode == LEFT) {
        leftState = true;
      }  
      if(keyCode == RIGHT) {
        rightState = true;
      }
    }
    
    
    if(gameState == GAME_DIALOG){
      if(key == ' ') {
        nextCheck = true;
        stringCheck += 1;
      }
    }else{
      if(key == ' ') {downState = !downState;}
    }
    
}

void keyReleased(){
    if(gameState == GAME_WIN){
      if(key == CODED){
        if(keyCode == LEFT){
          keys[0] = false;
        }
        if(keyCode == RIGHT){
          keys[1] = false;
        }
      }
    }else{
      if(keyCode == LEFT) {
        leftState = false;
      } 
      if(keyCode == RIGHT) {
        rightState = false;
      }
    }
    
    
    
    
    if(gameState == GAME_DIALOG){
      if(key == ' ') {
        nextCheck = false;
      }
    }
}
