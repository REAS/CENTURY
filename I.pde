
class Kelly50_2 extends Composition {

  int unit = 1;
  int divisor = 40;
  int[] seeds;
  boolean flip = true;

  int ppow = 4;

  Kelly50_2() {
    compose();
  }

  void compose() {

    divisor = 60;

    if (width > height) {
      unit = width/divisor;
      seeds = new int[(width/unit)+2];
    } 
    else {
      unit = height/divisor;
      seeds = new int[(height/unit)+2];
    }

    int index = 0;
    for (int x = 0; x < width+unit; x+=unit) {
      seeds[index] = int(random(0, 10000));
      index++;
    }

    ppow = int(random(1, 11));
    
    if (random(1) > 0.5) {
      flip = !flip; 
    }
  }

  void display() {

    if (flip) {
      background(0);
      fill(255);
    } else {
      background(255);
      fill(0);
    }
    noStroke();
    

    int index = 0;
    for (int x = 0; x < width+unit; x+=unit) {

      if (dragging && mouseX > x && mouseX < x+unit) {
        seeds[index] = frameCount;
      } 
      randomSeed(seeds[index]);

      float p = map(x, 0, width, 0, 1);
      p = pow(p, ppow);
      for (int y = 0; y < height+unit; y+=unit) {
        if (random(1) < p) {
          rect(x, y, unit, unit);
        }
      }
      index++;
    }
  }
}



class Kelly50 extends Composition {

  PGraphics pg;
  int maxCuts = 9;
  int numCuts = 1;
  PImage[] imgs = new PImage[maxCuts];
  int[] randomOrder = new int[maxCuts];
  int[] order = new int[maxCuts];
  float[] xpos = new float[maxCuts];
  float[] origxpos = new float[maxCuts];
  int cuts = maxCuts;
  int cutWidth = 100;
  float quadHeight = 10;
  color backgroundColor = color(176, 0, 0);

  Kelly50() {
    compose();
  }

  void compose() {
    
    pg = createGraphics(width, height, JAVA2D);

    if (width > height) {
      quadHeight = width/20;

    } 
    else {
      quadHeight = height/20;
    }

    pg.beginDraw();
    pg.smooth();
    pg.background(backgroundColor);
    pg.noStroke();
    pg.fill(255);
    kellyQuad();
    kellyQuad();
    kellyQuad();
    kellyQuad();
    kellyQuad();
    pg.endDraw();

      numCuts = int(random(4, maxCuts+1));
      cutWidth = width / numCuts;

    // Start algorithm for sorting the values randomly
    // This was tested in "randomOrder_2"

    for (int i = 0; i < numCuts; i++) {
      if (i == numCuts-1) {
        imgs[i] = pg.get(i * cutWidth, 0, cutWidth, height);
      } 
      else {
        imgs[i] = pg.get(i * cutWidth, 0, cutWidth+maxCuts, height);
      }
      origxpos[i] = i * cutWidth;
    }

    randomOrder = new int[numCuts];
    order = new int[numCuts];

    for (int i = 0; i < order.length; i++) {
      order[i] = i;
    }

    for (int r = 0; r < randomOrder.length; r++) {
      int nextRand = 1;
      if (r == 0) {
        nextRand = int(random(1, order.length));
      } 
      else {
        nextRand = int(random(0, order.length));
      }
      randomOrder[r] = order[nextRand];

      for (int i = 0; i < order.length; i++) {
        if (i == nextRand) {
          for (int j = nextRand; j < order.length-1; j++) {
            order[j] = order[j+1];
          }
        }
      }
      order = shorten(order);
    }

    for (int i = 0; i < numCuts; i++) {
      xpos[i] = randomOrder[i] * cutWidth;
    }
  }

  void kellyQuad() {
    float y1 = random(height);
    float y2 = random(height);
    pg.beginShape();
    pg.vertex(0, y1);
    pg.vertex(0, y1 + random(quadHeight*0.25, quadHeight*0.75));
    pg.vertex(width, y2 + random(quadHeight*0.5, quadHeight));
    pg.vertex(width, y2);
    pg.endShape();
  }

  void display() {
    background(backgroundColor);

    for (int i = 0; i < numCuts; i++) {
      float xx = xpos[i];
      if (dragging) {
        xx = map(mouseX, 0, width, xpos[i], origxpos[i]);
      } 
      image(imgs[i], xx, 0);
    }
  }
}

