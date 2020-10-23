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
