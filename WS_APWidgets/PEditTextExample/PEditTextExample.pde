/*
The library into the code folder is apwidgets library re-built 
under ubuntu with eclipse. So maybe it doesn't work under other OS
*/

import apwidgets.*;

PWidgetContainer widgetContainer; 
PEditText textField;

void setup(){
  
  widgetContainer = new PWidgetContainer(this); //create new container for widgets
  textField = new PEditText(20, 100, 150, 50); //create a textfield from x- and y-pos., width and height
  widgetContainer.addWidget(textField); //place textField in container
  
}

void draw(){
  
  background(0); //black background
  
  text(textField.getText(), 10, 10); //display the text in the text field
}
