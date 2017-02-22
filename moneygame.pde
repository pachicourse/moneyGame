PFont myFont;
PImage numbers[] = new PImage[6];
PImage bomb[] = new PImage[3];
PImage moneyimage;
PImage expro;
PImage chicken;
PImage background;
int bnumber;
import ddf.minim.*;    // for sounds
Minim minim;           // for sounds
AudioPlayer sound;     // for sounds
AudioPlayer sound2;    // for sounds
AudioPlayer sound3;    // for sounds
AudioPlayer bgm1,bgm2,bgm3,bgm4;

void setup() {
  int i;
  String filename;
  size(640,640);
  background(255, 255, 255);
  fill(0, 0, 0);
  smooth();
  noStroke();
  frameRate(24);
  myFont = createFont("MS Gothic", 26, true);
  textFont(myFont);
  //roadimage
  for(i = 0; i < 6; i++) {     // loads the images
    filename = "images/" + str(i + 1) + ".png";
    numbers[i] = loadImage(filename);
  }
  for(i = 0; i < 3; i++) {     // loads the images
    filename = "images/" + "bomb" + str(i + 1) + ".png";
    bomb[i] = loadImage(filename);
  }
  moneyimage = loadImage("images/gold.png");
  expro = loadImage("images/expro.png");
  chicken = loadImage("images/chicken.png");
  background = loadImage("images/background.jpeg");
  //roadimage
  minim = new Minim(this);
  sound = minim.loadFile("sounds/se_maoudamashii_se_switch01.wav");   // loads the sound
  sound2 = minim.loadFile("sounds/booomb.wav");
  sound3 = minim.loadFile("sounds/chicken.mp3");
  bgm1 = minim.loadFile("sounds/bgm1.mp3");
  bgm2 = minim.loadFile("sounds/bgm2.mp3");
  bgm3 = minim.loadFile("sounds/bgm3.mp3");
  bgm4 = minim.loadFile("sounds/bgm4.mp3");
  bnumber = floor(random(0,4));
}

int highscore = 0;
int u,b,c,d,e,f,g,h;
int kirikae = 0;
int Stopflag,retryflag,bombswitch,chickenswitch,bgmswitch = 0;
int money =0;
int r1 = 0;  // random number
int r2 = 0;  // random number
//Button
int rollButtonX = 550;
int rollButtonY = 600;
int rollButtonW = 80;
int rollButtonH = 30;
int stopButtonX = 460;
int stopButtonY = 600;
int stopButtonW = 80;
int stopButtonH = 30;
int retryButtonX = 505;
int retryButtonY = 565;
int retryButtonW = 80;
int retryButtonH = 30;
int buttonRed = 0;          // button color
int buttonGreen = 0;        // button color
int buttonBlue = 255;       // button color
int buttonTextColor = 255;
//Button 
int Dcounter = 3;
boolean checkBox1 = true;      // checkBox status

void draw() {
  playBGM(bnumber);
  background(0);
  image(background,0,40,640,555);
  fill(255);
  text("highscore" + " " + highscore + "yen",20,30);
  text(money + "yen", 250, 625);
  image(numbers[r1], 490, 480, 120, 120);
  stroke(0);
  rect(30,40,210,555);
  for(int cell = 0; cell < 6;cell++){
    image(numbers[cell],95,40 + (cell * 92),70,70);
  }
  fill(0);
  text("count down!",68,130);
  text("+10000yen!",73,225);
  text("+30000yen!",73,315);
  text("+20000yen!",73,405);
  text("-5000yen...",77,495);
  text(" *2 !",95,585);
  if(retryflag == 0){
    drawButton(rollButtonX, rollButtonY,
               rollButtonW, rollButtonH,
               1,"roll");
    drawButton(stopButtonX, stopButtonY,
               stopButtonW, stopButtonH,
               2,"fold");
  }else if(retryflag == 1){
    drawButton(retryButtonX,retryButtonY,
               retryButtonW,retryButtonH,
               3,"retry");
  }
  drawDobonBox1(400, 600, Dcounter);
  drawBomb(330, 500, 80, 80, Dcounter);
  u = money / 15000;
  drawMoney(u);
  fill(0);
  if(Stopflag == 1){
    if(bombswitch == 0){
      sound2.rewind();
      sound2.play();
      bombswitch = 1;
    }
    money = 0;
    image(expro,-60,-100,800,800);
    retryflag = 1;
  }else if(Stopflag == 2){
    if(chickenswitch == 0){
      sound3.pause();
      sound3.rewind();
      sound3.play();
      chickenswitch = 1;
    }
    image(chicken,300,150,300,300);
    if(highscore < money){
      highscore = money;
    }
    retryflag = 1;
  }
}


  
void mouseReleased() {
  
  if(retryflag == 1){
    if(mouseX >= retryButtonX && mouseX <= retryButtonX + retryButtonW &&
       mouseY >= retryButtonY && mouseY <= retryButtonY + retryButtonH) {
         retryflag = 0;
         money = 0;
         Dcounter = 3;
         Stopflag = 0;
         bombswitch = 0;
         chickenswitch = 0;
         bgmswitch = 0;
         bnumber = floor(random(0,4));
    }
  }else{
    if(mouseX >= rollButtonX && mouseX <= rollButtonX + rollButtonW &&
       mouseY >= rollButtonY && mouseY <= rollButtonY + rollButtonH) {
      r1 = floor(random(0, 6));
      if(r1 == 0){
        Dcounter -- ;
        if(Dcounter == 0){
          Stopflag = 1;
          bgmswitch = 1;
        }
      }else{
        switch(r1){
          case 1: money += 10000;
                  break;
          case 2: money += 30000;
                  break;
          case 3: money += 20000;
                  break;
          case 4: if(money >= 5000){
                    money -= 5000;
                  }
                  break;
          case 5: money *= 2;
                  break;
        }
      }

    }
    if(mouseX >= stopButtonX && mouseX <= stopButtonX + stopButtonW &&
       mouseY >= stopButtonY && mouseY <= stopButtonY + rollButtonH) {
         Stopflag = 2;
         bgmswitch = 1;
    }  
  }
}

void mousePressed() {
  if(mouseX >= rollButtonX && mouseX <= rollButtonX + rollButtonW &&
     mouseY >= rollButtonY && mouseY <= rollButtonY + rollButtonH &&
     retryflag == 0) {
    sound.rewind();
    sound.play();
  }
}

void drawDobonBox1(int x, int y, int Dcounter) {
  fill(255);
  stroke(0);
  rect(x, y, 30, 30);
  if(Dcounter > 1){
    fill(0);
  }else{
    fill(255,0,0);
  }
  text(Dcounter, x + 4, y + 24);
}

void drawButton(int x, int y, int w, int h, int id,String s) {
  if(mousePressed == true &&
   mouseX >= x && mouseX <= x + w &&
   mouseY >= y && mouseY <= y + h) {
    fill(255);
    stroke(0);
    rect(x, y, w, h, 7);
    fill(0);
    }else{
    fill(buttonRed, buttonGreen, buttonBlue);
    stroke(0);
    rect(x, y, w, h, 7);
    fill(buttonTextColor);
  }
  text(s, x + 15, y + 23);
}

void drawMoney(int x){  
  b = 0;
  c = 0;
  d = 0;
  e = 0;
  f = 0;
  g = 0;
  h = 0;
  if(x == 0){
  }else{
    for(int a =0; a<=x; a++){
      if(a < 10 && a > 0){
        image(moneyimage,250 + (b * 35),385,100,100);
        b++;
      }else if(a >= 10 && a < 18){
        image(moneyimage,265 + (c * 35),325,100,100);
        c++;
      }else if(a >= 18 && a < 25){
        image(moneyimage,280 + (d * 35),265,100,100);
        d++;
      }else if(a >= 25 && a < 31){
        image(moneyimage,295 + (e * 35),205,100,100);
        e++;
      }else if(a >= 31 && a < 36){
        image(moneyimage,310 + (f * 35),145,100,100);
        f++;
      }else if(a >= 36 && a < 40){
        image(moneyimage,325 + (g * 35),85,100,100);
        g++;
      }else if(a >= 40 && a < 43){
        image(moneyimage,340 + (h * 35),25,100,100);
        h++;
      }
    }
  }
}

void drawBomb(int x, int y, int w, int h, int C){
  if(Stopflag > 0){
  }else{ 
    if(C == 3){
      w += 50;
      image(bomb[0],x,y,w,h);
    }else if(C == 2){
      image(bomb[1],x,y,w,h);
    }else if(C == 1){
      w += 60;
      h += 60;
      image(bomb[2],x,y,w,h);
    }
  }
}

void playBGM(int a){
  if(bgmswitch == 0){  
    switch(a){
      case 0: bgm1.loop();
              break;  
      case 1: bgm2.loop();
              break;
      case 2: bgm3.loop();
              break;
      case 3: bgm4.loop();
              break;
    }
  }else if(bgmswitch == 1){
     bgm1.pause();
     bgm2.pause();
     bgm3.pause();
     bgm4.pause();
     bgm1.rewind();
     bgm2.rewind();
     bgm3.rewind();
     bgm4.rewind();
  }  
  bgmswitch = 2;
}

// 0 = play , 1 = stop , 2 = ifskip
