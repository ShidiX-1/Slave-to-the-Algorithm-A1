var letter,size,rand,speed;
var wigglyLetters= {};

function setup() {
createCanvas( windowWidth, windowheight);
background (0);
textSize(32);
textFount("Times");
}


function draw() {
  fill (255);
  background(0);
  for(var i=0; i<wigglyLetters. length; i++){
    wigglyLetters[i].wiggle();
    wigglyLetters[i].display();
    
  }

}
function mousePressed(){
  rand =(random(65,160));
  letter = char(rand); 
  size=int(random(6,96));
  seed=int(random(1,6));
  wigglyLetters.push(new Wiggle(mouseX, mouseY, size,letter,speed));
}


class Wiggle {
  constructor(x,y,size,letter,speed){
    this. x=x;
   this. y=y;
   this. textSize =size;
   this.letter=letter;
    this.speed=speed;
  }
  wiggle(){
    this.x+=random(-this.speed, this. speed);
    this.y+=random(-this.speed, this. speed);
  }
  display(){
    text(this.letter,this.x, this.y);
  }
}
