
class Composition {

  int x, y;
  int px, py;
  boolean captured = false;
  boolean dragging = false;
  
  float[] orientation = { 0.0, 0.0, 0.0 };  //SM

  void compose() {
  }

  void manage() {
    update();
    display();
  }

  void update() {
  }

  void display() {
  }

  void pressEvent() {
    captured = true;
    x = mouseX;
    y = mouseY; 
    px = mouseX;
    py = mouseY;
  }

  void dragEvent() {
    captured = true;
    dragging = true;
    x = mouseX;
    y = mouseY;
  }

  void releaseEvent() {
    dragging = false;
    captured = false;
  }

  void setOrientation(float[] vals) {	//SM
    orientation = vals;
  }
}

