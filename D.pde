
class Martin extends Composition {

  int gridWidth;
  int gridHeight;
  int xoffset = 0;
  int yoffset = 0;

  int xmax = 0;
  int ymax = 0;

  float xdiv = 0;
  float ydiv = 0;

  int strongX = 0;

  color bgcolor;
  color strokeColor = color(51, 45, 30);

  boolean drawXOutline = false;
  boolean drawYOutline = false;
  boolean drawBlocks = false;

  int xr;
  int yr;

  float maxDistance = 1;

  Martin() {
    compose();
  }

  void compose() {

    maxDistance = dist(0, 0, width, height);

    gridWidth = int(width * random(0.8, 0.95));
    gridHeight = int(height * random(0.8, 0.95));
    xoffset = (width - gridWidth) / 2;
    yoffset = (height - gridHeight) / 2;

    if (width > height) {
      xmax = 40;
      ymax = 80;
    } 
    else {
      xmax = 80;
      ymax = 40;
    }

    xr = int(random(10, xmax));
    yr = int(random(10, ymax));
    setGrid();

    int backrand = int(random(1, 4));
    if (backrand == 1) {
      bgcolor = color(222, 227, 183);
    } 
    else if (backrand == 2) {
      bgcolor = color(227, 222, 183);
    } 
    else if (backrand == 3) {
      bgcolor = color(183, 222, 227);
    }

    drawXOutline = (random(1) > 0.5) ? true : false;
    drawYOutline = (random(1) > 0.5) ? true : false;
    drawBlocks = (random(1) > 0.9) ? true : false;
  }

  void setGrid() {

    if (xr % 2 != 0) {
      xr++;
    }
    if (yr %2 != 0) {
      yr++;
    }

    xdiv = gridWidth / float(xr);
    ydiv = gridHeight / float(yr);

    strongX = 0;
    if (drawBlocks == false) {
      if (int(gridWidth/xdiv) % 4 == 0) {
        strongX = 4;
      }
    }
  }

  void display() {

    if (dragging) {
      float d = dist(mouseX, mouseY, width/2, height/2);
      xr = int(map(abs(mouseX-width/2), 0, width/2, 10, xmax));
      yr = int(map(abs(mouseY-height/2), 0, height/2, 10, ymax)); 
      setGrid();
    }

    background(bgcolor);
    stroke(strokeColor);

    // Grid outline
    if (drawXOutline || strongX > 0) {
      noFill();
      if (strongX > 0) {
        strokeWeight(4);
      } 
      else {
        strokeWeight(1);
      }
      line(xoffset, yoffset, xoffset, yoffset+gridHeight);
      line(xoffset + gridWidth, yoffset, xoffset+gridWidth, yoffset+gridHeight);
    }
    if (!drawBlocks) {
      if (drawYOutline) {
        noFill();
        strokeWeight(1);
        line(xoffset, yoffset, xoffset+gridWidth, yoffset);
        line(xoffset, yoffset+gridHeight, xoffset+gridWidth, yoffset+gridHeight);
      }
    }

    // Grid interior
    if (drawBlocks) {
      noStroke();
      fill(strokeColor);
      for (float y = yoffset + ydiv; y < height-yoffset-2; y+=ydiv*2) {
        //line(xoffset, y, xoffset+gridWidth, y);
        rect(xoffset, y-ydiv/2, gridWidth, ydiv);
      }
    } 
    else {
      strokeWeight(1);
      for (float y = yoffset + ydiv; y < height-yoffset-2; y+=ydiv) {
        line(xoffset, y, xoffset+gridWidth, y);
      }
    }

    int xcounter = 1;
    for (float x = xoffset + xdiv; x < width-xoffset-2; x+=xdiv) {
      if (strongX > 0 & xcounter % 4 == 0) {
        strokeWeight(4);
      } 
      else {
        strokeWeight(1);
      }
      line(x, yoffset, x, yoffset+gridHeight); 
      xcounter++;
    }
  }
}

