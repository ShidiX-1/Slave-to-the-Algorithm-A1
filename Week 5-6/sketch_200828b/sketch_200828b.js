//week 6 sound 1
var song;
var analyzer; 
function preload(){
song = loadSound('data/10GrandBattment.mp3');
}


function setup() {
createCanvas(windowWidth,windowHeight);
background(0);
fill(230,206,255);
song.loop();
analyzer= new p5 . Amplitude();
analyzer.setInput(song);
stroke(255);
}


function draw() {
background (0,60);
var volume=analyzer.getLevel();
volume= (volume*300)+50;
ellipse(windowWidth/2,windowHeight/2,volume,volume);

}


function mousePressed(){
 if (song. isPlaying()){
   song.stop();
   fill(230,206,255);
 }
 else{
 fill(200,30,255);
 song.play(); 
 } 
}
