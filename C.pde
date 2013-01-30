
class Riley61 extends Composition {

  float gap;
  float pinchX;
  float baseGap;
  float spacer;
  float divide = 10;
  
  float grayOff1, grayOff2, grayOff3, grayOff4;

  Riley61 () {
    compose();
  }

  void compose() {
    pinchX = random(width*0.25, width*0.75);
    divide = random(10, 30);
    setGap(divide);  
    grayOff1 = random(0, TWO_PI);
    grayOff2 = random(0, TWO_PI);
    grayOff3 = random(0, TWO_PI);
    grayOff4 = random(0, TWO_PI);
  }

  void setGap(float divide) {
    if (width >= height) {
      baseGap = width / divide;
    } 
    else {
      baseGap = height / divide;
    }
    spacer = baseGap;
  }

  void display() {
    
    if (dragging) {
       pinchX = float(x);
       divide = map(mouseY, 0, height, 10, 40);
       setGap( divide );
    }
    
    background(0);
    noStroke();
    fill(0);

    float gap = 0;
    float angle = 0;
    int counter = 0;
    float offset = 0;
    float secondX = 0;
    int xCounter = 0;

    for (float y = 0; y < height + baseGap; y+= baseGap) {

      if (counter % 2 != 0) { 
        offset = abs(pinchX - secondX)/2;
      } 
      else {
        offset = 0;
      } 
      xCounter = 0;

      // Before the pinch
      for (float x = pinchX-offset; x > 0-baseGap*3; x-= gap+spacer) {
        if (xCounter == 1) {
          secondX = x;
        }
        angle = map(x, 0, pinchX, 0, HALF_PI);
        gap = cos(angle) * (baseGap-5);
        float startVal = map(y, 0, height+baseGap, grayOff1, grayOff2); 
        fill(255 - (abs(cos(startVal)) * cos(angle) * 255));
        ellipse(x, y, gap + 5, baseGap);
        xCounter++;
      }

      // After the pinch
      for (float x = pinchX+offset; x < width+baseGap+baseGap; x+= gap+spacer) {
        angle = map(x, pinchX, width, HALF_PI, 0);
        gap = cos(angle) * (baseGap-5);
        float startVal = map(y, 0, height+baseGap, grayOff3, grayOff4); 
        fill(255 - (abs(cos(startVal)) * cos(angle) * 255));
        ellipse(x, y, gap + 5, baseGap);
      }

      counter++;
    } 

    counter = 0;
  }
}



class Reily94 {
}

