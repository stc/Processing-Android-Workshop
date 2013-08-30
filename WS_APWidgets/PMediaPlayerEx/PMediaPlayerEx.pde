import apwidgets.*;

PMediaPlayer player;

void setup() {

  player = new PMediaPlayer(this); //create new PMediaPlayer
  player.setMediaFile("groupe2_osj.mp3"); //set the file (files are in data folder)
  player.start(); //start play back
  player.setLooping(true); //restart playback end reached
  player.setVolume(1.0, 1.0); //Set left and right volumes. Range is from 0.0 to 1.0

}

void draw() {

  background(0); //set black background
  text(player.getDuration(), 10, 10); //display the duration of the sound
  text(player.getCurrentPosition(), 10, 30); //display how far the sound has played

}

void keyPressed() {

  if (key == CODED) {
    if (keyCode == LEFT) {
      player.seekTo(0); //"rewind"
    }
    else if (keyCode == RIGHT) {
      player.start(); //start playing sound file
    }
    else if (keyCode == DPAD) {
      player.pause(); //pause player
    }
    else if (keyCode == DOWN) {
      player.setMediaFile("test2.mp3"); //switch to other sound file
    }
  }
}

//The MediaPlayer must be released when the app closes
public void onDestroy() {

  super.onDestroy(); //call onDestroy on super class
  if(player!=null) { //must be checked because or else crash when return from landscape mode
    player.release(); //release the player

  }
}
