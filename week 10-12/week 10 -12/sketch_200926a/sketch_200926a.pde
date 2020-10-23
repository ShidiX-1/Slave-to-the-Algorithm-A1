ArrayList<Point> points = new ArrayList<Point>();
boolean calculated = false;

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
    ellipse(this.pos.x, this.pos.y, 10, 10);
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
      p.pos.x = 10 + i * 20;
      p.pos.y = 10 + j * 20;
      points.add(p);
    }
  }
}

void setup() {
  size(1000, 1000);
  setupMatrix();
}

void draw() {
  clear();
  background(1, 40, 64, 25);
  for (Point point : points)
  {
    point.draw();
  }
  drawLines();
}

void drawLines()
{
  int lineCount = 0;
  int pointCount = 0;
  for (Point pointA : points)
  {
    if (pointA.selected)
    {
      pointCount++;
    }
    for (Point pointB : points)
    {
      if (pointA != pointB)
      {
        if (pointA.selected && pointB.selected)
        {
          stroke(255, 174, 61, 100);
          line(pointA.pos.x, pointA.pos.y, pointB.pos.x, pointB.pos.y);
          lineCount++;
        }
      }
    }
  }
  if (calculated)
  {
    print("-------------------------------\n");
    print("Line Count: " + lineCount / 2 + "\n");
    print("Point Count: " + pointCount + "\n");
    calculated = false;
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    for (Point point : points)
    {
      if (dist(point.pos.x, point.pos.y, mouseX, mouseY) < 10)
      {
        point.click();
        calculated = true;
      }
    }
  }
}
