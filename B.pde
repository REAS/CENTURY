
class Morellet60 extends Composition {

  float angle;
  float maxDimension;
  float division;
  float pixelDivision;
  int hashesSquareRT;

  MorelletHash[] hashes = new MorelletHash[400];

  Morellet60() {
    hashesSquareRT = int(sqrt(hashes.length));
    for (int i = 0; i < hashes.length; i++) {
      hashes[i] = new MorelletHash(i);
    }
    compose();
  }

  void compose() {

    if (width > height) {
      maxDimension = width * 1.25;
    } 
    else {
      maxDimension = height * 1.25;
    }

    angle = random(0, TWO_PI);

    division = random(hashesSquareRT/2, hashesSquareRT);
    pixelDivision = maxDimension / division;

    int xindex = 0;
    int yindex = 0;
    int index = 0;
    for (float x = -maxDimension/2; x < maxDimension/2; x += pixelDivision) {
      for (float y = -maxDimension/2; y < maxDimension/2; y += pixelDivision) {
        hashes[index].compose(pixelDivision, xindex, yindex);
        yindex++;
        index++;
      }
      yindex = 0;
      xindex++;
    }

  }

  void display() {
    background(0, 76, 126);

    translate(width/2, height/2);


    int index = 0;

    for (float x = -maxDimension/2; x < maxDimension/2; x += pixelDivision) {
      for (float y = -maxDimension/2; y < maxDimension/2; y += pixelDivision) {
        
        if (dragging) {
          hashes[index].adjust();
        }
        
        hashes[index].display(x, y);
        index++;
      }
    }
  }
}


class MorelletHash {

  float xoff;  // Individual line offset
  float yoff;  // Individual line offset
  float oldxoff;
  float oldyoff;

  float division;

  int id;
  float weight = 8;

  boolean squareHash = false;
  boolean halfHash = false;
  
  float angle;
  
  color colorVal;

  MorelletHash(int _id) {
    id = _id;
    compose(1, 0, 0);
    weight = dist(0, 0, width, height) / 200;
    angle = random(0, TWO_PI);
    colorVal = int(random(204, 255));
  }
  
  void adjust() {
    xoff = oldxoff + cos(angle) * division/8;
    yoff = oldyoff + sin(angle) * division/8;
    angle += dist(mouseX, mouseY, pmouseX, pmouseY) / 60.0;
  }

  void compose(float _division, int xindex, int yindex) {

    squareHash = false;
    halfHash = false;

    division = _division;
    xoff = random(division/6, division/4);
    yoff = random(division/6, division/4);
    oldxoff = xoff;
    oldyoff = yoff;


    if (xindex % 2 == 0) {
      if (yindex % 2 == 0 && random(1) > 0.7) {
        squareHash = true;
        if (random(1) > 0.5) {
          halfHash = true;
        } 
        else {
          halfHash = false;
        }
      } 
      else {
        squareHash = false;
      }
    } 
    else {
      if (yindex % 2 == 0  && random(1) > 0.7) {
        squareHash = false;
      } 
      else {
        if (random(1) > 0.5) {
          halfHash = true;
        } 
        else {
          halfHash = false;
        }
        squareHash = true;
      }
    }
  }

  void update(boolean capture, boolean drag, int px, int py) {
  }

  void display(float x, float y) {

    stroke(colorVal);
    strokeWeight(weight);
    if (squareHash) {

      line(x-division/2+weight/2, y-division/2, x+division/2-weight/2, y-division/2);
      line(x-division/2+weight/2, y, x+division/2-weight/2, y);
      line(x-division/2+weight/2, y+division/2, x+division/2-weight/2, y+division/2);

      if (halfHash) {
        line(x-division/2, y-division/2, x-division/2, y+division/2);
        line(x, y-division/2, x, y+division/2);
        line(x+division/2, y-division/2, x+division/2, y+division/2);
      }
      
    } 
    else {
      line(x-xoff, y-division/2, x-xoff, y+division/2);
      line(x+xoff, y-division/2, x+xoff, y+division/2);
      line(x-division/2, y-yoff, x+division/2, y-yoff);
      line(x-division/2, y+yoff, x+division/2, y+yoff);
    }
  }
}


