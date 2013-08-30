import apwidgets.*;

PWidgetContainer widgetContainer; 
PCheckBox checkBox;

void setup(){
  
  widgetContainer = new PWidgetContainer(this); //create new container for widgets
  checkBox = new PCheckBox(10, 200, "Show rectangle"); //create new checkbox from x- and y-pos. and label.
  widgetContainer.addWidget(checkBox); //place checkbox in container
  checkBox.setChecked(true); //checkbox is checked from the beginning
  
}

void draw(){
  
  background(0); //black background
  
  if(checkBox.isChecked()){ //if the checkbox is checked
    rect(50, 20, 100, 100); // draw the rectangle
  }
}
