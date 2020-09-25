//sketch shidi 14/8/20
PImage photo;
int smallPoint, largePoint,x,y;
color pix;


void setup () {
size (500, 500 );
background(255);
imageMode(CENTER);
photo= loadImage("untitled-article-1460557037-body-image-1460557531.jpg");
smallPoint=4;
largePoint=40;
  }
  
void draw(){
//image (photo,0,0);
x =int(random(photo.width));
y =int(random(photo.height));
float pointillise=map(mouseX,0,photo.width, smallPoint, largePoint);
int dotSize =int(pointillise);
pix=photo.get(x,y);
int t=int(random(256));
//color pix=photo.get(x, x);
//int x=int (random(photo.width));

fill(pix,t);
noStroke();
ellipse(x,y,dotSize,dotSize);
}
