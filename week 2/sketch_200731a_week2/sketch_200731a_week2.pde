//sketch made 31/7/2020 by shidi Xue

void setup(){
size (500, 500);
background (255, 100, 255);// background colour
}

void draw (){
stroke (0);// outline
line (mouseX, mouseY, 250, 250);
stroke (0, 0, 0);
fill(mouseX/2, mouseY/2, (mouseX+mouseY)/4);
ellipse (mouseX, mouseY, 20,20);
fill(255);
rect (125, 30, 40, 60);
}

void keyPressed(){
background (mouseY/2, (mouseY+mouseX)/4, 255-mouseX/2);
}
