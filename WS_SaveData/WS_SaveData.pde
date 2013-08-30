/*
Processing for Android code that writes mouse data to a file on the sdcard of the device
Using buffered writer ensures that new values are added to the file instead of over-writing them
Tip: install something like 'Astro' on your android device to make it super easy to find the text file on the SD card
*/

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.File;
import java.io.BufferedReader;
import java.io.FileReader;

// Android fonts
String[] fontList;
PFont androidFont;
int sh;
int sw;
int mouse_x;
 
void setup() {
   size(displayWidth,displayHeight,P3D);
  sw = displayWidth;
  sh = displayHeight;
  // Sketch stays in portrait mode, even when the phone is rotated
  orientation(PORTRAIT);
  // Select a font to use
  fontList = PFont.list();
  androidFont = createFont(fontList[0], 26, true);
  textFont(androidFont);
}
 
void draw() {
   background(0);
  fill(255);
  text(mouse_x,width/2,height/2.5); //display mouse X position on screen
}
 
void mousePressed() {
  mouse_x = mouseX;
  background(0);
  //write mouseX value to a file on the SD card
 try {
    BufferedWriter writer = new BufferedWriter(new FileWriter("//sdcard//datafile.txt", true)); //set up file to write to
    writer.write(mouseX + "\n");

    writer.flush();
    writer.close();
  }
  catch (IOException ioe) {
    println("error: " + ioe);
  }
 
}
