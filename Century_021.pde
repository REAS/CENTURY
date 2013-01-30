/**
 * 
 * Century
 * 
 */

import java.awt.Robot;
import java.awt.AWTException;

Robot robot;


Composition[] comps;
int[] order;
int[] randomOrder;

int newTimer = 0;
int nextTimer = 0;
int nextComposition = 1000;

int doubleTimer = 500;
int numClicks = 0;

int nextMicroTimer = 0;
int nextMicro = 100;

int current = 0;
int lastCurrent = 0;
int compositionCounter = 0;
int numCompositions = 20;

boolean introHidden = true;  //SM

boolean debug = false;

int movedTimer = 0;

void setup() {
  //size(1280, 720);
  //size(320, 480);
  //size(480, 320);
  size(1024, 768);
  //size(640, 960);
  //size(1024, 768);
  //size(screenWidth, screenHeight);

  try { 
    robot = new Robot();
  } 
  catch (AWTException e) {
    e.printStackTrace();
  }

  smooth();

  comps = new Composition[9];
  order = new int[comps.length];
  randomOrder = new int[comps.length];

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

  //println(randomOrder);

  comps[randomOrder[0]] = new Molnar55();
  comps[randomOrder[1]] = new Morellet60();
  comps[randomOrder[2]] = new Martin();
  comps[randomOrder[3]] = new MetaMetaMalevich();
  comps[randomOrder[4]] = new Riley61();
  comps[randomOrder[5]] = new Molnar();
  comps[randomOrder[6]] = new LeWitt();
  comps[randomOrder[7]] = new Kelly50();
  comps[randomOrder[8]] = new Kelly50_2();
  //comps[9] = new GG();

  current = 0; //comps.length-1;

  nextTimer = millis();

  strokeCap(SQUARE);
}

void draw() {
  
   
  if (frameCount == 1) {
    robot.mouseMove(-width, -height); 
  } else if (frameCount == 2) {
    robot.mouseMove(width/2, height/2); 
    //noCursor();
  }

  // Watch the clock and change to the next Composition
  if ((millis() > nextTimer+nextComposition) && (movedTimer + 1000 < millis())) {
    
    //println(movedTimer + "-" + (millis() + 1000));

    if (compositionCounter >= numCompositions) {
      current++;
      if (current >= comps.length) { 
        current = 0;
      }
      compositionCounter = 0;
      // ADD SOMETHING THERE TO SET A FIRST VARIABLE FOR A NEW COMPOSITION!!!
    }

    // Iterate to the next version of the current Composition
    comps[current].compose();
    comps[current].manage();

    nextTimer = millis();
    compositionCounter++;
  }

  // Update and display the current composition
  //if (mousePressed == true) {
    comps[current].manage();
  //}

  if (debug) {
    console();
  }
  
  /*
  strokeWeight(2);
  noFill();
  stroke(255);
  ellipse(mouseX, mouseY, 12, 12);
  stroke(0);
  ellipse(mouseX, mouseY, 8, 8);
  noStroke();
  */
}

void console() {
  noStroke();
  fill(0);
  rect(0, 0, 100, 25);
  fill(255);
  text(int(frameRate), 5, 16);
}

void rawUpdate() {
  comps[current].compose();
  comps[current].manage();
}

void mousePressed() {
  comps[current].pressEvent();
}

void mouseMoved() {
  comps[current].dragEvent();
  numClicks = 0;
  
  movedTimer = millis();
  //println("I moved!" + millis());
}

void mouseReleased() {
  comps[current].releaseEvent();
  nextTimer = millis();
}

void keyPressed() {
  
  if (key == ' ') {
    saveFrame(); 
  }
  
  if (key == CODED) {
    if (keyCode == LEFT) {
      goToPreviousComposition();
    } 
    else if (keyCode == RIGHT) {
      goToNextComposition();
    }
  }
}

void goToPreviousComposition() {	//SM
  current--;
  if (current < 0) {
    current = comps.length - 1;
  }
  compositionCounter = 0;
  comps[current].compose();
  nextTimer = 0; //millis();
  //println("went to previous composition");
}

void goToNextComposition() {	//SM
  current++;
  if (current >= comps.length) { 
    current = 0;
  }
  compositionCounter = 0;
  comps[current].compose();
  nextTimer = 0; //millis();
  //println("went to next composition");
}

