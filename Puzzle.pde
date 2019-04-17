import java.util.Random;

class Tile{
  
  public int x,y;
  public int number;
  public int position;
  void drawNumber(){
    fill(255,150,0);
    rect(x*100,y*100,100,100);
    fill(255);
    textSize(24);
    text(number,x*100+45,y*100+55);
    fill(0);
  }
  Tile(int _x,int _y,int _number,int _pos){
    x=_x;
    y=_y;
    number=_number;
    position=_pos;
  }
  
  void shift(){
    int temp = pos_t;
    pos_t=position;
    position=temp;
    
    int temp_x = pos_t_x;
    int temp_y = pos_t_y;
    pos_t_x = x;
    pos_t_y = y;
    x=temp_x;
    y=temp_y;
    
  }
  
  
}
Random rand = new Random();


// TODO create pos_taken on random vals; Think about it.
ArrayList<Tile> tiles = new ArrayList<Tile>();
int[] pos_taken = new int[10];
int pos_t=9;
int pos_t_x=2;
int pos_t_y=2;

void shuffle(){
  for(int i=0;i<100;i++){
    int t1= rand.nextInt(tiles.size());
    int t2= rand.nextInt(tiles.size());
    if(t1!=t2){
      int tempt1x = tiles.get(t1).x;
      int tempt1y = tiles.get(t1).y;
      int temppos = tiles.get(t1).position;
      
      tiles.get(t1).x = tiles.get(t2).x;      
      tiles.get(t1).y = tiles.get(t2).y;
      tiles.get(t1).position = tiles.get(t2).position;
      
      tiles.get(t2).x = tempt1x;
      tiles.get(t2).y = tempt1y;
      tiles.get(t2).position = temppos;
    }
  }
}

boolean checkForWin(){
  for(int i=0;i<tiles.size();i++){
    if(tiles.get(i).number != tiles.get(i).position){
      return false;
    }
  }
  return true;
}
boolean won;
void setup(){
  size(301,400);
  for(int i=0;i<9;i++){ // Initializing the array in order to shuffle the positions.
    pos_taken[i]=0;    
  }
  int count=1;
  for(int i=0;i<3;i++){
    for(int j=0;j<3;j++){
      if(count == 9){
        continue;
      }
     tiles.add(new Tile(j,i,count,count));
     count++;
     }
  }
  tiles.get(7).shift();
  won=false;
  //shuffle();
}
int my=-1,mx=-1;

void draw(){
  if(!won){
    background(255);
    fill(0);
    fill(125);
    rect(100,325,100,50);
    fill(255);
    textSize(20);
    text("Restart",117,355);
    if(mx!=-1 && my!=-1){
      //1st col
      if(mx>117 && mx<217){
        if(my>325 && my<375){
          won=false;
          shuffle();
        }
      }  
      mx=mx/100;
      my=my/100;
      println(mx+" "+my);
    
      if(pos_t_x != mx || pos_t_y != my){ // Check if the selected tile is not the empty one    
        for(int i=0;i<tiles.size();i++){
          if(mx == tiles.get(i).x && my == tiles.get(i).y){
            if(abs(pos_t_x-tiles.get(i).x)==1 && pos_t_y == tiles.get(i).y
            || abs(pos_t_y-tiles.get(i).y)==1 && pos_t_x == tiles.get(i).x
            ){
              println("CORRECT");
              tiles.get(i).shift();
              won=checkForWin();
            }
          }
        }
      }

      
      mx=my=-1;
    }
   
    for(int i=0;i<=4;i++){    
      line(i*100,0,i*100,height-100);
      line(0,i*100,width,i*100);
    }
    
    for(int i=0;i<tiles.size();i++){
      tiles.get(i).drawNumber();
    }


  }else{
    fill(0);
    
    textSize(25);
    text("YOU WON!",(width-120)/2,(height-100)/2);
    fill(125);
    rect(100,325,100,50);
    fill(255);
    textSize(20);
    text("Restart",117,355);
    if(mx!=-1 && my!=-1){
      if(mx>117 && mx<217){
        if(my>325 && my<375){
          won=false;
          shuffle();
        }
      }          
      mx=my=-1;
    }
  }
  
}
void mouseClicked(){
  mx=mouseX;
  my=mouseY;
}
