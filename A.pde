
class MetaMetaMalevich extends Composition {

  Line[] lines;
  float currentAngle = 0;
  float angleOffset = 0;
  float startAngle = 0;
  float diameter = 0;
  float pAngle = 0;
  boolean setNewAngleOffset = true;

  MetaMetaMalevich() {
    lines = new Line[9];
    for (int i = 0; i < lines.length; i++) {
      lines[i] = new Line();
    }
  }

  void compose() {
    for (int i = 0; i < lines.length; i++) {
      lines[i].compose();
    }
  }

  void display() {
    background(255);

    int halfWidth = width/2;
    int halfHeight = height/2;

    if (captured) {
      if (setNewAngleOffset) {
        startAngle = atan2(y - halfHeight, x - halfWidth);
        setNewAngleOffset = false;
      }
    } 
    else {
      setNewAngleOffset = true;
    }

    if (dragging) {
      currentAngle = atan2(y - halfHeight, x - halfWidth);
      angleOffset += currentAngle - pAngle;
      pAngle = currentAngle;
      diameter = dist(halfWidth, halfHeight, x, y)*2;
    }
    
    for (int i = 0; i < lines.length; i++) {
      lines[i].display(angleOffset);
    }

 
  }
}


class Line {
  float angle;
  float captureAngle = 0;
  float length;
  float x;
  float y;
  float pivot;
  float weight;
  color colorVal;
  float speed;
  float screenDiagonal;

  Line() {
    compose();
  }

  void compose() {
    screenDiagonal = dist(0, 0, width, height);
    angle = random(TWO_PI);
    length = random(screenDiagonal*0.05, screenDiagonal*0.7);
    x = random(width*0.2, width-width*0.2);
    y = random(height*0.2, height-height*0.2);
    pivot = random(-length/2, length/2);
    colorVal = color(176, 0, 0);
    weight = map(length, screenDiagonal*0.05, screenDiagonal*0.7, screenDiagonal/200, screenDiagonal/30);
    speed = random(0.002, 0.01);
  }

  void display(float angleOffset) {
    strokeWeight(weight);
    stroke(colorVal);
    strokeCap(SQUARE);
    pushMatrix();
    translate(x, y); 
    rotate(angle + angleOffset);
    line(-length/2 + pivot, 0, length/2 + pivot, 0);
    popMatrix();
  }
}

