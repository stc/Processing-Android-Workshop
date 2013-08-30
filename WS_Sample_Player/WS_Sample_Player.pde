/*

 Kind of a cheap akai MPC, play with your finger.
 You need samples (.wav or .mp3) on your sdcard 
 You need to deconnect your Sdcard from the computer to have access to the sample ! 
 
 
 */

import android.media.AudioManager;
import android.media.MediaPlayer;
import android.os.Environment;
import android.content.Context;
import java.io.IOException;

/************************************************************************
 
 --------------------------------  DATAS ---------------------------------
 
 *************************************************************************/

String[] fontList;
PFont androidFont;    
//final String LOG_TAG = "AudioRecordTest";
int text_size = 21;
// number of buttons
int nb = 6;
PlayButton  [] mPlayButton = new PlayButton[nb];
MediaPlayer  [] mPlayer = new MediaPlayer[nb];
String [] mFileName = new String[nb];
color currentcolor;
// width and height
int sw, sh;

/************************************************************************
 
 --------------------------------  SETUP ---------------------------------
 
 *************************************************************************/
void setup() {
  size(displayWidth, displayHeight, P3D);
  sw = displayWidth;
  sh = displayHeight;
  
  background(0);
  smooth();
  orientation(PORTRAIT);

  // font choice
  fontList = PFont.list();
  androidFont = createFont(fontList[0], text_size, true);
  textFont(androidFont);

  // Define and create circle button
  color buttoncolor = color(204);
  color highlight = color(255, 53, 0);
  ellipseMode(CENTER);

  //------------------------------------------
  // build a kind of matrix with on for loop
  //------------------------------------------
  int pas_W = 1;
  int pas_H = 1;

  for (int i=0; i<nb; i++) {

    //If 'i' divides by 3 with no remainder and different from 0, pass to the next line
    if (i%3 == 0 && i!=0) { 
      pas_W = 1;
      pas_H ++;
    }

    mPlayButton[i] = new PlayButton(
    pas_W * (sw/4), 
    pas_H * (sh/5), 
    60, 
    buttoncolor, 
    highlight, 
    i);

    pas_W ++;

    // button number is the same as the sample number on the sdcard
    String num = nf(i, 2);
    // external wavs
    mFileName[i] = Environment.getExternalStorageDirectory().getAbsolutePath();
    mFileName[i]+= "/Music/num" + num + ".wav";
    
    
  }
}
/************************************************************************
 
 --------------------------------  DRAW ---------------------------------
 
 *************************************************************************/

void draw() {
  background(0);

  for (int i=0; i<nb; i++) {
    // on affiche les boutons et si les conditions sont reunies, on joue le sample
    mPlayButton[i].display();
    mPlayButton[i].playON();
  }
}
/************************************************************************
 
 --------------------------------  EXIT ---------------------------------
 
 *************************************************************************/
void onPause() {
  super.onPause();
  for (int i=0; i<nb; i++) {
    if (mPlayer[i] != null) {
      mPlayer[i].release();
      mPlayer[i] = null;
    }
  }
}
/************************************************************************
 
 --------------------------------  EVENTS ---------------------------------
 
 *************************************************************************/
void onPlay(boolean start, int num) {
  if (start) {
    startPlaying(num);
  } 
  else {
    stopPlaying(num);
  }
}

void startPlaying(int num) {

  mPlayer[num] = new MediaPlayer();
  if (mFileName[num] != null) {
    try {
      mPlayer[num].setDataSource(mFileName[num]);
      mPlayer[num].setAudioStreamType(AudioManager.STREAM_MUSIC);
      mPlayer[num].prepare();
      mPlayer[num].start();
      println("prepare ok");
    } 
    catch (IOException e) {
     println("prepare() failed");
    }
  }
}

void stopPlaying(int num) {
  mPlayer[num].stop();
  mPlayer[num].release();
  mPlayer[num] = null;
}

