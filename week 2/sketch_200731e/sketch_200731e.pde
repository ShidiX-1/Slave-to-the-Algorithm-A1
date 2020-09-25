//31/07/2020 remixed by shidi Xue

void setup()
{
size (500,500); 
background (0,55,0); 
}

void draw() 
{
  background(0,55,0);
  //face
  noStroke(); 
  fill(255,225,190); 
  rect(120,120,200,200); 
  
  //mouth
  strokeWeight(10); 
  stroke(205,115,115); 
  line (170,300,260,300); 

    //nose 
  strokeWeight(10); 
  stroke(254,235,235);
  line (220,230,230,230); 
  
  //eye
  noStroke(); 
  fill(255); 
  ellipse(mouseX,160,40,40); 
  ellipse(250,mouseY,40,40); 
  fill(0,170,130); 
  ellipse(mouseX,160,20,20);//big eye 
  ellipse(250,mouseY,20,20); 
  fill(0); 
  ellipse(mouseX,160,10,10); //samill eye
  ellipse(250,mouseY,10,10); 
  
}
