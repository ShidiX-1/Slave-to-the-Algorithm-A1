//text
PFont TimesNewRomanPS;
float spin=0;
void setup(){
size(500,500);
background(255);
//degrees(PI/2);
fill(0);
smooth(0);
TimesNewRomanPS=createFont("TimesNewRomanPSe",32, true);
TimesNewRomanPS=loadFont("TimesNewRomanPS-BoldMT-40.vlw");
//textFount(HybridOutline);
textAlign(CENTER,CENTER);
frameRate(33);

}

void draw(){
  fill(0);
  translate(width/2,height/2);
  spin+=.1;
  rotate(spin);
  textFont(TimesNewRomanPS);
  textSize(48);
  text("HAVE A NICE DAY", 0, 0);
  fill(255,20);
  //noStroke();
  rect(-width/2,-height/2, width,height);
 
  
}

void keyPressed(){
  background(255);
}
