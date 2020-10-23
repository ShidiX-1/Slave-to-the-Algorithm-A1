

ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Point> linedPoints = new ArrayList<Point>();
int line = 0;
boolean drawMode = true;

ArrayList<Particle> particles = new ArrayList<Particle>();
int pixelSteps = 9; // Amount of pixels to skip
ArrayList<String> words = new ArrayList<String>();
int wordIndex = 0;
color bgColor = color(255, 100);
String fontName = "Arial Bold";

int pointCount = 0;
boolean calculated = false;
 PGraphics pg;
 
class Point
{
PVector pos = new PVector(0, 0);
boolean selected = false;
  
  void draw()
  {
    noStroke();
    if (this.selected)
    {
      fill(255, 126, 112, 100);
    }
    else
    {
      fill(31, 142, 126, 56);
    }
    ellipse(this.pos.x, this.pos.y, 15, 15);
  }
  void click()
  {
    this.selected = !this.selected;
  }
}
void setupMatrix()
{
  for (int i = 0; i < 50; i++)
  {
    for (int j = 0; j < 50; j++)
    {
      Point p = new Point();
      p.pos.x = 10 + i * 40;
      p.pos.y = 10 + j * 40;
      points.add(p);
    }
  }
}


void setup() {
 fullScreen();
  setupMatrix();
  
  words.add("Time heals almost everything,");
   words.add("so give time some time to work.");
  words.add("Don't forget to have fun");
  
  textSize(9);
  String tipText = "Left-click for a new word.";
  tipText += "\nDrag right-click over particles to interact with them.";
  tipText += "\nPress any key to toggle draw styles.";
  text(tipText, 10, height-40);
}


void draw() {
  if (drawMode)
  {
  clear();
  background(1, 40, 64, 25);
  for (Point point : points)
  {
    point.draw();
  }
  drawLines();
  }
  else
  {
  // Background & motion blur
  fill(bgColor);
  noStroke();
  rect(0, 0, width*2, height*2);

  for (int x = particles.size ()-1; x > -1; x--) {
    // Simulate and draw pixels
    Particle particle = particles.get(x);
    particle.move();
    particle.draw();

    // Remove any dead pixels out of bounds
    if (particle.isKilled) {
      if (particle.pos.x < 0 || particle.pos.x > width || particle.pos.y < 0 || particle.pos.y > height) {
        particles.remove(particle);
      }
    }
  }
  }
}

void drawLines()
{
  line = 0;
  Point lastPoint = null;
  for (Point point : linedPoints)
  {
    if (lastPoint != null)
    {
      stroke(255, 174, 61, 100);
      line(point.pos.x, point.pos.y, lastPoint.pos.x, lastPoint.pos.y);
      line++;
    }
    
    lastPoint = point;
  }
  for (Point pointA : points)
  {
    if (pointA.selected)
    {
      pointCount++;
    }

if (calculated)
  {
    print("-------------------------------\n");
    print("Point Count: " + pointCount + "\n");
    calculated = false;
    }
  }
}

void mousePressed() {
  if (drawMode)
  {
  if (mouseButton == LEFT) {
    for (Point point : points)
    {
      if (dist(point.pos.x, point.pos.y, mouseX, mouseY) < 10)
      {
        point.selected = true;
        linedPoints.add(point);
        point.click();
        calculated = true;
      }
    }
  }
  else if (mouseButton == RIGHT)
  {
    for (Point point : points)
    {
      if (dist(point.pos.x, point.pos.y, mouseX, mouseY) < 10)
      {
        linedPoints.remove(point);
        if (!linedPoints.contains(point))
        {
          point.selected = false;
        }
      }
    }
  }
  }
  else
  {
    if (mouseButton == LEFT) {
    wordIndex += 1;
    if (wordIndex > words.size()-1) { 
      wordIndex = 0;
    }
    nextWord(words.get(wordIndex));
  }
  }
}



void mouseDragged() {
  if (mouseButton == CENTER && drawMode)
  {
    drawMode = false;
    clear();
    nextWord(words.get(wordIndex));
  }
  if (mouseButton == RIGHT && !drawMode) {
    for (Particle particle : particles) {
      if (dist(particle.pos.x, particle.pos.y, mouseX, mouseY) < 50) {
        particle.kill();
      }
    }
  }
}    
