import ketai.sensors.*; 

double longitude, latitude, altitude, accuracy;
KetaiLocation location;
Location uic;

void setup() {
  location = new KetaiLocation(this);
  
  // Location: Prezi HQ, Budapest
  
  uic = new Location("uic");  //(1)
  uic.setLatitude(47.505908);
  uic.setLongitude(19.056660);
  orientation(LANDSCAPE);
  textAlign(CENTER, CENTER);
  textSize(36);
}

void draw() {
  background(78, 93, 75);
  if (location.getProvider() == "none") {
    text("Location data is unavailable. \n" +
      "Please check your location settings.", 0, 0, width, height);
  } else {
    float distance = round(location.getLocation().distanceTo(uic));  //(2)
    text("Location data:\n" + 
      "Latitude: " + latitude + "\n" + 
      "Longitude: " + longitude + "\n" + 
      "Altitude: " + altitude + "\n" +
      "Accuracy: " + accuracy + "\n" +
      "Distance to Prezi HQ, Budapest: "+ distance + " m\n" + 
      "Provider: " + location.getProvider(), 20, 0, width, height);
  }
}

void onLocationEvent(Location _location)  //(3)
{
  //print out the location object
  println("onLocation event: " + _location.toString());  //(4)
  longitude = _location.getLongitude();
  latitude = _location.getLatitude();
  altitude = _location.getAltitude();
  accuracy = _location.getAccuracy();
}
