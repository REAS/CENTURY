
class GG extends Composition {

  int maxDim = width;
  
  GG() {
    compose();
  }

  void compose() {
    if (width > height) {
      maxDim = width; 
    } else {
      maxDim = height; 
    }
  }

  void display() {
    background(255);
    noStroke();
    fill(0);
    
    for (int i = 0; i < 6; i++) {
      randGrid(); 
    }
    
    
    
    
  }
  
  void randGrid() {
    
    int min = 8;
    int max = 64;
    //int expon = int(random(3, 5));
    //int unit = int(pow(2, expon));
    int unit = int(random(min, max));
    float ss = map(unit, min, max, 5, 3);
    float sp = map(unit, min, max, .4, .2);
    float gr = map(unit, min, max, 255, 0);
    
    for (int x = unit; x < width-unit; x += unit) {
      for (int y = unit; y < height-unit; y += unit) {
        //point(x, y);
        if (random(1) > sp) {
          fill(0);
          rect(x, y, ss, ss);
        }
      } 
    }
  }
  
}

