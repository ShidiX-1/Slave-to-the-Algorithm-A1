ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Point> linedPoints = new ArrayList<Point>();
int line = 0;
boolean drawMode = true;

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
    ellipse(this.pos.x, this.pos.y, 20, 20);
  }
}

void setupMatrix()
{
  for (int i = 0; i < 50; i++)
  {
    for (int j = 0; j < 50; j++)
    {
      Point p = new Point();
      p.pos.x = 10 + i * 30;
      p.pos.y = 10 + j * 30;
      points.add(p);
    }
  }
}

void setup() {
  size(1280, 800);
  setupMatrix();
  
  words.add("Time heals almost everything,");
   words.add("so give time some time to work.");
  words.add("Don't forget to have fun");
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

ArrayList<Particle> particles = new ArrayList<Particle>();
int pixelSteps = 9; // Amount of pixels to skip
ArrayList<String> words = new ArrayList<String>();
int wordIndex = 0;
color bgColor = color(255, 100);
String fontName = "Arial Bold";

class Particle {
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  PVector target = new PVector(0, 0);

  float closeEnoughTarget = 50;
  float maxSpeed = 4.0;
  float maxForce = 0.1;
  float particleSize = 5;
  boolean isKilled = false;

  color startColor = color(0);
  color targetColor = color(0);
  float colorWeight = 0;
  float colorBlendRate = 0.025;

  void move() {
    // Check if particle is close enough to its target to slow down
    float proximityMult = 1.0;
    float distance = dist(this.pos.x, this.pos.y, this.target.x, this.target.y);
    if (distance < this.closeEnoughTarget) {
      proximityMult = distance/this.closeEnoughTarget;
    }

    // Add force towards target
    PVector towardsTarget = new PVector(this.target.x, this.target.y);
    towardsTarget.sub(this.pos);
    towardsTarget.normalize();
    towardsTarget.mult(this.maxSpeed*proximityMult);

    PVector steer = new PVector(towardsTarget.x, towardsTarget.y);
    steer.sub(this.vel);
    steer.normalize();
    steer.mult(this.maxForce);
    this.acc.add(steer);

    // Move particle
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }

  void draw() {
    // Draw particle
    color currentColor = lerpColor(this.startColor, this.targetColor, this.colorWeight);
    noStroke();
    fill(currentColor);
    ellipse(this.pos.x, this.pos.y, this.particleSize, this.particleSize);
    // Blend towards its target color
    if (this.colorWeight < 1.0) {
      this.colorWeight = min(this.colorWeight+this.colorBlendRate, 1.0);
    }
  }

  void kill() {
    if (! this.isKilled) {
      // Set its target outside the scene
      PVector randomPos = generateRandomPos(width/2, height/2, (width+height)/2);
      this.target.x = randomPos.x;
      this.target.y = randomPos.y;

      // Begin blending its color to black
      this.startColor = lerpColor(this.startColor, this.targetColor, this.colorWeight);
      this.targetColor = color(0);
      this.colorWeight = 0;

      this.isKilled = true;
    }
  }
}

PVector generateRandomPos(int x, int y, float mag) {
  PVector randomDir = new PVector(random(0, width), random(0, height));
  
  PVector pos = new PVector(x, y);
  pos.sub(randomDir);
  pos.normalize();
  pos.mult(mag);
  pos.add(x, y);
  
  return pos;
}

void nextWord(String word) {
  // Draw word in memory
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  pg.fill(0);
  pg.textSize(80);
  pg.textAlign(CENTER);
  PFont font = createFont(fontName, 80);
  pg.textFont(font);
  pg.text(word, width/2, height/2);
  pg.endDraw();
  pg.loadPixels();

  // Next color for all pixels to change to
  color newColor = color(random(0.0, 255.0), random(0.0, 255.0), random(0.0, 255.0));

  int particleCount = particles.size();
  int particleIndex = 0;

  // Collect coordinates as indexes into an array
  // This is so we can randomly pick them to get a more fluid motion
  ArrayList<Integer> coordsIndexes = new ArrayList<Integer>();
  for (int i = 0; i < (width*height)-1; i+= pixelSteps) {
    coordsIndexes.add(i);
  }

  for (int i = 0; i < coordsIndexes.size (); i++) {
    // Pick a random coordinate
    int randomIndex = (int)random(0, coordsIndexes.size());
    int coordIndex = coordsIndexes.get(randomIndex);
    coordsIndexes.remove(randomIndex);
    
    // Only continue if the pixel is not blank
    if (pg.pixels[coordIndex] != 0) {
      // Convert index to its coordinates
      int x = coordIndex % width;
      int y = coordIndex / width;

      Particle newParticle;

      if (particleIndex < particleCount) {
        // Use a particle that's already on the screen 
        newParticle = particles.get(particleIndex);
        newParticle.isKilled = false;
        particleIndex += 1;
      } else {
        // Create a new particle
        newParticle = new Particle();
        
        PVector randomPos = generateRandomPos(width/2, height/2, (width+height)/2);
        newParticle.pos.x = randomPos.x;
        newParticle.pos.y = randomPos.y;
        
        newParticle.maxSpeed = random(2.0, 5.0);
        newParticle.maxForce = newParticle.maxSpeed*0.025;
        newParticle.particleSize = random(3, 6);
        newParticle.colorBlendRate = random(0.0025, 0.03);
        
        particles.add(newParticle);
      }
      
      // Blend it from its current color
      newParticle.startColor = lerpColor(newParticle.startColor, newParticle.targetColor, newParticle.colorWeight);
      newParticle.targetColor = newColor;
      newParticle.colorWeight = 0;
      
      // Assign the particle's new target to seek
      newParticle.target.x = x;
      newParticle.target.y = y;
    }
  }

  // Kill off any left over particles
  if (particleIndex < particleCount) {
    for (int i = particleIndex; i < particleCount; i++) {
      Particle particle = particles.get(i);
      particle.kill();
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
