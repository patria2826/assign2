int bgx, gamestate, life, gsec, bombs;
float px, py, gx, gy, box, boy, e1x, e1y, e2x, e2y;
PImage start1, start2, end1, end2, bg1, bg2, enemy1, enemy2, player, hp, gift, BOMB;
final int GAMESTART=0, GAMEPLAY=1, GAMEWIN=2, GAMEOVER=3;
boolean upPressed = false, downPressed = false, leftPressed = false, rightPressed = false;
boolean bospeed = false, espeed = false;
void setup () {
  size(640, 480) ;
  background(255);
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  bg1 = loadImage("img/bg1.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  bg2 = loadImage("img/bg2.png");
  ///HP///
  hp = loadImage("img/hp.png");
  life = 70;
  ///ENEMY1///
  enemy1 = loadImage("img/enemy.png");
  e1x = -60;
  e1y = floor(random(1,430)); 
  ///ENEMY2///
  enemy2 = loadImage("img/enemy.png");
  e2x = -60;
  e2y = floor(random(1,430)); 
  ///PLAYER///
  player = loadImage("img/fighter.png");
  px = 590;
  py = 240;
  ///GIFT///
  gift = loadImage("img/treasure.png");
  gx=floor(random(0,600)); 
  gy=floor(random(1,439)); 
  ///BOMB///
  BOMB = loadImage("img/Moocs-element-gainbomb.png");
  box=-60;
  boy=floor(random(0,440));
    
  gamestate = GAMESTART;
}

void draw() {
  switch (gamestate) {
    //~~**GAMESTART**~~//
    case GAMESTART:
    image(start2,0,0);
    if(mousePressed) {
      gamestate = GAMEPLAY;}else {
        if(mouseX >= width/3 && mouseX <= 2*width/3 && mouseY >=380 && mouseY <=415) {
          image(start1,0,0);
        }
  }
  break;
    //~~**GAMEPLAY**~~//
    case GAMEPLAY:
    ///BACKGROUND///
    image(bg1, bgx, 0); image(bg2, bgx-640, 0); image(bg1, bgx-1280, 0);
    bgx += 1;
    bgx %= 1280;
    
    ///BOMB///
    //image(BOMB, box, boy);
    /*if(bospeed == true) {
      box += 3;}
      else { box++;}
    if(box >= -50 && box <= 650) {
      bospeed = true;
    }
    if(box >=680) {
      box = -50;
      boy = floor(random(1,439));
    }*/
    
    ///GIFT///
    image(gift, gx, gy);
    gsec++;
    if(gsec % 180 == 0) {
      gx=floor(random(0,600));
      gy=floor(random(0,440));
      
    }
        
    ///ENEMY1///
    image(enemy1, e1x, e1y);
    if(espeed == true) {
      e1x += 6;}
      else { e1x++;}
    if(e1x >= -50 && e1x <= 650) {
      espeed = true;
      if(py > e1y) {e1y += 3;}
      if(py < e1y) {e1y -= 3;}
    }
    if(e1x >=680) {
      e1x = -50;
      e1y = floor(random(1,430));
    }
    
    ///ENEMY2///
    image(enemy2, e2x, e2y);
    if(espeed == true) {
      e2x += 5;}
      else { e2x++;}
    if(e2x >= -50 && e2x <= 650) {
      espeed = true;
      if(py > e2y) {e2y += 2;}
      if(py < e2y) {e2y -= 2;}
    }
    if(e2x >=680) {
      e2x = -50;
      e2y = floor(random(1,430));
    }
    
    ///PLAYER///
    image(player, px, py);
    if(upPressed == true) { py -= 5; }
    if(downPressed == true) { py += 5; }
    if(leftPressed == true) { px -= 5; }
    if(rightPressed == true) { px += 5; }
    if(px <= 0) { px = 0; }; if(px >= 590) { px = 590; };
    if(py <= 0) { py = 0; }; if(py >= 430) { py = 430; };
      //GOT BOMB//
      /*if(px <= box + 30 && px >= box - 30 && py <= boy + 30 && py >= boy - 30) {
      image(BOMB, box, boy);
      box = -50; 
      boy = floor(random(1,439));
      life += 40;
      if(life > 220) {
        life = 220;
      }
    }*/
      //GOT GIFT//
      if(px <= gx + 20 && px >= gx - 20 && py <= gy + 20 && py >= gy - 20) {
      image(gift, gx, gy);
      gx=floor(random(0,600));
      gy=floor(random(0,440));
      gsec = 0;
      gsec++;
      if(gsec % 180 == 0) {
      gx=floor(random(0,600));
      gy=floor(random(0,440));
    }
      life += 20;
      if(life > 220) {
        life = 220;
      }
    }
      //GOT HIT//
      if(px <= e1x + 32 && px >= e1x - 32 && py <= e1y + 32 && py >= e1y - 32) {
      image(enemy1, e1x, e1y);
      e1x = -50; 
      e1y = floor(random(1,439));
      life -= 40;
      if(life < 30) {
        life = 30;
      }
    }
      if(px <= e2x + 32 && px >= e2x - 32 && py <= e2y + 32 && py >= e2y - 32) {
      image(enemy2, e2x, e2y);
      e2x = -50; 
      e2y = floor(random(1,439));
      life -= 40;
      if(life < 30) {
        life = 30;
      }
    }
      //DEAD//
      if(life == 30) {
        gamestate = GAMEOVER;
        life = 70;
        e1x = e2x = -50;
        e1y = e2y = floor(random(1,430));
        px = 590;
        py = 240;
        gsec = 0;
        /*box=-60;*/
      }
      
      ///HP///
    colorMode(HSB,128,60,30);
    strokeWeight(20);
    stroke(180, 280, 30);
    line(30,32,life,32);
    image(hp, 20, 20);
    
      break;
      //~~**GAMEOVER**~~//
      case GAMEOVER:
      image(end2,0,0);
      if(mousePressed) {
      gamestate = GAMEPLAY;}else {
        if(mouseX >= width/3 && mouseX <= 2*width/3 && mouseY >=315 && mouseY <=350) {
          image(end1,0,0);
        }
  }
  break;
    
}
}
  void keyPressed() {
    if(key == CODED) {
      switch(keyCode) {
        case UP:
        upPressed = true;
        break;
        case DOWN:
        downPressed = true;
        break;
        case LEFT:
        leftPressed = true;
        break;
        case RIGHT:
        rightPressed = true;
        break;
      }
    }
  }
   void keyReleased() {
     if(key == CODED) {
      switch(keyCode) {
        case UP:
        upPressed = false;
        break;
        case DOWN:
        downPressed = false;
        break;
        case LEFT:
        leftPressed = false;
        break;
        case RIGHT:
        rightPressed = false;
        break;
      }
    }
   }
