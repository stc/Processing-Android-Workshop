import apwidgets.*;

PWidgetContainer widgetContainer; 
PButton button1;
PButton button2;
int rectSize = 100;

void setup(){
  
  widgetContainer = new PWidgetContainer(this); //create new container for widgets
  button1 = new PButton(10, 10, "Smaller"); //create new button from x- and y-pos. and label. size determined by text content
  button2 = new PButton(10, 60, 100, 50, "Bigger"); //create new button from x- and y-pos., width, height and label
  widgetContainer.addWidget(button1); //place button in container
  widgetContainer.addWidget(button2); //place button in container
  
}

void draw(){
  
  background(0); //black background
  
  //the size of the rectangle is controlled with the buttons
  rect(50, 20, rectSize, rectSize); 
}

//onClickWidget is called when a widget is clicked/touched
void onClickWidget(PWidget widget){
  
  if(widget == button1){ //if it was button1 that was clicked
    rectSize = 100; //set the smaller size
  }else if(widget == button2){ //or if it was button2
    rectSize = 200; //set the bigger size
  }
  
}
