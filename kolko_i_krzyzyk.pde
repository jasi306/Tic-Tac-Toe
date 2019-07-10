int board[][];
int turn;

void setup(){
  size(1000,500);
  
  rect(0,0,width,height);
  textAlign(CENTER, CENTER);
  textSize(60);
  
  //rysowanie planszy
  stroke(0);
  strokeWeight(6);
  background(255);
  for(int i=1;i<3;i++){
    line(0,height/3*i,width,height/3*i);
    line(width/3*i,0,width/3*i,height);
  }
  noStroke();
  
  //wartosci poczatkowe
  turn=2;
  board=new int[3][3];
}

void draw(){
  //kod
}

void mousePressed() {if(mouseButton ==LEFT ) makeMove();}

void makeMove(){
  int y=(int)map(mouseY, 0,height, 0, 3);   //poczatek robienia ruchu
  int x=(int)map(mouseX, 0,width , 0, 3);
  if(board[y][x]==0){
    board[y][x]=turn++;                     //koniec robienia ruchu
    if(turn%2==0){
      fill(0,0,255);
      ellipse(width/3*x+ width/6,height/3*y + height/6,width/4,height/4);
      fill(255);
      ellipse(width/3*x+ width/6,height/3*y + height/6,width/6,height/6);
    }
    else{
      stroke(255, 0, 0);
      strokeWeight(20);
      line(width/3*x+width/14,height/3* y   +height/14,width/3*(x+1)-width/14,height/3*(y+1)-height/14);
      line(width/3*x+width/14,height/3*(y+1)-height/14,width/3*(x+1)-width/14,height/3* y   +height/14);
      noStroke();
    }
    checkForWin();
  }
}

void checkForWin(){
  int win=2;
  //wykrywacz wygranych;
  for(int player=0;player<2;++player){
    for(int i=0;i<3;++i){
      if( board[i][0]%2==player && board[i][0]!=0 && board[i][1]%2==player && board[i][1]!=0 && board[i][2]%2==player && board[i][2]!=0 ){ //kolumny
        stroke( (player==0)?color(120, 0, 0):color(0,0,120) );
     
        strokeWeight(20);
        line(width/24,height/3*i+height/6,width-width/24,height/3*i+height/6);
        noStroke();
        win=player;
      }
      if( board[0][i]%2==player && board[0][i]!=0 && board[1][i]%2==player && board[1][i]!=0 && board[2][i]%2==player && board[2][i]!=0 ){ //wiersze
        stroke( (player==0)?color(120, 0, 0):color(0,0,120) );
      
        strokeWeight(20);
        line(width/3*i+width/6,height/24,width/3*i+width/6,height-height/24);
        noStroke();
        win=player;
      }
      
    }
    if( board[0][0]%2==player && board[0][0]!=0 && board[1][1]%2==player && board[1][1]!=0 && board[2][2]%2==player && board[2][2]!=0 ) {
      stroke( (player==0)?color(120, 0, 0):color(0,0,120) );
   
      strokeWeight(20);
      line(width/24,height/24,width-width/24,height-height/24);
      noStroke();
      win=player;
    }
    if( board[2][0]%2==player && board[2][0]!=0 && board[1][1]%2==player && board[1][1]!=0 && board[0][2]%2==player && board[0][2]!=0 ) {
      stroke( (player==0)?color(120, 0, 0):color(0,0,120) );

      strokeWeight(20);
      line(width-width/24,height/24,width/24,height-height/24);
      noStroke();
      win=player;
    }
  }
  
  //wykrywacz remisow
  int i=0,j=0;
  for(i=0;i<3;++i) {for(j=0;j<3;++j) if(board[i][j]==0) break; if (j!=3) break; }
  if(i==3){
    fill(120,80);
    rect(0,0,width,height);
    fill(120);
    text("Koniec gry,\nremis.\nnacisnij 'r' aby zrestartowac.",width/2,height/2);
    
  }
  //oglaszacz wygranych;
  if(win!=2){
    fill(120,80);
    rect(0,0,width,height);
    fill( (win==0)?color(250, 120, 120):color(120,120,250) );
   
    text("Koniec gry,\nwygrał player "+(win+1)+"\nnacisnij 'r' aby zrestartowac.",width/2,height/2);
    for(i=0;i<3;++i) for (j=0;j<3;++j) board[i][j]=1; //blokowanie planszy
  }

}
void keyPressed(){
   if(keyCode==82){
     setup();
   }
}
