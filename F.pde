
class Molnar extends Composition {

  MolnarUnit[] units;
  int unit;
  int maxDivisor = 18;

  Molnar() {
    if (width > height) {
      unit = width/maxDivisor;
    } 
    else {
      unit = height/maxDivisor;
    }
    units = new MolnarUnit[(maxDivisor+3)*(maxDivisor+3)];
    for (int i = 0; i < units.length; i++) {
      units[i] = new MolnarUnit();
    }
    compose();
  }

  void compose() {
    if (width > height) {
      unit = width/maxDivisor;
    } 
    else {
      unit = height/maxDivisor;
    }
    int divisor = int(random(2, 7)) * 3;
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
    for (int y = -unit/4; y <= height+unit/2; y += unit) {
      for (int x = -unit/4; x <= width+unit/2; x += unit) { 
        units[index].update(captured, dragging, px, py);
        units[index].display(x, y, unit); //drawUnit(x, y);
        index++;
      }
    }
  }
}

class MolnarUnit {

  float x;
  float y;
  float unit;

  boolean once = true;

  boolean rotateMe = false;
  float randomWeight = 0.5;

  boolean selected = false;

  float randomOffset = 0.0;
  
  //int nextLocalMicroTimer = 0;

  MolnarUnit() {
    compose();
  }

  void compose() {
    rotateMe = false;
    if (random(1) > randomWeight) {
      rotateMe = true;
    }
    randomOffset = random(-0.1, 0.1);
  }

  void update(boolean capture, boolean drag, int px, int py) {

    //selected = false;

    if (capture == true) {
      if ((mouseX > x-unit/2 && mouseX < x+unit/2) || (mouseY > y-unit/2 && mouseY < y+unit/2)) {
        if (once == true) {
          //rotateMe = !rotateMe; 
          rotateMe = false;
          if (random(1) > 0.5) {
            rotateMe = true; 
          }
          //nextLocalMicroTimer = millis() + nextMicro;
          once = false;
        }
        //selected = true;
        //if (millis() > nextLocalMicroTimer) {
        //  rotateMe = false;
        //  if (random(1) > 0.5) {
        //    rotateMe = true; 
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

    fill(0);
    noStroke();
    pushMatrix();
    translate(x, y);
    scale(unit);
    if (rotateMe) {
      rotate(HALF_PI);
    }
    float ra = 0.2;
    rotate(randomOffset);
    triangle(-0.5, -0.5, -0.5, -ra, -ra, -0.5);
    triangle(0.5, 0.5, ra, 0.5, 0.5, ra);
    beginShape();
    vertex(-0.5, 0.5);
    vertex(-ra, 0.5);
    vertex(0.5, -ra);
    vertex(0.5, -0.5);
    vertex(ra, -0.5);
    vertex(-0.5, ra);
    endShape();
    popMatrix();
  }
}

