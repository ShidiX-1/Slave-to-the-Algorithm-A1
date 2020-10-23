ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Point> linedPoints = new ArrayList<Point>();
int line = 0;

ArrayList<Particle> particles = new ArrayList<Particle>();
int pixelSteps = 9; // Amount of pixels to skip
ArrayList<String> words = new ArrayList<String>();
int wordIndex = 0;
color bgColor = color(255, 100);
String fontName = "Arial Bold";

int frame = 0;
button goonBtn;
button startBtn;
button resetBtn;
int level;

void setup() {
	size(1280, 800);
	setupMatrix();
	
	startBtn = new button(width / 2, height / 2 +150, "START");
	goonBtn = new button(width / 2 - 150, height / 2 + 300, "GO ON");
	resetBtn = new button(width / 2 + 150, height / 2 + 300, "GO BACK");
	rectMode(CENTER);
	
	words.add("Time heals almost everything,");
	words.add("so give time some time to work.");
	words.add("Don't forget to have fun");
	words.add("Coffee");
	words.add("How are you");
	words.add("didididiidid!!!");
}

void draw() {
	if (frame == 0) {
		background(1, 40, 64, 25);
		startBtn.display(); 
	}

	if (frame == 1) {
		background(1, 40, 64, 25);
		
		clear();
		background(1, 40, 64, 25);
		for (Point point : points)
		{
			point.draw();
		}
		drawLines();
		goonBtn.display();
		resetBtn.display();
	}
	
	// Background & motion blur
	if (frame == 2) {
		fill(19,19,55);
		noStroke();
		rect(0, 0, width * 2, height * 2);
		
		for (int x = particles.size() - 1; x > - 1; x--) {
			//	Simulate and draw pixels
			Particle particle = particles.get(x);
			particle.move();
			particle.draw();
			
			//	Remove any dead pixels out of bounds
			if	(particle.isKilled) {
				if	(particle.pos.x < 0 || particle.pos.x > width || particle.pos.y < 0 || particle.pos.y > height) {
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
int pointcount = 0;
boolean flag = false;
boolean flag1 = false;

void mousePressed() {
	flag1 = true;
	if (frame == 1)
	 {
		if (mouseButton == LEFT) {
			for (Point point : points)
			{
				if (dist(point.pos.x, point.pos.y, mouseX, mouseY) < 10)
				{
					if (!point.selected) {
						point.selected = true;
						linedPoints.add(point);
						flag = true;
						++pointcount;
					}
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
					if (point.selected) {
						--pointcount;
						flag = true;
					}
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
			int wordIndex = (int)random(words.size());
			nextWord(words.get(wordIndex));
		}
	}
	
	if (flag) {
		System.out.println("Point Count : " + pointcount);
		flag = false;
	}
	
	if (frame == 0) {
		if (startBtn.update()) {
			drawLines();
			frame = 1;
		}
	}
	
	if (frame == 1) {
		if (resetBtn.update()) {
			linedPoints.clear();
			for (Point p : points)
			{
				p.selected = false;
			}
			frame = 0;
		}
		
		if (goonBtn.update()) {
			frame = 2;
			clear();
			nextWord(words.get(wordIndex));
		}
	}
}


void mouseDragged() {
	if (mouseButton == CENTER && frame == 1)
	 {
		frame = 2;
		clear();
		nextWord(words.get(wordIndex));
	}
	if (mouseButton == RIGHT && frame == 2) {
		for (Particle particle : particles) {
			if (dist(particle.pos.x, particle.pos.y, mouseX, mouseY) < 50) {
				particle.kill();
			}
		}
	}
}
