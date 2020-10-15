class button {
  int x, y;
  int w, h;

  String txt;

  int clr;

  boolean pressed;

  button(int X, int Y, String t) {
    rectMode(CENTER);

    x = X;
    y = Y;

    w = 100;
    h = 100;

    txt = t;

    clr = 200;

    pressed = false;
  }

  void display() {
    noStroke();
    fill(clr);
    rect(x, y, w, h);
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(16);
    text(txt, x, y);

    clr = 200;
  }

  boolean update() {
    pressed = false;

    if (mouseX > x - w/2 && mouseX < x + w/2 &&
      mouseY > y - h/2 && mouseY < y + h/2) {
      clr = 100;
    }

    if (mouseX > x - w/2 && mouseX < x + w/2 &&
      mouseY > y - h/2 && mouseY < y + h/2 &&
      mousePressed) {
      clr = 15;

      pressed = true;
    }

    return pressed;
  }
}
