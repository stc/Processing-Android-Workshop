import android.view.MotionEvent;
import java.util.Iterator;

// The main detector object
TouchProcessor touch;

// rotation and zoom accumulators
float r;
float z = 1;

// box position
float bx;
float by;

// Used for text color
boolean DRAG;
boolean ROTATE;
boolean PINCH;
boolean MULTI_DRAG;
boolean TAP;
boolean DOUBLE_TAP;
boolean FLICK;

//-------------------------------------------------------------------------------------
void setup() { 
  strokeWeight(2);
  touch = new TouchProcessor();
}

//-------------------------------------------------------------------------------------
void draw() {
  background(0);

  // reset gesture flags
  FLICK = TAP = DOUBLE_TAP = ROTATE = DRAG = MULTI_DRAG = PINCH = false;

  // I do the analysis and event processing inside draw, since I found that on Android 
  // trying to draw from outside the main thread can cause pretty serious screen flickering 
  // devices
  touch.analyse();
  touch.sendEvents();
 
  textSize(20);  
  ArrayList touchPoints = touch.getPoints();
  drawPoints(touchPoints);
  drawLines(touchPoints);
  
  // show which gestures have been triggered using text labels 
  int s = 25;
  textSize(s);
  if (DRAG) fill(255); 
  else fill(64);
  text("DRAG", 10, 5+s);
  if (MULTI_DRAG) fill(255); 
  else fill(64);
  text("MULTI_DRAG", 10, 5+s*2);
  if (ROTATE) fill(255); 
  else fill(64);
  text("ROTATE", 10, 5+s*3);
  if (PINCH) fill(255); 
  else fill(64);
  text("PINCH", 10, 5+s*4);
  if (TAP) fill(255); 
  else fill(64);
  text("TAP", 10, 5+s*5);
  if (DOUBLE_TAP) fill(255); 
  else fill(64);
  text("DOUBLE_TAP", 10, 5+s*6);
  if (FLICK) fill(255); 
  else fill(64);
  text("FLICK", 10, 5+s*7);

  // draw a box that can be translated, scaled and rotated using gestures
  rectMode(CENTER);
  translate(width/2 + bx, height/2 + by);
  scale(z);
  rotate(r);
  stroke(255);
  noFill(); 
  rect(0, 0, 200, 200);
} 

//-------------------------------------------------------------------------------------
// MULTI TOUCH EVENTS!

void onTap( TapEvent event ) {
  if ( event.isSingleTap() ) {
    ellipse(event.x, event.y, 200, 200);
    TAP = true;
  }  
  if ( event.isDoubleTap() ) {
    rectMode(CENTER);
    rect(event.x, event.y, 200, 200);
    DOUBLE_TAP = true;
  }
}

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
void onFlick( FlickEvent event ) {
  println("FLICK! " + event.velocity.mag() );
  FLICK = true;
}

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
void onDrag( DragEvent event ) { 
  if (event.numberOfPoints == 1) {
    DRAG = true;    
    bx += event.dx;
    by += event.dy;
  }
  else MULTI_DRAG = true;  
}

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
void onRotate( RotateEvent event ) {
  ROTATE = true;
  r += event.angle;
}

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
void onPinch( PinchEvent event ) {
  PINCH = true;  
  z += event.amount * 0.003;
}

//-------------------------------------------------------------------------------------
// This is the stock Android touch event 
boolean surfaceTouchEvent(MotionEvent event) {
  
  // extract the action code & the pointer ID
  int action = event.getAction();
  int code   = action & MotionEvent.ACTION_MASK;
  int index  = action >> MotionEvent.ACTION_POINTER_ID_SHIFT;

  float x = event.getX(index);
  float y = event.getY(index);
  int id  = event.getPointerId(index);

  // pass the events to the TouchProcessor
  if ( code == MotionEvent.ACTION_DOWN || code == MotionEvent.ACTION_POINTER_DOWN) {
    touch.pointDown(x, y, id);
  }
  else if (code == MotionEvent.ACTION_UP || code == MotionEvent.ACTION_POINTER_UP) {
    touch.pointUp(event.getPointerId(index));
  }
  else if ( code == MotionEvent.ACTION_MOVE) {
    int numPointers = event.getPointerCount();
    for (int i=0; i < numPointers; i++) {
      id = event.getPointerId(i);
      x = event.getX(i);
      y = event.getY(i);
      touch.pointMoved(x, y, id);
    }
  } 

  return super.surfaceTouchEvent(event);
}

//-------------------------------------------------------------------------------------
void drawPoints(ArrayList touchPoints) {
  // show each points with their coordinate and ID
  Iterator i = touchPoints.iterator();
  while (i.hasNext ()) {
    TouchPoint p = (TouchPoint)i.next();
    float diameter = 50;
    stroke(0, 255, 0);
    noFill();
    ellipse(p.x, p.y, diameter, diameter);
    fill(0, 255, 0);
    ellipse(p.x, p.y, 8, 8);
    text( ("ID:"+ p.id + " " + int(p.x) + ", " + int(p.y) ), p.x-128, p.y-64);
  }

  // show the centroid of the gesture
  if (touchPoints.size() > 1 ) {
    stroke(255);
    fill(255, 0, 0);
    ellipse(touch.cx, touch.cy, 15, 15);
  }
}

//-------------------------------------------------------------------------------------
void drawLines(ArrayList touchPoints) {
  // draw lines between points and shows the midpoint + distances
  for (int i=0; i < touchPoints.size(); i++) {
    for (int j=0; j < touchPoints.size(); j++) {
      if (i != j) {
        TouchPoint p1 = (TouchPoint)touchPoints.get(i);
        TouchPoint p2 = (TouchPoint)touchPoints.get(j);
        stroke(0, 0, 255);
        line(p1.x, p1.y, p2.x, p2.y);
        float mx = (p2.x - p1.x)/2 + p1.x;
        float my = (p2.y - p1.y)/2 + p1.y;
        fill(255);
        text( dist(p1.x, p1.y, p2.x, p2.y), mx + 20, my);
        stroke(255);
        noFill();
        ellipse(mx, my, 10, 10);
      }
    }
  }
}

