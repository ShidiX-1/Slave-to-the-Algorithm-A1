PFont myfont;
int randchar,randSize;
char letter;
void setup(){
  size(500,500);
  background(200);
  myfont=loadFont("ArialNarrow-Bold-40.vlw");
}

void draw(){
  fill(0);
  textFont(myfont);
  randchar=int(random(255)+1);
  randSize=int(random(60)+1);
  letter=char(randchar);
  textSize(int(randSize)+1);
  if(mousePressed){
  text(letter, mouseX, mouseY);
}
}

void keyPressed(){
background(200);
}
