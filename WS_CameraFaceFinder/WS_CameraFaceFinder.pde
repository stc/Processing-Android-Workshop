import ketai.camera.*;
import ketai.cv.facedetector.*;

KetaiCamera cam;

KetaiSimpleFace[] faces;  
boolean findFaces = false;

void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 640, 480, 24);
   cam.setCameraID(1);  //  front camera
  rectMode(CENTER);  
  stroke(0, 255, 0);
  noFill();  
}

void draw() {
  background(0);
  
  if (cam != null)
  {
    image(cam, 0, 0, 640, 480);
    if (findFaces) 
    {
      faces = KetaiFaceDetector.findFaces(cam, 20);
      for (int i=0; i < faces.length; i++) 
      {
        rect(faces[i].location.x, faces[i].location.y, 
        faces[i].distance*2, faces[i].distance*2);  
      }
      text("Faces found: " + faces.length, 680, height/2);
    }
  }
}

void mousePressed ()
{
  if(!cam.isStarted())
    cam.start();
    
  if (findFaces)
    findFaces = false;
  else 
    findFaces = true;
}

void onCameraPreviewEvent()
{
  cam.read();
}
