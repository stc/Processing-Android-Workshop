/*

	Sketch to receive osc message from the android phone

*/

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

float _X, _Y, _Z;
float smoothX, smoothY, smoothZ; 
float easing = 0.05;

void setup(){
	size(400, 400, P3D);
	frameRate(25);
	strokeWeight(4);
	
	oscP5 = new OscP5(this, 12000);
	// change your address here
	myRemoteLocation = new NetAddress("192.168.0.12");
}

void draw(){
	background(246, 255, 0);
	smoothX += (_X - smoothX) * easing;
	smoothY += (_Y - smoothY) * easing;
	smoothZ += (_Z - smoothZ) * easing;

	float x = map(smoothX, -10, 10, 0, HALF_PI);
	float y = map(smoothY, -10, 10, 0, HALF_PI);
	float z = map(smoothZ, -10, 10, 0, HALF_PI);

	translate(width/2, height/2);
	rotateX(x);
	rotateY(y);
	rotateZ(z);
	box(100);
}

void oscEvent(OSCmessage theOscMessage){

	if(theOscMessage.checkAddrPattern("/android")){
		_X = theOscMessage.get(0).floatValue();
		_Y = theOscMessage.get(1).floatValue();
		_Z = theOscMessage.get(2).floatValue();
	}
}
