
class Molnar55 extends Composition {

  Molnar55Unit[] units;
  int unit;
  int maxDivisor = 18;

  Molnar55() {
    if (width > height) {
      unit = (width/maxDivisor);
    } 
    else {
      unit = (height/maxDivisor);
    }
    units = new Molnar55Unit[(maxDivisor+3)*(maxDivisor+3)];
    for (int i = 0; i < units.length; i++) {
      units[i] = new Molnar55Unit();
    }
    compose();
  }

  void compose() {
    int divisor = int(random(2, 7)) * 3;
    //println(divisor);
    if (width > height) {
      unit = width/divisor;
    } 
    else {
      unit = height/divisor;
    }
    for (int i = 0; i < units.length; i++) {
      units[i].compose();
    }
  }

  void display() {
    background(255);
    int index = 0;
    for (int y = -unit/4; y <= height+unit/4; y += unit) {
      for (int x = -unit/4; x <= width+unit/4; x += unit) { 
        units[index].update(captured, dragging, px, py);
        units[index].display(x, y, unit); //drawUnit(x, y);
        index++;
      }
    }
  }
}

class Molnar55Unit {

  float x;
  float y;
  float unit;

  int type;

  boolean once = true;

  float randomWeight = 0.5;
  float weight;

  boolean selected = false;

  Molnar55Unit() {

    compose();
    weight = dist(0, 0, width, height) / 200;
  }

  void compose() {
    type = int(random(1, 5));
  }

  void update(boolean capture, boolean drag, int px, int py) {

    //selected = false;

    if (capture == true) {
      //if (mouseX > x-unit/2 && mouseX < x+unit/2 && mouseY > y-unit*2 && mouseY < y+unit*2) {
      if (mouseX > x-unit/2 && mouseX < x+unit/2) {
        if (once == true) {
          type++;
          if (type > 4) { 
            type = 1;
          }
          //type = int(random(1, 5);
          //nextMicroTimer = millis() + nextMicro;
          once = false;
        }
        //selected = true;
        //if (millis() > nextMicroTimer) {
        //  type++;
        //  if (type > 4) { 
        //    type = 1;
        //  }
          //type = int(random(1, 5);
          //nextMicroTimer = millis() + nextMicro;
        //}
      } else {
        once = true; 
      }
    } 
    else {
      once = true;
    }
  }

  void display(float _x, float _y, float _unit) {

    x = _x;
    y = _y;
    unit = _unit;

    //if (selected) {
    //  stroke(255, 153, 0);
    //} 
    //else {
      stroke(0);
    //}

    strokeWeight(weight);
    strokeCap(PROJECT);

    if (type == 1) {
      line(x, y-unit/2, x, y+unit/2);
    } 
    else if (type == 2) {
      line(x-unit/2, y, x+unit/2, y);
    } 
    else if (type == 3) {
      line(x-unit/2, y-unit/2, x+unit/2, y+unit/2);
    } 
    else if (type == 4) {
      line(x-unit/2, y+unit/2, x+unit/2, y-unit/2);
    }

  }
}

