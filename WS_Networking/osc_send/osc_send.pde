/*

  Sketch to send osc message from the android phone

*/

import apwidgets.*;
import edu.uic.ketai.inputService.*;
import android.content.pm.ActivityInfo;

// OSC
OscP5 oscP5;
// A list to contain the address for sending osc messages 
NetAddressList myAddresses;

KetaiSensorManager sensorManager;
PWidgetContainer widgetContainer; 
PEditText textField;

String[] fontList;
// for now this is your address
String address = "192.168.1.125";
PFont androidFont;
int text_size = 32;
Float azimuth, pitch, roll;

void setup() {
  size(displayWidth,displayHeight,P3D);

  // Set this so the sketch won't reset as the phone is rotated:
  orientation(PORTRAIT);
  // Setup Fonts:
  fontList = PFont.list();
  androidFont = createFont(fontList[0], text_size, true);
  textFont(androidFont);
  // OSCP5
  oscP5 = new OscP5(this, 12000);
  // A list of adresses containing always one address but that you change using textField and mousePressed
  myAddresses = new NetAddressList();
  myAddresses.add(address, 12000);

  sensorManager = new KetaiSensorManager(this);
  sensorManager.start();

  widgetContainer = new PWidgetContainer(this); //create new container for widgets
  textField = new PEditText(20, 220, 150, 50); //create a textfield from x- and y-pos., width and height
  widgetContainer.addWidget(textField); //place textField in container
}

//-----------------------------------------------------------------------------------------

void draw() {
  background(200);

  // print values depending upon the Accelerometer
  if (azimuth != null) {  
    text(nfp(azimuth, 1, 1), 20, 40);
    text(nfp(pitch, 1, 1), 20, 80);
    text(nfp(roll, 1, 1), 20, 120);  
    if (myAddresses != null) {
      oscP5.send("/android", new Object[] {
        new Float(azimuth), new Float(pitch), new Float(roll)
      }
      , myAddresses.get(0));
    }
  }

  else {
    text("Accelerometer: null", 8, 20);
  }
  textSize(14);
  text("the new address to send is :", 20, 160);
  text(textField.getText(), 20, 200); //display the text in the text field
}

// take the new address from the textfield
void mousePressed() {
  myAddresses.remove(address, 12000);
  address = textField.getText();
  myAddresses.add(address, 12000);
}


void onAccelerometerSensorEvent(long time, int accuracy, float x, float y, float z)
{
  azimuth = x;
  pitch = y;
  roll = z;
}

