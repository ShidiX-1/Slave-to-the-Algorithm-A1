// 31/07/2020 face by shidi Xue

void setup(){
size (600, 600);
background ( 50,59,100);
}

void draw (){
stroke(mouseX,mouseY,mouseX+mouseY);
line (mouseX,mouseY, 300,75);
fill(240,200,0);
ellipse (300, 300, 400,450);
fill(255);
ellipse (210, 250, 90, 40);
fill(0);
ellipse (210, 250, 40, 40);
fill(255);
ellipse (380, 250, 90, 40);
fill(0);
ellipse (380, 250, 40, 40);
stroke(0); 
fill(mouseX,mouseY,mouseX+mouseY);
ellipse (300, 400, 50, 80);
stroke(0,0,0);
//line (300,75, 400,200);
//line (mouseX,mouseY, 400,200);
}

//void keyPressed(){
//background (mouseY, mouseY+mouseX, mouseX);
//}
