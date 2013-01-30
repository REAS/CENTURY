
class LeWitt extends Composition {

  LeWittUnit[] units;
  int unit;
  int maxDivisor = 18;

  LeWitt() {
    if (width > height) {
      unit = width/maxDivisor;
    } 
    else {
      unit = height/maxDivisor;
      //println("height is larger than width");
    }
    units = new LeWittUnit[(maxDivisor+3) * (maxDivisor+3)];
    //println(units.length);
    for (int i = 0; i < units.length; i++) {
      units[i] = new LeWittUnit(); 
    }
    compose();
    rectMode(CORNER);
  }

  void compose() {
    int divisor = int(random(2, 7)) * 3;
    if (width > height) {
      unit = width/divisor;
    } 
    else {
      unit = height/divisor;
    }
    int r = int(random(2, 5));
    for (int i = 0; i < units.length; i++) {
      units[i].compose(r);
    }
  }

  void display() {
    background(0);
    stroke(255);
    noFill();
    int index = 0;
    for (int y = -unit/4; y <= height+unit/2; y += unit) {
      for (int x = -unit/4; x <= width+unit/2; x += unit) { 
        units[index].update(captured, dragging, px, py);
        units[index].display(x, y, unit); //drawUnit(x, y);
        index++;
      }
    }
    //println(index);
  }
}

class LeWittUnit {

  float x;
  float y;
  float unit;

  boolean once = true;

  int rotateVal = 0;
  float randomWeight = 0.5;

  boolean selected = false;

  float randomOffset = 0.0;
  //int nextLocalMicroTimer = 0;


  int maxRotate = 4;

  LeWittUnit() {
    compose(4);
  }

  void compose(int _max) {
    maxRotate = _max;
    rotateVal = int(random(0, maxRotate));
  }

  void update(boolean capture, boolean drag, int px, int py) {

    //selected = false;

    if (capture == true) {
      //if (mouseX > x-unit/2 && mouseX < x+unit/2 && mouseY > y-unit/2 && mouseY < y+unit/2) {
      if (mouseY > y-unit/2 && mouseY < y+unit/2) {
        if (once == true) {
          rotateVal += 1;
          if (rotateVal >= maxRotate) {
            rotateVal = 0;
          }
          //nextLocalMicroTimer = millis() + nextMicro;
          once = false;
        }
        //selected = true;
        //if (millis() > nextLocalMicroTimer) {
          //rotateMe = !rotateMe;
        //  rotateVal += 1; 
        //  if (rotateVal >= maxRotate) {
        //    rotateVal = 0;
        //  }
        //  nextLocalMicroTimer = millis() + nextMicro;
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

    pushMatrix();
    translate(x, y);
    scale(unit);
    strokeWeight(1/unit * 2);
    //if (selected) {
    //  stroke(255, 204, 0);
    //} else {
      stroke(255); 
    //}

    noFill();
    if (rotateVal == 0) {
      arc(-0.5, 0.5, 2, 2, PI+HALF_PI, TWO_PI);
    } 
    else if (rotateVal == 1) {
      arc(0.5, -0.5, 2, 2, HALF_PI, PI);
    } 
    else if (rotateVal == 2) {
      arc(-0.5, -0.5, 2, 2, 0, HALF_PI);
    } 
    else if (rotateVal == 3) {
      arc(0.5, 0.5, 2, 2, PI, PI+HALF_PI);
    }

    popMatrix();
  }
}

